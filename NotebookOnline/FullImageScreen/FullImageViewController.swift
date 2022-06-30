
import UIKit

class FullImageViewController: UIViewController {
    
    let userImagesLoader = UserImagesLoader()
    
    private enum Constants {
        static let userImageHorisontalOffset = 30
        static let userImageVerticalOffset = 150
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

private extension FullImageViewController {
    func setConstraints() {
        view.addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.userImageHorisontalOffset)
            make.trailing.equalToSuperview().offset(-Constants.userImageHorisontalOffset)
            make.top.equalToSuperview().offset(Constants.userImageVerticalOffset)
            make.bottom.equalToSuperview().offset(-Constants.userImageVerticalOffset)
        }
    }
}
