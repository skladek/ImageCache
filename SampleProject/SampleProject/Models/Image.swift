import UIKit

class Image {
    struct DictionaryKeys {
        static let farm = "farm"
        static let id = "id"
        static let isFamily = "isfamily"
        static let isFriend = "isfriend"
        static let isPublic = "ispublic"
        static let owner = "owner"
        static let secret = "secret"
        static let server = "server"
        static let title = "title"
    }

    let farm: Int
    let id: String
    let isFamily: Bool
    let isFriend: Bool
    let isPublic: Bool
    let owner: String
    let secret: String
    let server: String
    let title: String

    init?(dictionary: [String : Any]) {
        guard let farm = dictionary[DictionaryKeys.farm] as? Int,
            let id = dictionary[DictionaryKeys.id] as? String,
            let isFamily = dictionary[DictionaryKeys.isFamily] as? Bool,
            let isFriend = dictionary[DictionaryKeys.isFriend] as? Bool,
            let isPublic = dictionary[DictionaryKeys.isPublic] as? Bool,
            let owner = dictionary[DictionaryKeys.owner] as? String,
            let secret = dictionary[DictionaryKeys.secret] as? String,
            let server = dictionary[DictionaryKeys.server] as? String,
            let title = dictionary[DictionaryKeys.title] as? String else {
                return nil
        }

        self.farm = farm
        self.id = id
        self.isFamily = isFamily
        self.isFriend = isFriend
        self.isPublic = isPublic
        self.owner = owner
        self.secret = secret
        self.server = server
        self.title = title
    }

    func imageURL() -> URL? {
        let urlString = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_c.jpg"

        return URL(string: urlString)
    }
}
