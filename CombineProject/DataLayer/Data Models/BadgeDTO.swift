//
//  BadgeDTO.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 18/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation

class BadgeDTO: DataModel, Codable {
    
    public var badgeType : String?
    public var description : String?
    public var id : String?
    public var photo : String?
    public var count: Int?
    public var status: Bool?
    public var name: String?
    public var deactivatedPhoto: String?
    
    
    override func toDomain() -> DomainModel? {
        let type = BadgeType(rawValue: badgeType ?? "")
        return Badge(name: self.name, photo: self.photo, id: self.id, type: type)
    }
    
}
