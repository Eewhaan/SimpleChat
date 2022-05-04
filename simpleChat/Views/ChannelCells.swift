//
//  ChatCell.swift
//  simpleChat
//
//  Created by Ivan Pavic on 4.3.22..
//

import UIKit



class OpenChannelCell: UITableViewCell {
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var channelImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        channelName.font = UIFont(name: "Avenir", size: 17)
        channelImage.layer.cornerRadius = 30
        channelImage.clipsToBounds = true
    }
    
}

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

}
