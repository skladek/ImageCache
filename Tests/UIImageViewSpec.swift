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
                it("Should call placeholder image on the image handler") {
                    let _ = unitUnderTest.setImageFromURL(nil, placeholderImageName: nil, imageCache: imageCache, imageHandler: imageHandler)
                    expect(imageHandler.placeholderImageCalled).to(beTrue())
                }

                it("Should call image with URL on the image handler") {
                    let _ = unitUnderTest.setImageFromURL(nil, placeholderImageName: nil, imageCache: imageCache, imageHandler: imageHandler)
                    expect(imageHandler.imageWithURLCalled).to(beTrue())
                }
            }

            context("imageCompletion(image:fromCache:imageHandler:)") {
                it("Should not call set image if the image parameter is nil") {
                    unitUnderTest.imageCompletion(image: nil, fromCache: false, imageHandler: imageHandler)
                    expect(imageHandler.setImageCalled).to(beFalse())
                }

                it("Should not call dissolve to image if the image parameter is nil") {
                    unitUnderTest.imageCompletion(image: nil, fromCache: false, imageHandler: imageHandler)
                    expect(imageHandler.disolveToImageCalled).to(beFalse())
                }

                it("Should call set image on the image handler if from cache is true and the image is not nil") {
                    let bundle = Bundle(for: type(of: self))
                    let image = UIImage(named: "testimage", in: bundle, compatibleWith: nil)
                    unitUnderTest.imageCompletion(image: image, fromCache: true, imageHandler: imageHandler)
                }

                it("Should call dissolve to image on the image handler if from cache is false and the image is not nil") {
                    let bundle = Bundle(for: type(of: self))
                    let image = UIImage(named: "testimage", in: bundle, compatibleWith: nil)
                    unitUnderTest.imageCompletion(image: image, fromCache: false, imageHandler: imageHandler)
                }
            }
        }
    }
}
