import Foundation

@testable import SKImageCache

class MockDataWriter: DataWriterProtocol {
    var writeDataCalled = false

    func writeData(_ data: Data?, fileName: String, directory: String?) {
        writeDataCalled = true
    }
}
