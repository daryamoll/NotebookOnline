
import UIKit
import SnapKit

class UsersViewController: UIViewController {
    
    let apiController = NetworkService()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UsersTableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.title = "Users"
        
        apiController.getUsers { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(_):
                        self.tableView.reloadData()
                    case .failure(_):
                        self.tableView.reloadData()
                }
            }
        }
        setLayout()
    }
    
    @objc func loadTable() {
        self.tableView.reloadData()
    }
    
    func setLayout() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDataSource
extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.users.count
    }
    
    func tableView(_ tableView: UITableView,  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UsersTableViewCell
        let user = apiController.users[indexPath.row]
        cell.configureCell(user: user)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileViewController = ProfileViewController()
        let user = apiController.users[indexPath.row]
        profileViewController.user = user
        profileViewController.configureLabels(user: user)
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}
