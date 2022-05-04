//
//  DataService.swift
//  simpleChat
//
//  Created by Ivan Pavic on 17.4.22..
//

import Foundation
import UIKit
import SendBirdSDK


class DataService {
    static let shared = DataService()
    
    private init() {}
        
    func getUserList(_ completion: @escaping ([User]) -> Void) {
        let listQuery = SBDMain.createApplicationUserListQuery()
        listQuery?.loadNextPage(completionHandler: { (sbdUsers, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let sbdUsers = sbdUsers else {
                print ("Failed to load users")
                return
            }
            
            let users = UserMapper.map(users: sbdUsers)
            completion(users)
        })
    }
    
    func getGroupChannelList(_ completion: @escaping ([GroupChannel]) -> Void) {
        let query = SBDGroupChannel.createMyGroupChannelListQuery()
        query?.includeEmptyChannel = false
        query?.order = .chronological
        query?.loadNextPage(completionHandler: { (sbdGroupChannels, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let sbdGroupChannels = sbdGroupChannels else {
                print("Unable to load channels")
                return
            }
            let groupChannels = GroupChannelMapper.map(groupChannels: sbdGroupChannels)
            completion(groupChannels)
        })
    }
    
    func getOpenChannelList(_ completion: @escaping ([OpenChannel]) -> Void) {
        let query = SBDOpenChannel.createOpenChannelListQuery()
        query?.limit = 4
        query?.loadNextPage(completionHandler: { (sbdOpenChannels, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let sbdOpenChannels = sbdOpenChannels else {
                print("Unable to load channels")
                return
            }
            let openChannels = OpenChannelMapper.map(openChannels: sbdOpenChannels)
            completion(openChannels)
        })
    }
    
}
