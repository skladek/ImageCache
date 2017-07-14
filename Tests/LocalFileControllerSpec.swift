import Foundation
import Nimble
import Quick

@testable import SKImageCache

class LocalFileControllerSpec: QuickSpec {
    override func spec() {
        describe("LocalFileController") {
            var dataWriter: MockDataWriter!
            var pathConstructor: MockPathConstructor!
            var unitUnderTest: LocalFileController!

            beforeEach {
                dataWriter = MockDataWriter()
                pathConstructor = MockPathConstructor()
                unitUnderTest = LocalFileController(dataWriter: dataWriter, pathConstructor: pathConstructor)
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
