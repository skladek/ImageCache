import Foundation

protocol LocalFileControllerProtocol {
    func deleteDirectory(_ directory: String)
    func getImage(imageName: String, directory: String?) -> UIImage?
    func saveImage(_ image: UIImage?, fileName: String, directory: String?)
}

class LocalFileController: LocalFileControllerProtocol {

    // MARK: Internal Variables

    let dataWriter: DataWriterProtocol

    let fileManager: FileManager

    let pathConstructor: PathConstructorProtocol

    // MARK: Internal Methods

    init(dataWriter: DataWriterProtocol = DataWriter(), fileManager: FileManager = FileManager.default, pathConstructor: PathConstructorProtocol = PathConstructor()) {
        self.dataWriter = dataWriter
        self.fileManager = fileManager
        self.pathConstructor = pathConstructor
    }

    func deleteDirectory(_ directory: String) {
        guard let directoryPath = pathConstructor.directoryPathString(directory) else {
            return
        }

        do {
            try fileManager.removeItem(atPath: directoryPath)
        } catch {
            print(error)
        }
    }

    func getImage(imageName: String, directory: String?) -> UIImage? {
        var image: UIImage? = nil

        if let imagePath = pathConstructor.filePathString(imageName, directory: directory) {
            image = UIImage(contentsOfFile: imagePath)
        }

        return image
    }

    func saveImage(_ image: UIImage?, fileName: String, directory: String?) {
        if let image = image {
            let data = UIImagePNGRepresentation(image)
            dataWriter.writeData(data, fileName: fileName, directory: directory)
        }
    }
}
