import Foundation

protocol LocalImageControllerProtocol {
    func deleteDirectory(_ directory: String)
    func getImage(imageName: String, directory: String?) -> UIImage?
    func saveJPEG(_ image: UIImage?, compression: CGFloat, fileName: String, directory: String?)
    func savePNG(_ image: UIImage?, fileName: String, directory: String?)
}

/// Provides a controller for managing image files saved to disk.
public class LocalImageController: LocalImageControllerProtocol {

    // MARK: Internal Variables

    let dataWriter: DataWriterProtocol
    let fileManager: FileManager
    let pathConstructor: PathConstructorProtocol

    // MARK: Init Methods

    /// Initializes a local image controller
    public convenience init() {
        self.init(dataWriter: DataWriter(), fileManager: FileManager.default, pathConstructor: PathConstructor())
    }

    init(dataWriter: DataWriterProtocol, fileManager: FileManager, pathConstructor: PathConstructorProtocol) {
        self.dataWriter = dataWriter
        self.fileManager = fileManager
        self.pathConstructor = pathConstructor
    }

    // MARK: Public Methods

    /// Deletes the folder and all contained files at the provided path.
    ///
    /// - Parameter directory: The directory path to delete
    public func deleteDirectory(_ directory: String) {
        if let directoryPath = pathConstructor.directoryPathString(directory) {
            try? fileManager.removeItem(atPath: directoryPath)
        }
    }

    /// Gets an image with the given name and directory.
    ///
    /// - Parameters:
    ///   - imageName: The name of the image to retrieve.
    ///   - directory: The directory path of the image.
    /// - Returns: The retrieved image or nil.
    public func getImage(imageName: String, directory: String?) -> UIImage? {
        var image: UIImage? = nil

        if let imagePath = pathConstructor.filePathString(imageName, directory: directory) {
            image = UIImage(contentsOfFile: imagePath)
        }

        return image
    }

    /// Saves the provided image to disk as a JPEG.
    ///
    /// - Parameters:
    ///   - image: The image to save.
    ///   - compression: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum
    ///        compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).
    ///   - fileName: The name to save the file to.best
    ///   - directory: The directory to save the file within.
    public func saveJPEG(_ image: UIImage?, compression: CGFloat, fileName: String, directory: String?) {
        if let image = image,
            let data = UIImageJPEGRepresentation(image, compression) {
            saveImageData(data, fileName: fileName, directory: directory)
        }
    }

    /// Saves the provided image to disk as a PNG.
    ///
    /// - Parameters:
    ///   - image: The image to save.
    ///   - fileName: The name to save the file to.best
    ///   - directory: The directory to save the file within.
    public func savePNG(_ image: UIImage?, fileName: String, directory: String?) {
        if let image = image,
            let data = UIImagePNGRepresentation(image) {
            saveImageData(data, fileName: fileName, directory: directory)
        }
    }

    // MARK: Private Methods

    private func saveImageData(_ data: Data, fileName: String, directory: String?) {
        dataWriter.writeData(data, fileName: fileName, directory: directory)
    }
}
