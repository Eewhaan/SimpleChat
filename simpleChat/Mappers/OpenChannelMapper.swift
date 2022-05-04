//
//  OpenChannelMapper.swift
//  simpleChat
//
//  Created by Ivan Pavic on 29.4.22..
//

import Foundation
import SendBirdSDK

struct OpenChannelMapper {
    static func map(openChannels: [SBDOpenChannel]) -> [OpenChannel] {
        var mappedChannels = [OpenChannel]()
        for openChannel in openChannels {
            let channelURL = openChannel.channelUrl
            let channelName = openChannel.name
            let channelImage = openChannel.coverUrl
            let numberOfParticipants = openChannel.participantCount
            
            let newOpenChannel = OpenChannel(
                channelURL: channelURL,
                channelName: channelName,
                channelImage: channelImage,
                numberOfParticipants: numberOfParticipants)

            mappedChannels.append(newOpenChannel)
        }
        return mappedChannels
    }
}
