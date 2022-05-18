//
//  ContactsCell.swift
//  simpleChat
//
//  Created by Ivan Pavic on 18.4.22..
//

import UIKit

class ContactsCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userSelectedImageView: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImageView.layer.cornerRadius = 30
        self.userImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.userSelectedImageView.isHidden.toggle()
        }
    }
    
    func configure(userName: String, userImage: String) {
        self.userSelectedImageView.isHidden = true
        self.userName.text = userName
        if let url = URL(string: userImage) {
            self.userImageView.load(url: url)
        }
    }

}
