//
//  MessageTextView.swift
//  simpleChat
//
//  Created by Ivan Pavic on 31.3.22..
//

import Foundation
import SnapKit
import UIKit

class MessageTextView: UITextView {
    
    func configure() {
        
        self.backgroundColor = UIColor.systemFill
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.tintColor.cgColor
        self.layer.cornerRadius = 15
        self.font = UIFont(name: "Avenir Book", size: 16)
        self.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    
    
    func configureConstraints(tableView: UITableView, sendButton: UIButton, superView: UIView) {
        self.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.equalTo(superView.safeAreaLayoutGuide).inset(10)
            make.trailing.equalTo(sendButton.snp.leading)
            make.bottom.equalTo(superView.safeAreaLayoutGuide).inset(10)
        }
        
    }
    
    func remakeConstraints(keyboardShown: Bool, tableView: UITableView, sendButton: UIButton, superView: UIView, keyboardHeight: CGFloat) {
        switch keyboardShown {
        case false:
            self.snp.remakeConstraints { make in
                make.top.equalTo(tableView.snp.bottom)
                make.leading.equalTo(superView.safeAreaLayoutGuide).inset(10)
                make.trailing.equalTo(sendButton.snp.leading)
                make.bottom.equalTo(superView.safeAreaLayoutGuide).inset(10)
            }
        case true:
            self.snp.remakeConstraints{ make in
                make.top.equalTo(tableView.snp.bottom)
                make.leading.equalTo(superView.safeAreaLayoutGuide).inset(10)
                make.trailing.equalTo(sendButton.snp.leading)
                make.bottom.equalToSuperview().inset(keyboardHeight + 5)
            }
        }
    }
}
