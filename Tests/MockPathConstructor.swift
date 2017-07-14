import Foundation

@testable import SKImageCache

class MockPathConstructor: PathConstructorProtocol {
    var createDirectoryCalled = false
    var directoryPathStringCalled = false
    var filePathStringCalled = false
    var filePathURLCalled = false

    func createDirectoryIfNecessary(path: String) {
        createDirectoryCalled = true
    }

    func directoryPathString(_ directory: String?) -> String? {
        directoryPathStringCalled = true

        return ""
    }

    func filePathString(_ fileName: String, directory: String?) -> String? {
        filePathStringCalled = true

        return ""
    }

    func filePathURL(_ fileName: String, directory: String?) -> URL? {
        filePathURLCalled = true

        return URL(string: "http://example.com")
    }
}
