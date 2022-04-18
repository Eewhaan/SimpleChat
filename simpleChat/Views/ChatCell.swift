//
//  ChatCell.swift
//  simpleChat
//
//  Created by Ivan Pavic on 4.3.22..
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var channelImage: UIImageView!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        channelName.font = UIFont(name: "Avenir", size: 16)
        lastMessage.font = UIFont(name: "Avenir", size: 13)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
