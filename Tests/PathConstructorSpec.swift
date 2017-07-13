import Foundation
import Nimble
import Quick

@testable import SKImageCache

class PathConstructorSpec: QuickSpec {
    override func spec() {
        describe("PathConstructor") {
            var fileManager: MockFileManager!
            var unitUnderTest: PathConstructor!

            beforeEach {
                fileManager = MockFileManager()
                unitUnderTest = PathConstructor(fileManager: fileManager)
            }

            context("createDirectoryIfNecessary(path:)") {
                it("Should call file exists on the file manager") {
                    unitUnderTest.createDirectoryIfNecessary(path: "")
                    expect(fileManager.fileExistsCalled).to(beTrue())
                }

                it("Should not call createDirectory if fileExists returns true") {
                    fileManager.fileExists = true
                    unitUnderTest.createDirectoryIfNecessary(path: "")
                    expect(fileManager.createDirectoryCalled).to(beFalse())
                }

                it("Should call createDirectory if fileExists returns false") {
                    fileManager.fileExists = false
                    unitUnderTest.createDirectoryIfNecessary(path: "")
                    expect(fileManager.createDirectoryCalled).to(beTrue())
                }
            }

            context("documentsDirectory()") {
                it("Should return a string that ends with Documents") {
                    let documentsDirectory = unitUnderTest.documentsDirectory()!
                    expect(documentsDirectory.hasSuffix("Documents")).to(beTrue())
                }
            }

            context("filePathString(_:directory:)") {
                it("Should return a string that ends with the directory and file name") {
                    let directory = "test/"
                    let filename = "testFile.png"
                    let pathString = unitUnderTest.filePathString(filename, directory: directory)
                    expect(pathString?.hasSuffix("\(directory)\(filename)")).to(beTrue())
                }
            }

            context("filePathURL(_:directory:)") {
                it("Should return a URL representation of the file path string") {
                    let directory = "test/"
                    let filename = "testFile.png"
                    let pathString = unitUnderTest.filePathString(filename, directory: directory)
                    let pathURL = unitUnderTest.filePathURL(filename, directory: directory)

                    expect(pathURL?.path).to(equal(pathString))
                }
            }
        }
    }
}
