import Foundation

protocol DataWriterProtocol {
    func writeData(_ data: Data?, fileName: String, directory: String?)
}

class DataWriter: DataWriterProtocol {
    let pathConstructor: PathConstructorProtocol

    init(pathConstructor: PathConstructorProtocol = PathConstructor()) {
        self.pathConstructor = pathConstructor
    }

    func trimDirectory(_ directory: String?) -> String? {
        var mutableDirectory = directory

        while mutableDirectory?.range(of: "//") != nil {
            mutableDirectory = mutableDirectory?.replacingOccurrences(of: "//", with: "/")
        }

        return mutableDirectory
    }

    func writeData(_ data: Data?, fileName: String, directory: String?) {
        let trimmedDirectory = trimDirectory(directory)

        guard let data = data,
            let directoryPath = pathConstructor.directoryPathString(trimmedDirectory) else {
                return
        }

        pathConstructor.createDirectoryIfNecessary(path: directoryPath)
        if let filePath = pathConstructor.filePathURL(fileName, directory: trimmedDirectory) {
            try? data.write(to: filePath)
        }
    }
}
