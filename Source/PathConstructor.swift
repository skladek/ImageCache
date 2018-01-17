import Foundation

protocol PathConstructorProtocol {
    func createDirectoryIfNecessary(path: String)
    func directoryPathString(_ directory: String?) -> String?
    func filePathString(_ fileName: String, directory: String?) -> String?
    func filePathURL(_ fileName: String, directory: String?) -> URL?
}

class PathConstructor: PathConstructorProtocol {

    // MARK: Internal Variables

    let fileManager: FileManager

    // MARK: Init Methods

    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }

    // MARK: Internal Methods

    func createDirectoryIfNecessary(path: String) {
        var isDirectory: ObjCBool = true
        if fileManager.fileExists(atPath: path, isDirectory: &isDirectory) == true {
            return
        }

        try? fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
    }

    func directoryPathString(_ directory: String?) -> String? {
        var path: String? = nil

        if let documentsDirectory = documentsDirectory() {
            path = documentsDirectory
            path?.append("/")

            if let directory = directory {
                path?.append(directory)
            }
        }

        return path
    }

    func documentsDirectory() -> String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }

    func filePathString(_ fileName: String, directory: String?) -> String? {
        var path: String? = nil

        if var documentsDirectory = directoryPathString(directory) {
            documentsDirectory.append(fileName)
            path = documentsDirectory
        }

        return path
    }

    func filePathURL(_ fileName: String, directory: String? = nil) -> URL? {
        var url: URL? = nil

        if let filePath = filePathString(fileName, directory: directory) {
            url = URL(fileURLWithPath: filePath)
        }

        return url
    }
}
