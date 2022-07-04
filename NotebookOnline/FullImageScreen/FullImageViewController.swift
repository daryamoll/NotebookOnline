
import UIKit

class FullImageViewController: UIViewController {
    
    let userImagesLoader = UserImagesLoader()
    
    private enum Constants {
        static let userImageHorisontalOffset = 30
        static let userImageSize = 300
    }
    
    private var userImage: UIImageView = {
       let image = UIImageView()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
    }
}

// MARK: - Set image
extension FullImageViewController {
    func setImage(user: User) {
        userImagesLoader.loadUserImage(userImage: UserImage(user: user, imageURL: user.picture.large)) { result in
            switch result {
                case .success(let image):
                    self.userImage.image = image
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Set constraints
private extension FullImageViewController {
    func setConstraints() {
        view.addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(Constants.userImageSize)
            make.width.equalTo(Constants.userImageSize)
        }
    }
}
