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

            context("trimDirectory(_:)") {
                it("Should replace instances of // in the directory with a single /") {
                    let inputString = "folder1//folder2//folder3//folder4"
                    let output = unitUnderTest.trimDirectory(inputString)

                    expect(output).to(equal("folder1/folder2/folder3/folder4"))
                }

                it("Should return the input string if no instances of // are found") {
                    let inputString = "folder1/folder2/folder3/folder4"
                    let output = unitUnderTest.trimDirectory(inputString)

                    expect(output).to(equal(inputString))
                }

                it("Should return nil if the input is nil") {
                    let output = unitUnderTest.trimDirectory(nil)

                    expect(output).to(beNil())
                }
            }

            context("writeData(_:fileName:directory:)") {
                it("Should not call createDirectoryIfNeeded if data is nil") {
                    unitUnderTest.writeData(nil, fileName: "Test", directory: "")
                    expect(pathConstructor.createDirectoryCalled).to(beFalse())
                }

                it("Should call createDirectoryIfNeeded if data is passed in") {
                    unitUnderTest.writeData(Data(), fileName: "Test", directory: "")
                    expect(pathConstructor.createDirectoryCalled).to(beTrue())
                }

                it("Should call filePathURL on the path constructor if valid data is passed in") {
                    unitUnderTest.writeData(Data(), fileName: "test", directory: "")
                    expect(pathConstructor.filePathURLCalled).to(beTrue())
                }
            }
        }
    }
}
