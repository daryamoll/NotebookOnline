
import UIKit

class UsersTableViewCell: UITableViewCell {
    
    let userImagesLoader = UserImagesLoader()
    
    private enum Constants {
        static let userImageLeadingOffset = 15
        static let userImageSize = 40
        
        static let nameLabelTopOffset = 10
        static let nameLabelHorisontalOffset = 20
    }
    
    private var userImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.regular20.font
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure cell
extension UsersTableViewCell {
    
    func configureCell(user: User) {
        nameLabel.text = user.name.first + " " + user.name.last
        
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
private extension UsersTableViewCell {
    func setConstraints() {
        self.addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(Constants.userImageLeadingOffset)
            make.height.equalTo(Constants.userImageSize)
            make.width.equalTo(Constants.userImageSize)
        }
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.nameLabelTopOffset)
            make.leading.equalTo(userImage.snp.trailing).offset(Constants.nameLabelHorisontalOffset)
            make.trailing.equalToSuperview().offset(-Constants.nameLabelHorisontalOffset)
        }
    }
}
