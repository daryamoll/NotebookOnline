
import Foundation

final class UserImage {

    var id: String {
        return "\(user.name.last)|\(imageURL.absoluteString)"
    }

    let user: User
    let imageURL: URL

    init(user: User, imageURL: URL) {
        self.user = user
        self.imageURL = imageURL
    }
}
