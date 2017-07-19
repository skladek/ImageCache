import Foundation
import Nimble
import Quick

@testable import SKImageCache

class LocalImageControllerSpec: QuickSpec {
    override func spec() {
        describe("LocalImageController") {
            var dataWriter: MockDataWriter!
            var fileManager: MockFileManager!
            var image: UIImage!
            var pathConstructor: MockPathConstructor!
            var unitUnderTest: LocalImageController!

            beforeEach {
                dataWriter = MockDataWriter()
                fileManager = MockFileManager()
                pathConstructor = MockPathConstructor()
                unitUnderTest = LocalImageController(dataWriter: dataWriter, fileManager: fileManager, pathConstructor: pathConstructor)

                let bundle = Bundle(for: type(of: self))
                image = UIImage(named: "testimage", in: bundle, compatibleWith: nil)
            }

            context("deleteDirectory(_:)") {
                it("Should call directory path string on the path constructor") {
                    unitUnderTest.deleteDirectory("")
                    expect(pathConstructor.directoryPathStringCalled).to(beTrue())
                }

                it("Should call remove item on the file manager") {
                    unitUnderTest.deleteDirectory("")
                    expect(fileManager.removeItemCalled).to(beTrue())
                }
            }

            context("getImage(imageName:directory:)") {
                it("Should call filePathString on the path constructor") {
                    let _ = unitUnderTest.getImage(imageName: "test", directory: nil)
                    expect(pathConstructor.filePathStringCalled).to(beTrue())
                }
            }

            context("savePNG(_:fileName:directory:)") {
                it("Should call writeData on the data writer") {
                    unitUnderTest.savePNG(image, fileName: "test", directory: nil)
                    expect(dataWriter.writeDataCalled).to(beTrue())
                }

                it("Should not call writeData on the data writer if the image is invalid") {
                    unitUnderTest.savePNG(UIImage(), fileName: "test", directory: nil)
                    expect(dataWriter.writeDataCalled).to(beFalse())
                }
            }

            context("saveJPEG(_:compression:fileName:directory:)") {
                it("Should call writeData on the data writer") {
                    unitUnderTest.saveJPEG(image, compression: 1.0, fileName: "test", directory: nil)
                    expect(dataWriter.writeDataCalled).to(beTrue())
                }

                it("Should not call writeData on the data writer if the image is invalid") {
                    unitUnderTest.saveJPEG(UIImage(), compression: 1.0, fileName: "test", directory: nil)
                    expect(dataWriter.writeDataCalled).to(beFalse())
                }
            }
        }
    }
}
