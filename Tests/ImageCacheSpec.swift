import Foundation
import Nimble
import Quick

@testable import SKImageCache

class ImageCacheSpec: QuickSpec {
    override func spec() {
        describe("ImageCache") {
            var delegate: MockImageCacheDelegate!
            var mockLocalFileController: LocalFileControllerProtocol!
            var mockNSCache: MockNSCache!
            var unitUnderTest: ImageCache!
            var url: URL!

            beforeEach {
                delegate = MockImageCacheDelegate()
                mockLocalFileController = MockLocalFileController()
                mockNSCache = MockNSCache()
                url = URL(string: "http://example.url/image1.png")!
                unitUnderTest = ImageCache(cache: mockNSCache, localFileController: mockLocalFileController)
                unitUnderTest.delegate = delegate
            }

            context("init()") {
                it("Should set a cache") {
                    unitUnderTest = ImageCache()
                    expect(unitUnderTest.cache).toNot(beNil())
                }
            }

            context("cacheImage(_:forURL:)") {
                it("Should not call set object on the cache if the image is nil") {
                    unitUnderTest.cacheImage(nil, forURL: url)
                    expect(mockNSCache.setObjectCalled).to(beFalse())
                }

                it("Should call set object on the cache if an image is provided") {
                    let bundle = Bundle(for: type(of: self))
                    let image = UIImage(named: "testimage", in: bundle, compatibleWith: nil)
                    unitUnderTest.cacheImage(image, forURL: url)
                    expect(mockNSCache.setObjectCalled).to(beTrue())
                }
            }

            context("emptyCache()") {
                it("Should remove all items from the cache") {
                    unitUnderTest.emptyCache()
                    expect(mockNSCache.removeAllObjectsCalled).to(beTrue())
                }
            }

            context("getImage(url:skipCache:completion:)") {
                it("Should check the cache for an image") {
                    mockNSCache.shouldReturnImage = true
                    let _ = unitUnderTest.getImage(url: url, completion: { (_, _, _) in })
                    expect(mockNSCache.objectForKeyCalled).to(beTrue())
                }

                it("Should return a cached image through the closure if one exists") {
                    mockNSCache.shouldReturnImage = true
                    let _ = unitUnderTest.getImage(url: url, completion: { (image, _, _) in
                        expect(image).toNot(beNil())
                    })
                }

                it("Should return true for the from cache value if an image is returned from the cache") {
                    mockNSCache.shouldReturnImage = true
                    let _ = unitUnderTest.getImage(url: url, completion: { (_, source, _) in
                        expect(source).to(equal(.cache))
                    })
                }

                it("Should not return a value from the cache if skipCache is set to true.") {
                    mockNSCache.shouldReturnImage = true
                    waitUntil { done in
                        let _ = unitUnderTest.getImage(url: url, skipCache: true, completion: { (_, source, _) in
                            expect(source).to(equal(ImageCache.ImageSource.remote))
                            done()
                        })
                    }
                }

                it("Should call loadURL on the delegate if one is set") {
                    mockNSCache.shouldReturnImage = false
                    let _ = unitUnderTest.getImage(url: url, completion: { (_, fromCache, _) in })
                    expect(delegate.loadImageAtURLCalled).to(beTrue())
                }

                it("Should cache the image returned by the delegate at the provided URL before returning through the closure") {
                    unitUnderTest = ImageCache()
                    unitUnderTest.delegate = delegate

                    waitUntil { done in
                        let _ = unitUnderTest.getImage(url: url, completion: { (image, _, _) in
                            expect(unitUnderTest.cache.object(forKey: url.lastPathComponent as AnyObject)).to(be(image))
                            done()
                        })
                    }
                }
            }

            context("removeObjectAtURL(_:)") {
                it("Should call remove object on the cache") {
                    unitUnderTest.removeObjectAtURL(url)
                    expect(mockNSCache.removeObjectCalled).to(beTrue())
                }
            }
        }
    }
}
