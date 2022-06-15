//
//  NewChannelVC.swift
//  simpleChat
//
//  Created by Ivan Pavic on 11.5.22..
//

import SendBirdSDK
import UIKit

class NewChannelVC: UITableViewController {
    
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return userList.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewChannelCell", for: indexPath) as? NewChannelCell else {
            return UITableViewCell()
        }
        cell.configure(userList: userList, section: indexPath.section, row: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                guard let vc = storyboard?.instantiateViewController(withIdentifier: "ContactsVC") as? ContactsViewController else { return }
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let ac = UIAlertController(title: "Create new Open Channel", message: "Enter channel name", preferredStyle: .alert)
                ac.addTextField()
                ac.addAction(UIAlertAction(title: "Cancel", style: .default))
                ac.addAction(UIAlertAction(title: "Create channel", style: .default) { _ in
                    var channelName = ac.textFields?[0].text
                    if channelName == "" {
                        channelName = "OpenChannel"
                    }
                    let parameters = SBDOpenChannelParams()
                    parameters.name = channelName
                    parameters.customType = CustomType.openChannel.rawValue
                    SBDOpenChannel.createChannel(with: parameters) { [weak self] openChannel, error in
                        guard error == nil else { return }
                        guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ChatView") as? ChatViewController else { return }
                        vc.channelURL = openChannel?.channelUrl
                        vc.isOpenChannel = true
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                })
                present(ac,animated: true)
            }
            
        } else {
            let parameters = SBDGroupChannelParams()
            parameters.isDistinct = true
            parameters.customType = CustomType.basicChannel.rawValue
            parameters.addUserId(userList[indexPath.row].userId)
            
            SBDGroupChannel.createChannel(with: parameters) { [weak self] groupChannel, error in
                guard error == nil else {return}
                guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ChatView") as? ChatViewController else { return }
                vc.channelURL = groupChannel?.channelUrl
                vc.isOpenChannel = false
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

}
