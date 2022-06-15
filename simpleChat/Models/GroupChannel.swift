//
//  Channel.swift
//  simpleChat
//
//  Created by Ivan Pavic on 6.4.22..
//

import Foundation
import SendBirdSDK

struct GroupChannel {
    let channelURL: String
    let channelName: String
    let channelImage: String?
    let lastMessage: SBDBaseMessage?
    var isDistinct: Bool
    var numberOfUnreadMessages: UInt?
    var memberCount: UInt
    
}
