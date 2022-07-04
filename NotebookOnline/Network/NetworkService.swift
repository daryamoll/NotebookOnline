
import UIKit

class NetworkService {
    
    var users: [User] = []
    
    let baseURL = "https://randomuser.me/api/?results=1000"

    func getUsers(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: baseURL) else { return }
        
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                if let error = error {
                    print("Error getting users: \(error.localizedDescription)")
                    self.users = StorageManager.shared.readUsers()
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                    do {
                        let newUsers = try JSONDecoder().decode(UserResults.self, from: data)
                        StorageManager.shared.delete()
                        self.users = newUsers.results
                        StorageManager.shared.saveUsers(users: self.users)
                    } catch {
                        print("Error decoding  users: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
            }
        }
    .resume()
    }
}
