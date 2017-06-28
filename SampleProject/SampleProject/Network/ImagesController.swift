import SKWebServiceController
import UIKit

class ImagesController {
    func searchImagesFor(_ searchTerm: String?, completion: @escaping ([Image]?, Error?) -> ()) {
        guard let searchTerm = searchTerm else {
            return
        }

        let parameters = [
            "api_key" : kAPI_KEY,
            "format" : "json",
            "is_getty" : true,
            "method" : "flickr.photos.search",
            "nojsoncallback" : true,
            "tags" : searchTerm
        ] as [String : Any]

        let requestConfiguration = RequestConfiguration(queryParameters: parameters)

        FlickrController.shared.get(nil, requestConfiguration: requestConfiguration) { (object, response, error) in
            guard let object = object as? [String : Any] else {
                completion(nil, error)
                return
            }
            guard let photosJSON = object["photos"] as? [String : Any] else {
                completion(nil, error)
                return
            }
            guard let imagesDictionaries = photosJSON["photo"] as? [[String : Any]] else {
                completion(nil, error)
                return
            }

            var images = [Image]()

            for dictionary in imagesDictionaries {
                if let image = Image(dictionary: dictionary) {
                    images.append(image)
                }
            }

            completion(images, error)
        }
    }
}
