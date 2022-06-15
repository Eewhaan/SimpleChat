//
//  RecievedMessageCell.swift
//  simpleChat
//
//  Created by Ivan Pavic on 27.5.22..
//

import UIKit
import SnapKit


class RecievedMessage: UITableViewCell {
    var messageLabel: PaddedLabel!


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

    func loadSetup() {
        self.messageLabel.numberOfLines = 0
        self.messageLabel.font = UIFont(name: "Avenir Book", size: 16)
        self.messageLabel.textAlignment = .left
        self.messageLabel.layer.borderWidth = 1
        self.messageLabel.layer.borderColor = UIColor.tintColor.cgColor
        self.messageLabel.layer.cornerRadius = 10
        self.messageLabel.paddingTop = 5
        self.messageLabel.paddingBottom = 5
        self.messageLabel.paddingLeft = 10
        self.messageLabel.paddingRight = 10
        self.messageLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
        }
    }

    func setupViews() {
        messageLabel = PaddedLabel()
        self.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints{ make in
            make.bottom.top.equalToSuperview().inset(4)
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.85)
        }
    }
}
