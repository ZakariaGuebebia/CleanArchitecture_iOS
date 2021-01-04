//
//  Badge.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 18/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation

class Badge: DomainModel, Codable,Hashable {
    
    static func == (lhs: Badge, rhs: Badge) -> Bool {
        return (lhs.id == rhs.id
                    && lhs.name == rhs.name &&
                    lhs.photo == rhs.photo &&
                    lhs.type == rhs.type
        )
    }
    func hash(into hasher: inout Hasher) {
        
    }
    public var name: String?
    public var photo : String?
    public var id : String?
    public var type : BadgeType?
    
    internal init(name: String? = nil, photo: String? = nil, id: String? = nil, type: BadgeType? = nil) {
        self.name = name
        self.photo = photo
        self.id = id
        self.type = type
    }
    
}

enum BadgeType: String, Codable {
    case loginBadge = "LOGIN_BADGE"
    case superFox = "SUPER_FOX"
    case smartOwl = "SMART_OWL"
    case bestFriend = "BEST_FRIEND"
    case cashCow = "CASH_COW"
    case dreamBig = "FOXY_SAVER"
    case foxySaver = "DREAM_BIG"
}
