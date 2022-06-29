
import UIKit

class UsersTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let userImageLeadingOffset = 15
        static let userImageSize = 40
        
        static let nameLabelTopOffset = 10
        static let nameLabelHorisontalOffset = 20
    }
    
    private var userImage: UIImageView = {
        let image = UIImageView()
//        image.clipsToBounds = true
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
    
    func configureCell(user: User) {
        guard let imageData = try? Data(contentsOf: user.picture.thumbnail) else { print("Error receving user's image")
            return
        }
        userImage.image = UIImage(data: imageData)
        nameLabel.text = user.name.first + " " + user.name.last
    }
}

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
