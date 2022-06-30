
import Foundation

struct UserResults: Decodable {
    let results: [User]
}

struct User: Decodable {
    let gender: String
    var name: Name
    var picture: Picture
    let dob: Birthday
    let email: String
    var location: Location
}

struct Name: Decodable {
    let first: String
    let last: String
}

struct Picture: Decodable {
//    let large: URL
//    let medium: URL
    let large: URL
}

struct Birthday: Decodable {
    let date: String
    let age: Int
}

struct Location: Decodable {
    let timezone: Timezone
}

struct Timezone: Decodable {
    let offset: String
}
