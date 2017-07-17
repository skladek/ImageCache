import Foundation
import Nimble
import Quick

@testable import SKImageCache

class PlaceholderImageHandlerSpec: QuickSpec {
    override func spec() {
        describe("PlaceholderImageHandler") {
            var image: UIImage!
            var imageCache: MockImageCache!
            var imageView: UIImageView!
            var unitUnderTest: PlaceholderImageHandler!

            beforeEach {
                let bundle = Bundle(for: type(of: self))
                image = UIImage(named: "testimage", in: bundle, compatibleWith: nil)
                imageCache = MockImageCache()
                imageView = UIImageView()
                unitUnderTest = PlaceholderImageHandler()
            }

            context("dissolveToImage(_:onView:)") {
                it("Should set the provided image on the provided image view.") {
                    unitUnderTest.dissolveToImage(image, onView: imageView)
                    expect(imageView.image).to(be(image))
                }
            }

            context("image(_:imageCache:completion:") {
                it("Should return nil if the URL is nil") {
                    let result = unitUnderTest.image(nil, imageCache: imageCache, directory: nil, skipCache: false, completion: { (_, _, _) in })
                    expect(result).to(beNil())
                }

                it("Should not call getImage on the image cache if the URL is nil") {
                    let _ = unitUnderTest.image(nil, imageCache: imageCache, directory: nil, skipCache: false, completion: { (_, _, _) in })
                    expect(imageCache.getImageCalled).to(beFalse())
                }

                it("Should return a URLSessionDataTask if the URL is provided") {
                    let url = URL(string: "https://example.url")!
                    let result = unitUnderTest.image(url, imageCache: imageCache, directory: nil, skipCache: false, completion: { (_, _, _) in })
                    expect(result).to(beAnInstanceOf(URLSessionDataTask.self))
                }
            }

            context("placeholderImage(_:bundle:)") {
                it("Should return nil if the image name is nil") {
                    let result = unitUnderTest.placeholderImage(nil)
                    expect(result).to(beNil())
                }

                it("Should return nil if the image name is not valid") {
                    let result = unitUnderTest.placeholderImage("invalidImageName")
                    expect(result).to(beNil())
                }

                it("Should return an image if the image name is valid") {
                    let bundle = Bundle(for: type(of: self))
                    let result = unitUnderTest.placeholderImage("testimage", bundle: bundle)
                    expect(result).to(beAnInstanceOf(UIImage.self))
                }
            }

            context("setImage(_:onView:)") {
                it("Should set the provided image on the provided image view.") {
                    unitUnderTest.setImage(image, onView: imageView)
                    expect(imageView.image).to(be(image))
                }
            }
        }
    }
}
