
import UIKit

protocol ImagesCacheManageProtocol {
    func setObject(image: UIImage, key: String)
    func getObject(key: String) -> UIImage?
}

final class ImagesCacheManager: ImagesCacheManageProtocol {
    
    private let cache = NSCache<NSString, UIImage>()
    
    func setObject(image: UIImage, key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
    
    func getObject(key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }
}
