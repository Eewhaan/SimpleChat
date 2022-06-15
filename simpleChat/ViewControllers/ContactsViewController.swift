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
    var selectedUsers = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create Group", style: .plain, target: self, action: #selector(createGroupChannel))
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? ContactsCell else { return }
        if !selectedCell.userSelectedImageView.isHidden {
            selectedUsers.append(userList[indexPath.row])
        } else {
            let index = selectedUsers.firstIndex(where: {$0.userId == userList[indexPath.row].userId})
            if let index = index {
                selectedUsers.remove(at: index)
            }
        }
    }
    
    @objc func createGroupChannel() {
        let ac = UIAlertController(title: "Create New Group Channel", message: "Enter channel name", preferredStyle: .alert)
        ac.addTextField()
        let createChannel = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            var channelName = ac.textFields?[0].text
            if channelName == "" {
                channelName = "GroupChannel"
            }
            let parameters = SBDGroupChannelParams()
            parameters.customType = CustomType.groupChannel.rawValue
            parameters.name = channelName
            parameters.isDistinct = true
            guard let selectedUsers = self?.selectedUsers else { return }
            for selectedUser in selectedUsers {
                parameters.addUserId(selectedUser.userId)
            }
            
            SBDGroupChannel.createChannel(with: parameters) { [weak self] groupChannel, error in
                guard error == nil else {return}
                guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ChatView") as? ChatViewController else { return }
                vc.channelURL = groupChannel?.channelUrl
                vc.isOpenChannel = false
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        ac.addAction(createChannel)
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        present(ac, animated: true)
    }
    
}
