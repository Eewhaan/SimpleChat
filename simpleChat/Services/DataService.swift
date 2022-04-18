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
    
    private var users = [User]()
    private var groupChannels = [SBDGroupChannel]()
    private var openChannels = [SBDOpenChannel]()
    
    func getUserList(_ completion: @escaping ([User]) -> Void) {
        let listQuery = SBDMain.createApplicationUserListQuery()
        listQuery?.loadNextPage(completionHandler: { (users, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return }
            guard let users = users else {
                print ("Failed to load users")
                return }
            self.users = UserMapper.map(users: users)
        })
        completion(users)
    }
    
    func getGroupChannelList(_ completion: @escaping ([SBDGroupChannel]) -> Void) {
        let query = SBDGroupChannel.createMyGroupChannelListQuery()
        query?.includeEmptyChannel = false
        query?.order = .chronological
        query?.loadNextPage(completionHandler: { (channels, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let channels = channels else {
                print("Unable to load channels")
                return
            }
            self.groupChannels = channels
        })
        completion(groupChannels)
    }
    
    func getOpenChannelList(_ completion: @escaping ([SBDOpenChannel]) -> Void) {
        let query = SBDOpenChannel.createOpenChannelListQuery()
        query?.limit = 4
        query?.loadNextPage(completionHandler: { (channels, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let channels = channels else {
                print("Unable to load channels")
                return
            }
            self.openChannels = channels
        })
        completion(openChannels)
    }
    
}
