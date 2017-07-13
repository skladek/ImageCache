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
        guard let data = data,
            let directoryPath = pathConstructor.directoryPathString(directory) else {
                return
        }

        pathConstructor.createDirectoryIfNecessary(path: directoryPath)
        if let filePath = pathConstructor.filePathURL(fileName, directory: directory) {
            try? data.write(to: filePath)
        }
    }
}
