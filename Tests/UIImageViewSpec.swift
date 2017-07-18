import Foundation
import Nimble
import Quick

@testable import SKImageCache

class UIImageViewSpec: QuickSpec {
    override func spec() {
        describe("UIImageView") {
            var imageCache: ImageCache!
            var imageHandler: MockImageHandler!
            var unitUnderTest: UIImageView!

            beforeEach {
                imageCache = ImageCache()
                imageHandler = MockImageHandler()
                unitUnderTest = UIImageView()
            }

            context("setImageFromURL(_:placeholderImageName:)") {
                it("Should set the placeholder image to nil if nil is provided.") {
                    let bundle = Bundle(for: type(of: self))
                    let image = UIImage(named: "testimage", in: bundle, compatibleWith: nil)
                    unitUnderTest.image = image
                    unitUnderTest.setImageFromURL(nil, placeholderImageName: nil)

                    expect(unitUnderTest.image).to(beNil())
                }

                it("Should return nil if no URL is provided") {
                    expect(unitUnderTest.setImageFromURL(nil, placeholderImageName: nil)).to(beNil())
                }
            }

            context("setImageFromURL(_:placeholderImageName:imageCache:imageHandler:)") {
                var cacheConfig: UIImageView.CacheConfig!
                var image: UIImageView.Image!

                beforeEach {
                    cacheConfig = UIImageView.CacheConfig(directory: nil, imageCache: imageCache, imageHandler: imageHandler, skipCache: false)
                    image = UIImageView.Image(placeholderImageName: nil, url: nil)
                }

                it("Should call placeholder image on the image handler") {
                    let _ = unitUnderTest.setImage(image, withCacheConfig: cacheConfig, completion: nil)
                    expect(imageHandler.placeholderImageCalled).to(beTrue())
                }

                it("Should call image with URL on the image handler") {
                    let _ = unitUnderTest.setImage(image, withCacheConfig: cacheConfig, completion: nil)
                    expect(imageHandler.imageWithURLCalled).to(beTrue())
                }
            }

            context("imageCompletion(image:fromCache:imageHandler:)") {
                it("Should not call set image if the image parameter is nil") {
                    unitUnderTest.imageCompletion(image: nil, source: .remote, imageHandler: imageHandler)
                    expect(imageHandler.setImageCalled).to(beFalse())
                }

                it("Should not call dissolve to image if the image parameter is nil") {
                    unitUnderTest.imageCompletion(image: nil, source: .remote, imageHandler: imageHandler)
                    expect(imageHandler.disolveToImageCalled).to(beFalse())
                }

                it("Should call set image on the image handler if the source is not remote and the image is not nil") {
                    let bundle = Bundle(for: type(of: self))
                    let image = UIImage(named: "testimage", in: bundle, compatibleWith: nil)
                    unitUnderTest.imageCompletion(image: image, source: .cache, imageHandler: imageHandler)
                }

                it("Should call dissolve to image on the image handler if the source is remote and the image is not nil") {
                    let bundle = Bundle(for: type(of: self))
                    let image = UIImage(named: "testimage", in: bundle, compatibleWith: nil)
                    unitUnderTest.imageCompletion(image: image, source: .remote, imageHandler: imageHandler)
                }
            }
        }
    }
}
