//
//  ChatCell.swift
//  simpleChat
//
//  Created by Ivan Pavic on 4.3.22..
//

import UIKit


class GroupChannelCell: UITableViewCell {
    @IBOutlet weak var channelImage: UIImageView!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        channelName.font = UIFont(name: "Avenir", size: 16)
        lastMessage.font = UIFont(name: "Avenir", size: 13)
        channelImage.layer.cornerRadius = 30
        channelImage.clipsToBounds = true
    }
    
    func configure(groupChannels: [GroupChannel], index: Int) {
        self.channelName.text = groupChannels[index].channelName
        self.lastMessage.text = groupChannels[index].lastMessage?.message
        if let channelImage = groupChannels[index].channelImage {
            let url = URL (string: channelImage)!
            self.channelImage.load(url: url)
        }
    }

}
