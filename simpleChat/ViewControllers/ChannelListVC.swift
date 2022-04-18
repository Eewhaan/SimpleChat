//
//  ChannelListViewController.swift
//  simpleChat
//
//  Created by Ivan Pavic on 12.3.22..
//

import UIKit
import SendBirdSDK



class ChannelListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, LastMessageDelegate {
    
    @IBOutlet weak var newChannelButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var lastMessage = ""
    var collection: SBDGroupChannelCollection?
    var openChannels = [SBDOpenChannel]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    var groupChannels = [SBDGroupChannel]() {
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

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as? ChatCell else {
            return UITableViewCell()
        }
        cell.channelName.text = "FirstChannel"
        cell.lastMessage.text = lastMessage
        cell.channelImage.image = UIImage(systemName: "person.circle.fill")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ChatView") as? ChatViewController else { return }
        vc.lastMessageDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateLastMessage(_ message: SBDBaseMessage) {
        lastMessage = message.message
        tableView.reloadData()
    }
    
    @IBAction func newChannelTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ContactsVC") as? ContactsViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
