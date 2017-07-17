import Foundation

@testable import SKImageCache

class MockLocalFileController: LocalFileControllerProtocol {
    var deleteDirectoryCalled = false
    var getImageCalled = false
    var saveImageCalled = false

    func deleteDirectory(_ directory: String) {
        deleteDirectoryCalled = true
    }

    func getImage(imageName: String, directory: String?) -> UIImage? {
        getImageCalled = true

        return UIImage()
    }

    func saveImage(_ image: UIImage?, fileName: String, directory: String?) {
        saveImageCalled = true
    }
}
