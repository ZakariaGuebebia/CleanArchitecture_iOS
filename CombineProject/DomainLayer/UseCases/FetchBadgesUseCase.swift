//
//  FetchBadgesUseCase.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 19/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation
import Combine

protocol FetchBadgesUseCase{
    func execute() -> Future<(([BadgeDTO] , [Badge])), Error>
}

class DefaultFetchBadgesUseCase: FetchBadgesUseCase {
    
    private var badgeRepository : BadgeRepository
    
    internal init(badgeRepository: BadgeRepository) {
        self.badgeRepository = badgeRepository
    }
    
    func execute() -> Future<(([BadgeDTO], [Badge])), Error> {
        return badgeRepository.getAllbadges()
    }
}
