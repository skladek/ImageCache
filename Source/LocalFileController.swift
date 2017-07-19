import Foundation

protocol LocalFileControllerProtocol {
    func deleteDirectory(_ directory: String)
    func getImage(imageName: String, directory: String?) -> UIImage?
    func saveJPEG(_ image: UIImage?, compression: CGFloat, fileName: String, directory: String?)
    func savePNG(_ image: UIImage?, fileName: String, directory: String?)
}

public class LocalFileController: LocalFileControllerProtocol {

    // MARK: Internal Variables

    let dataWriter: DataWriterProtocol

    let fileManager: FileManager

    let pathConstructor: PathConstructorProtocol

    // MARK: Internal Methods

    public convenience init() {
        self.init(dataWriter: DataWriter(), fileManager: FileManager.default, pathConstructor: PathConstructor())
    }

    init(dataWriter: DataWriterProtocol, fileManager: FileManager, pathConstructor: PathConstructorProtocol) {
        self.dataWriter = dataWriter
        self.fileManager = fileManager
        self.pathConstructor = pathConstructor
    }

    public func deleteDirectory(_ directory: String) {
        if let directoryPath = pathConstructor.directoryPathString(directory) {
            try? fileManager.removeItem(atPath: directoryPath)
        }
    }

    public func getImage(imageName: String, directory: String?) -> UIImage? {
        var image: UIImage? = nil

        if let imagePath = pathConstructor.filePathString(imageName, directory: directory) {
            image = UIImage(contentsOfFile: imagePath)
        }

        return image
    }

    public func saveJPEG(_ image: UIImage?, compression: CGFloat, fileName: String, directory: String?) {
        if let image = image,
            let data = UIImageJPEGRepresentation(image, compression) {
            saveImageData(data, fileName: fileName, directory: directory)
        }
    }

    public func savePNG(_ image: UIImage?, fileName: String, directory: String?) {
        if let image = image,
            let data = UIImagePNGRepresentation(image) {
            saveImageData(data, fileName: fileName, directory: directory)
        }
    }

    func saveImageData(_ data: Data, fileName: String, directory: String?) {
        dataWriter.writeData(data, fileName: fileName, directory: directory)
    }
}
