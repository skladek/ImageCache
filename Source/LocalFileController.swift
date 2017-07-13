import Foundation

protocol LocalFileControllerProtocol {
    func getImage(imageName: String, directory: String?) -> UIImage?
    func saveImage(_ image: UIImage?, fileName: String, directory: String?)
}

class LocalFileController: LocalFileControllerProtocol {

    // MARK: Internal Variables

    let dataWriter: DataWriterProtocol

    let pathConstructor: PathConstructorProtocol

    // MARK: Internal Methods

    init(dataWriter: DataWriterProtocol = DataWriter(), pathConstructor: PathConstructorProtocol = PathConstructor()) {
        self.dataWriter = dataWriter
        self.pathConstructor = pathConstructor
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
