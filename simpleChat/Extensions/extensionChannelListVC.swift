//
//  extensionChannelListVC.swift
//  simpleChat
//
//  Created by Ivan Pavic on 12.3.22..
//

import Foundation
import SendBirdSDK

extension ChannelListViewController: SBDGroupChannelCollectionDelegate {
    func channelCollection(_ collection: SBDGroupChannelCollection, context: SBDChannelContext, addedChannels channels: [SBDGroupChannel]) {
        // ...
    }

    func channelCollection(_ collection: SBDGroupChannelCollection, context: SBDChannelContext, updatedChannels channels: [SBDGroupChannel]) {
        // ...
    }

    func channelCollection(_ collection: SBDGroupChannelCollection, context: SBDChannelContext, deletedChannelUrls: [String]) {
        // ...
    }
}

