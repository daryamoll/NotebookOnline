
import UIKit

final class UserImagesLoader {
    
    private let imagesCacheManager = ImagesCacheManager()
    private let networkService = NetworkService()
    
    func loadUserImage(
        userImage: UserImage,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) {
        if let cachedImage = imagesCacheManager.getObject(key: userImage.id) {
            completion(.success(cachedImage))
        }
        
        let task = URLSession.shared.dataTask(with: userImage.imageURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            DispatchQueue.main.async { [self] in
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    imagesCacheManager.setObject(image: imageToCache, key: userImage.id)
                    completion(.success(imageToCache))
                }
            }
        }
        task.resume()
    }
}
