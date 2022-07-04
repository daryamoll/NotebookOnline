
import UIKit
import SnapKit

class UsersViewController: UIViewController {
    
    private let apiController = NetworkService()
    
    private var recordsArray: [Int] = Array()
    private var scrollLimit = 20
    lazy private var totalCountOfUsers = apiController.users.count
    
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
        
        indexAddition()
        
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
    
    private func setLayout() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDataSource
extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordsArray.count
    }
    
    func tableView(_ tableView: UITableView,  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UsersTableViewCell
        if apiController.users.count > 0  {
            let user = apiController.users[recordsArray[indexPath.row]]
            cell.configureCell(user: user)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == recordsArray.count - 1 {
            if recordsArray.count < totalCountOfUsers {
                var index = recordsArray.count
                scrollLimit = index + 20
                while index < scrollLimit {
                    recordsArray.append(index)
                    index = index + 1
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
            }
        }
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

//MARK: - for pagination

private extension UsersViewController {
    func indexAddition() {
        var index = 0
        while index < scrollLimit {
            recordsArray.append(index)
            index = index + 1
        }
    }
    
    @objc func loadTable() {
        self.tableView.reloadData()
    }
}

