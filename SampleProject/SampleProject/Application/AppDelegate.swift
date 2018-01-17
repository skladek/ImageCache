import SKImageCache
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.isTranslucent = false
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        ImageCache.shared.useURLPathing = true
        ImageCache.shared.useLocalStorage = true

        #if arch(i386) || arch(x86_64)
            if let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path {
                print("Documents Directory: \(documentsPath)")
            }
        #endif

        ImageCache.shared.useLocalStorage = true

        return true
    }
}

