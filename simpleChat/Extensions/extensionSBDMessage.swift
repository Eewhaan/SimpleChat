//
//  extensionSBDMessage.swift
//  simpleChat
//
//  Created by Ivan Pavic on 11.3.22..
//

import UIKit
import SendBirdSDK

extension SBDBaseMessage {
    func isSentByMe() -> Bool {
        if let userID = self.sender?.userId {
            if userID == ChatViewController().userID {
                return true
            }
        }
        return false
    }
}
