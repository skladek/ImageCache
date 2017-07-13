import Foundation

protocol LocalFileControllerProtocol {
    func getImage(imageName: String, directory: String?) -> UIImage?
    func saveImage(_ image: UIImage?, fileName: String, directory: String?)
}

class LocalFileController: LocalFileControllerProtocol {
    func getImage(imageName: String, directory: String?) -> UIImage? {
        var image: UIImage? = nil

        if let imagePath = filePathString(imageName, directory: directory) {
            image = UIImage(contentsOfFile: imagePath)
        }

        return image
    }

    func saveImage(_ image: UIImage?, fileName: String, directory: String?) {
        guard let image = image else {
            return
        }

        if let data = UIImagePNGRepresentation(image),
            let directoryPath = directoryPathString(directory) {
            createDirectoryIfNecessary(path: directoryPath)
            if let filePath = filePathURL(fileName, directory: directory) {
                try? data.write(to: filePath)
            }
        }
    }

    private func createDirectoryIfNecessary(path: String) {
        var isDirectory: ObjCBool = true
        if FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory) == true {
            return
        }

        try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
    }

    private func directoryPathString(_ directory: String?) -> String? {
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

    private func documentsDirectory() -> String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }

    private func filePathString(_ fileName: String, directory: String?) -> String? {
        var path: String? = nil

        if var documentsDirectory = directoryPathString(directory) {
            documentsDirectory.append(fileName)
            path = documentsDirectory
        }

        return path
    }

    private func filePathURL(_ fileName: String, directory: String? = nil) -> URL? {
        var url: URL? = nil

        if let filePath = filePathString(fileName, directory: directory) {
            url = URL(fileURLWithPath: filePath)
        }

        return url
    }
}
