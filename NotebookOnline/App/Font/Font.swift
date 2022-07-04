
import UIKit

enum Font {
    case regular20
    case medium20
    
    var font: UIFont? {
        switch self {
            case .regular20:
                return UIFont(name: "Quicksand-Regular", size: 20)
                
            case .medium20:
                return UIFont(name: "Quicksand-Medium", size: 20)
        }
    }
}
