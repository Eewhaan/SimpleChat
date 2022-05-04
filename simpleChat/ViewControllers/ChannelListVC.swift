//
//  ChannelListViewController.swift
//  simpleChat
//
//  Created by Ivan Pavic on 12.3.22..
//

import UIKit
import SendBirdSDK



class ChannelListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var newChannelButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var collection: SBDGroupChannelCollection?
    var openChannels = [OpenChannel]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    var groupChannels = [GroupChannel]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.shared.getOpenChannelList { channels in
            self.openChannels = channels
        }
        DataService.shared.getGroupChannelList { channels in
            self.groupChannels = channels
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return openChannels.count
        default:
            return groupChannels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            guard let openChannelCell = tableView.dequeueReusableCell(withIdentifier: "OpenChannelCell", for: indexPath) as? OpenChannelCell else {
                return cell
            }
            openChannelCell.channelName.text = openChannels[indexPath.row].channelName
            if let imageName = openChannels[indexPath.row].channelImage {
                let url = URL(string: imageName)!
                openChannelCell.channelImage.load(url: url)
            }
            cell = openChannelCell
        } else {
            guard let groupChannelCell = tableView.dequeueReusableCell(withIdentifier: "GroupChannelCell", for: indexPath) as? GroupChannelCell else {
                return cell
            }
            groupChannelCell.channelName.text = groupChannels[indexPath.row].channelName
            groupChannelCell.lastMessage.text = groupChannels[indexPath.row].lastMessage?.message
            if let imageName = groupChannels[indexPath.row].channelImage {
                let url = URL(string: imageName)!
                groupChannelCell.channelImage.load(url: url)
            }
            cell = groupChannelCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ChatView") as? ChatViewController else { return }
        if indexPath.section == 0 {
            vc.channelURL = openChannels[indexPath.row].channelURL
            vc.isOpenChannel = true
        } else {
            vc.channelURL = groupChannels[indexPath.row].channelURL
            vc.isOpenChannel = false
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func newChannelTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ContactsVC") as? ContactsViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
