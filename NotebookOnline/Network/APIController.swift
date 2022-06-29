
import Foundation

class APIController {
    
    var users: [User] = []
    
    let baseURL = "https://randomuser.me/api/?results=20"
    typealias CompletionHandler = (Error?) -> Void
    
    func getUsers(completion: @escaping CompletionHandler = { _ in }) {
        
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
                if let error = error {
                    print("Error getting users: \(error.localizedDescription)")
                    return
                }
                guard let data = data else {
                    print("No data returned")
                    completion(nil)
                    return
                }
                do {
                    let newUsers = try JSONDecoder().decode(UserResults.self, from: data)
                    print(newUsers)
                    self.users = newUsers.results
                } catch {
                    print("Error decoding  users: \(error.localizedDescription)")
                    completion(error)
                }
            completion(nil)
        }
        .resume()
    }
}
