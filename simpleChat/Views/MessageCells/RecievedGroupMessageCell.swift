//
//  RecievedGroupMessageCell.swift
//  simpleChat
//
//  Created by Ivan Pavic on 27.5.22..
//

import UIKit
import SnapKit


class RecievedGroupMessage: UITableViewCell {
    var messageContainer: UIView!
    var messageLabel: PaddedLabel!
    var senderLabel: PaddedLabel!
    

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }


    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupViews() {
        messageContainer = UIView()
        self.addSubview(messageContainer)
        
        messageLabel = PaddedLabel()
        messageContainer.addSubview(messageLabel)
        
        senderLabel = PaddedLabel()
        messageContainer.addSubview(senderLabel)
        
        messageContainer.snp.makeConstraints{ make in
            make.bottom.top.equalToSuperview().inset(4)
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.85)
            make.leading.equalToSuperview().inset(8)
            make.height.equalTo(messageLabel.snp.height).offset(25)
        }
        
        messageLabel.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().inset(2)
            make.width.lessThanOrEqualToSuperview()
            make.leading.trailing.equalToSuperview().inset(2)
        }
        
        senderLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(10)
            make.bottom.equalTo(messageLabel.snp.top)
            make.width.lessThanOrEqualToSuperview()
            make.leading.trailing.equalToSuperview().inset(2)
        }
    }
    
    func loadSetup() {
        self.messageContainer.layer.borderWidth = 1
        self.messageContainer.layer.borderColor = UIColor.tintColor.cgColor
        self.messageContainer.layer.cornerRadius = 10
        
        self.messageLabel.numberOfLines = 0
        self.messageLabel.font = UIFont(name: "Avenir Book", size: 16)
        self.messageLabel.textAlignment = .left
        self.messageLabel.paddingTop = 5
        self.messageLabel.paddingBottom = 5
        self.messageLabel.paddingLeft = 10
        self.messageLabel.paddingRight = 10
        
        self.senderLabel.numberOfLines = 1
        self.senderLabel.font = UIFont(name: "Avenir Heavy", size: 14)
        self.senderLabel.textColor = UIColor.tintColor
        self.senderLabel.textAlignment = .left
        self.senderLabel.paddingTop = 5
        self.senderLabel.paddingBottom = 5
        self.senderLabel.paddingLeft = 10
        self.senderLabel.paddingRight = 10

    }

}
