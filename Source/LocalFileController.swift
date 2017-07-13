import Foundation

class LocalFileController {
    func getImage(imageName: String, directory: String?) -> UIImage? {
        var image: UIImage? = nil

        if let imagePath = filePathString(imageName, directory: directory) {
            image = UIImage(contentsOfFile: imagePath)
        }

        return image
    }

    func saveImage(_ image: UIImage?, forURL url: URL, directory: String?) {
//        if let data = UIImagePNGRepresentation(image),
//            let directoryPath = directoryPathString(directory) {
//
//        }
//
//
//
//
//            let fileName = imageNameFromURL(url) as? String,
//            let filePath = filePathURL(fileName, directory: directory) {
//            do {
//                try data.write(to: filePath)
//            } catch {
//                print(error)
//            }
//        }
    }

    private func createDirectoryIfNecessary(path: String) {
//        let pathExists = FileManager.default.fileExists(atPath: path, isDirectory: true)
//
//        FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
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
