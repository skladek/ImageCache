import Foundation

@testable import SKImageCache

class MockLocalImageController: LocalImageControllerProtocol {
    var defaultImageDirectory = ""

    var deleteDirectoryCalled = false
    var getImageCalled = false
    var savePNGCalled = false
    var saveJPEGCalled = false

    func deleteDirectory(_ directory: String) {
        deleteDirectoryCalled = true
    }

    func getImage(imageName: String, directory: String?) -> UIImage? {
        getImageCalled = true

        return UIImage()
    }

    func saveJPEG(_ image: UIImage?, compression: CGFloat, fileName: String, directory: String?) {
        saveJPEGCalled = true
    }

    func savePNG(_ image: UIImage?, fileName: String, directory: String?) {
        savePNGCalled = true
    }
}
