
import Foundation

final class UserPicture {

    var id: String {
        return "\(imageURL.absoluteString)"
    }

    let user: User
    let imageURL: URL

    init(user: User, imageURL: URL) {
        self.user = user
        self.imageURL = imageURL
    }
}
