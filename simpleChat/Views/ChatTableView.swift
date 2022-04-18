//
//  TableView.swift
//  simpleChat
//
//  Created by Ivan Pavic on 31.3.22..
//

import Foundation
import SnapKit
import UIKit


class ChatTable: UITableView {
    
    func configure(delegate: ChatViewController) {
        self.delegate = delegate
        self.dataSource = delegate
        self.register(SentMessage.self, forCellReuseIdentifier: "SentMessage")
        self.register(RecievedMessage.self, forCellReuseIdentifier: "RecievedMessage")
        self.separatorStyle = .none
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = 1000
    }
    
    func configureConstraints(superView: UIView, messageTextView: MessageTextView) {
        self.snp.makeConstraints{ make in
            make.top.trailing.leading.equalTo(superView.safeAreaLayoutGuide)
            make.bottom.equalTo(messageTextView.snp.top)
        }
    }
}
