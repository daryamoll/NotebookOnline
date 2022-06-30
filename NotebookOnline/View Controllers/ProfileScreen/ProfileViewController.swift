
import UIKit

class ProfileViewController: UIViewController {
    
    private enum Constants {
        static let userImageTopOffset = 10
        static let userImageSize = 250
        
        static let stackViewTopOffset = 20
        static let stackViewHorisontalOffset = 40
    }
    
    private enum Text {
        static let nameLabel = "Name:"
        static let genderLabel = "Gender:"
        static let dateOfBirth = "Date of birth:"
        static let emailLabel = "Email:"
        static let timeLabel = "Time:"
    }
    
    private enum Gender {
        static let male = "\u{2642}"
        static let female = "\u{2640}"
    }
    
    private var stackView = UIStackView()
    var user: User?
    
    private var userImage: UIImageView = {
       let image = UIImageView()
        image.isUserInteractionEnabled = true
//        image.backgroundColor = .red
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = Text.nameLabel
        label.backgroundColor = .red
        label.font = Font.medium20.font
        return label
    }()
    
    private var nameLabelText: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.font = Font.regular20.font
        return label
    }()
    
    private var genderLabel: UILabel = {
        let label = UILabel()
        label.text = Text.genderLabel
        label.font = Font.medium20.font
        return label
    }()
    
    private var genderLabelText: UILabel = {
        let label = UILabel()
        label.font = Font.regular20.font
        return label
    }()
    
    private let dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.text = Text.dateOfBirth
        label.font = Font.medium20.font
        return label
    }()
    
    private var dateOfBirthLabelText: UILabel = {
        let label = UILabel()
        label.font = Font.regular20.font
        return label
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.text = Text.emailLabel
        label.font = Font.medium20.font
        return label
    }()
    
    private var emailLabelText: UILabel = {
        let label = UILabel()
        label.font = Font.regular20.font
        return label
    }()

    private var timeLabel: UILabel = {
        let label = UILabel()
        label.text = Text.timeLabel
        label.font = Font.medium20.font
        return label
    }()
    
    private var timeLabelText: UILabel = {
        let label = UILabel()
        label.font = Font.regular20.font
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        userImage.addGestureRecognizer(gestureRecognizer)
        setupStackView()
        setConstraints()
    }
    
    @objc private func imageTapped() {
        let imageVC = FullImageViewController()
        if let currentUser = user {
            imageVC.setImage(user: currentUser)
        }
        self.navigationController?.pushViewController(imageVC, animated: true)
    }
    
    func configureLabels(user: User) {
        self.title = user.name.first + " " + user.name.last

        nameLabelText.text = user.name.first + " " + user.name.last
        
        switch user.gender {
            case "male":
                genderLabelText.text = Gender.male
            case "female":
                genderLabelText.text = Gender.female
            default:
                genderLabelText.text = " "
        }
        
        dateOfBirthLabelText.text = setDateFormat(date: user.dob.date) + " (\(user.dob.age) y.o.)"
        emailLabelText.text = user.email
        timeLabelText.text = getUserCurrentTime(user.location.timezone.offset) + " (GMT \(user.location.timezone.offset))"
        
        guard let imageData = try? Data(contentsOf: user.picture.large) else {
            print("222Error receving user's image")
            return
        }
        userImage.image = UIImage(data: imageData)

        
    }
        
    private func setDateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        guard let backendDate = dateFormatter.date(from: date) else { return "" }
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd.MM.yyyy"
        let date = formatDate.string(from: backendDate)
        return date
    }
    
    private func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [nameLabel,
                                                   nameLabelText,
                                                   genderLabel,
                                                   genderLabelText,
                                                   dateOfBirthLabel,
                                                   dateOfBirthLabelText,
                                                   emailLabel,
                                                   emailLabelText,
                                                   timeLabel,
                                                   timeLabelText])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
    }
}

//MARK: - User current time
private extension ProfileViewController {
    
    func getGMTCurrentTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(identifier:"GMT")
        let defaultTimeZone = formatter.string(from: date)
        return defaultTimeZone
    }
    
    func hhmmToMinutes(_ hhmm : String) -> Int {
        let components = hhmm.components(separatedBy: ":")
        guard components.count == 2,
              let hr = Int(components[0]),
              let mn = Int(components[1]) else { return 0 }
        return hr * 60 + mn
    }
    
    func minutesToHourMinute(_ minutes : Int) -> String {
        let hr = minutes / 60
        let mn = minutes % 60
        return String(format: "%02ld:%02ld", hr, mn)
    }
    
    func getUserCurrentTime(_ userTimeOffset: String) -> String {
        let gmtCurrentTime = getGMTCurrentTime()
        let gmtCurrentTimeInMinutes = hhmmToMinutes(gmtCurrentTime)
        let userTimeOffsetInMinutes = hhmmToMinutes(userTimeOffset)
        let userCurrentTimeInMinutes = abs(gmtCurrentTimeInMinutes + userTimeOffsetInMinutes)
        let userCurrentTime = minutesToHourMinute(userCurrentTimeInMinutes)
        return userCurrentTime
    }
}

//MARK: - Constraints
private extension ProfileViewController {
    func setConstraints() {
        view.addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(Constants.userImageTopOffset)
            make.centerX.equalTo(self.view.snp.centerX)
            make.height.equalTo(Constants.userImageSize)
            make.width.equalTo(Constants.userImageSize)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(Constants.stackViewTopOffset)
            make.leading.equalToSuperview().offset(Constants.stackViewHorisontalOffset)
            make.trailing.equalToSuperview().offset(-Constants.stackViewHorisontalOffset)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}
