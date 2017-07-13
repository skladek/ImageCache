import Foundation

@testable import SKImageCache

class MockLocalFileController: LocalFileControllerProtocol {
    var getImageCalled = false
    var saveImageCalled = false

    func getImage(imageName: String, directory: String?) -> UIImage? {
        getImageCalled = true

        return nil
    }

    func saveImage(_ image: UIImage?, fileName: String, directory: String?) {
        saveImageCalled = true
    }
}
