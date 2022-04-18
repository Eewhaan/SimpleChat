//
//  UserMapper.swift
//  simpleChat
//
//  Created by Ivan Pavic on 18.4.22..
//

import Foundation
import SendBirdSDK

struct UserMapper {
    static func map(users: [SBDUser]) -> [User] {
        var mappedUsers = [User]()
        for user in users {
            let userID = user.userId
            let nickName = user.nickname ?? ""
            let profielURL = user.profileUrl ?? ""
            let isActive = user.isActive
            let isOnline = (user.connectionStatus == SBDUserConnectionStatus.online)
            let lastSeen = Date(timeIntervalSince1970: Double(user.lastSeenAt)/1000)
            
            let newUser = User(
                userId: userID,
                nickName: nickName,
                profileURL: profielURL,
                isActive: isActive,
                isOnline: isOnline,
                lastSeen: lastSeen.toString())
            mappedUsers.append(newUser)
        }
        return mappedUsers
    }
}
