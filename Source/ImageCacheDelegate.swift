import Foundation

/// The delegate to the image cache.
public protocol ImageCacheDelegate: class {
    /// Requests that the delegate loads the image at the specified URL.
    ///
    /// - Parameters:
    ///   - url: The URL of the requested image.
    ///   - completion: The closure to be executed when the image loading call is completed.
    /// - Returns: The network call task.
    func loadImageAtURL(_ url: URL, completion: @escaping ImageCache.RemoteImageCompletion) -> URLSessionDataTask?
}
