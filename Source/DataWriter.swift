import Foundation

protocol DataWriterProtocol {
    func writeData(_ data: Data?, fileName: String, directory: String?)
}

class DataWriter: DataWriterProtocol {
    let pathConstructor: PathConstructorProtocol

    init(pathConstructor: PathConstructorProtocol = PathConstructor()) {
        self.pathConstructor = pathConstructor
    }

    func writeData(_ data: Data?, fileName: String, directory: String?) {
        var mutableDirectory = directory

        while mutableDirectory?.range(of: "//") != nil {
            mutableDirectory = mutableDirectory?.replacingOccurrences(of: "//", with: "/")
        }

        guard let data = data,
            let directoryPath = pathConstructor.directoryPathString(mutableDirectory) else {
                return
        }

        pathConstructor.createDirectoryIfNecessary(path: directoryPath)
        if let filePath = pathConstructor.filePathURL(fileName, directory: mutableDirectory) {
            try? data.write(to: filePath)
        }
    }
}
