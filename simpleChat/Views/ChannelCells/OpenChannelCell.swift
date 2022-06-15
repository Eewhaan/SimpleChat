//
//  OpenChannelCell.swift
//  simpleChat
//
//  Created by Ivan Pavic on 27.5.22..
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
    
    func configure(openChannels: [OpenChannel], index: Int) {
        self.channelName.text = openChannels[index].channelName
        if let channelImage = openChannels[index].channelImage {
            let url = URL(string: channelImage)!
            self.channelImage.load(url: url)
        }
    }
}
