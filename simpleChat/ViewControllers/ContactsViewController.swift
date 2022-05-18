//
//  ContactsViewController.swift
//  simpleChat
//
//  Created by Ivan Pavic on 18.4.22..
//

import SendBirdSDK
import UIKit

class ContactsViewController: UITableViewController {
    
    var userList = [User]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.shared.getUserList { users in
            self.userList = users
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell", for: indexPath) as? ContactsCell else {
            return UITableViewCell()
        }
        cell.configure(userName: userList[indexPath.row].nickName, userImage: userList[indexPath.row].profileURL)
        return cell
    }
    
}
