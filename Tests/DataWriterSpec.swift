import Foundation
import Nimble
import Quick

@testable import SKImageCache

class DataWriterSpec: QuickSpec {
    override func spec() {
        describe("DataWriter") {
            var pathConstructor: MockPathConstructor!
            var unitUnderTest: DataWriter!

            beforeEach {
                pathConstructor = MockPathConstructor()
                unitUnderTest = DataWriter(pathConstructor: pathConstructor)
            }

            context("writeData(_:fileName:directory:)") {
                it("Should not call createDirectoryIfNeeded if data is nil") {
                    unitUnderTest.writeData(nil, fileName: "Test", directory: nil)
                    expect(pathConstructor.createDirectoryCalled).to(beFalse())
                }

                it("Should call createDirectoryIfNeeded if data is passed in") {
                    unitUnderTest.writeData(Data(), fileName: "Test", directory: nil)
                    expect(pathConstructor.createDirectoryCalled).to(beTrue())
                }

                it("Should call filePathURL on the path constructor if valid data is passed in") {
                    unitUnderTest.writeData(Data(), fileName: "test", directory: nil)
                    expect(pathConstructor.filePathURLCalled).to(beTrue())
                }
            }
        }
    }
}
