//
//  BadgeRepository.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 18/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation
import Combine

protocol BadgeRepository {
    func getAllbadges() -> Future<(([BadgeDTO] , [Badge])), Error>
}
