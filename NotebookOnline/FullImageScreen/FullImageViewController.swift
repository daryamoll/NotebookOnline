
import UIKit

class FullImageViewController: UIViewController {
    private var userImage: UIImageView = {
       let image = UIImageView()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        userImage.layer.cornerRadius = userImage.frame.size.width / 2
//        userImage.clipsToBounds = true
        setConstraints()
    }
    
    func setImage(user: User) {
        guard let imageData = try? Data(contentsOf: user.picture.large) else {
            print("Error receving user's image")
            return
        }
        userImage.image = UIImage(data: imageData)
        
    }
    
}

private extension FullImageViewController {
    func setConstraints() {
        view.addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)

        }
    }
}
