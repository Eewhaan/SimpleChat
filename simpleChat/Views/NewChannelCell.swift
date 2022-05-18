//
//  NewChannelCell.swift
//  simpleChat
//
//  Created by Ivan Pavic on 11.5.22..
//

import UIKit

class NewChannelCell: UITableViewCell {
    @IBOutlet weak var newChannelImageView: UIImageView!
    @IBOutlet weak var newChannelName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.newChannelImageView.layer.cornerRadius = 30
        self.newChannelImageView.clipsToBounds = true
    }
    
    func configure(userList: [User], section index: Int, row: Int) {
        switch index {
        case 0:
            if row == 0 {
                self.newChannelName.text = "New Group"
                self.newChannelImageView.image = UIImage(systemName: "person.2.circle.fill")
            } else {
                self.newChannelName.text = "New Open Channel"
                self.newChannelImageView.image = UIImage(systemName: "person.3.sequence.fill")
                self.newChannelImageView.contentMode = .scaleAspectFit
            }
        case 1:
            self.newChannelName.text = userList[row].nickName
            if let url = URL(string: userList[row].profileURL) {
                self.newChannelImageView.load(url: url)
            }
        default:
            break
        }
    }

}
