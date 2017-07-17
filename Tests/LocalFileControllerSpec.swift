import Foundation
import Nimble
import Quick

@testable import SKImageCache

class LocalFileControllerSpec: QuickSpec {
    override func spec() {
        describe("LocalFileController") {
            var dataWriter: MockDataWriter!
            var fileManager: MockFileManager!
            var pathConstructor: MockPathConstructor!
            var unitUnderTest: LocalFileController!

            beforeEach {
                dataWriter = MockDataWriter()
                fileManager = MockFileManager()
                pathConstructor = MockPathConstructor()
                unitUnderTest = LocalFileController(dataWriter: dataWriter, fileManager: fileManager, pathConstructor: pathConstructor)
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

            context("saveImage(_:fileName:directory:)") {
                it("Should call writeData on the data writer") {
                    unitUnderTest.saveImage(UIImage(), fileName: "test", directory: nil)
                    expect(dataWriter.writeDataCalled).to(beTrue())
                }
            }
        }
    }
}
