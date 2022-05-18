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
    
    override func viewWillAppear(_ animated: Bool) {
        
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
            openChannelCell.configure(openChannels: openChannels, index: indexPath.row)
            cell = openChannelCell
        } else {
            guard let groupChannelCell = tableView.dequeueReusableCell(withIdentifier: "GroupChannelCell", for: indexPath) as? GroupChannelCell else {
                return cell
            }
            groupChannelCell.configure(groupChannels: groupChannels, index: indexPath.row)
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
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "NewChannelVC") as? NewChannelVC else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
