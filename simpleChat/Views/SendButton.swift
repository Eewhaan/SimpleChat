//
//  SendButton.swift
//  simpleChat
//
//  Created by Ivan Pavic on 31.3.22..
//

import Foundation
import SnapKit
import UIKit


class SendButton: UIButton {
    
    func configure(target: UIViewController, action: Selector) {
        self.setBackgroundImage(UIImage(systemName: "arrowshape.turn.up.right.circle.fill"), for: .normal)
        self.tintColor = UIColor.tintColor
        self.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func configureConstraints(messageTextView: MessageTextView, superView: UIView) {
        self.snp.makeConstraints{ make in
            make.bottom.equalTo(messageTextView.snp.bottom)
            make.trailing.equalTo(superView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(messageTextView.snp.trailing)
            make.height.equalTo(35)
            make.width.equalTo(35)
        }
    }
}
