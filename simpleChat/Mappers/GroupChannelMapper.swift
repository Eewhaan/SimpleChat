//
//  GroupChannelMapper.swift
//  simpleChat
//
//  Created by Ivan Pavic on 29.4.22..
//

import Foundation
import SendBirdSDK

struct GroupChannelMapper {
    static func map(groupChannels: [SBDGroupChannel]) -> [GroupChannel] {
        var mappedChannels = [GroupChannel]()
        for groupChannel in groupChannels {
            let channelURL = groupChannel.channelUrl
            let channelName = groupChannel.name
            let channelImage = groupChannel.coverUrl
            let isDistinct = groupChannel.isDistinct
            let lastMessage = groupChannel.lastMessage
            let numberOfUnreadMessages = groupChannel.unreadMentionCount
            let memberCount = groupChannel.joinedMemberCount
            
            let newGroupChannel = GroupChannel (
                channelURL: channelURL,
                channelName: channelName,
                channelImage: channelImage,
                lastMessage: lastMessage,
                isDistinct: isDistinct,
                numberOfUnreadMessages: numberOfUnreadMessages,
                memberCount: memberCount)
            mappedChannels.append(newGroupChannel)
        }
        return mappedChannels
    }
}
