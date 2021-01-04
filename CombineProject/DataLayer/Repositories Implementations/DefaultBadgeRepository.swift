//
//  DefaultBadgeRepository.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 18/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation
import Combine

class DefaultBadgeRepository : BadgeRepository {
    
    private let remoteDataSource: BadgesDataSource
    private let localDataSource: BadgesDataSource
    
    internal init(remoteDataSource: BadgesDataSource = RemoteBadgesDataSource(), localDataSource: BadgesDataSource = LocalBadgesDataSource()) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getAllbadges() -> Future<(([BadgeDTO], [Badge])), Error> {
        //here we can implement caching logic
        remoteDataSource.getAllbadges()
    }
}

//MARK: DataSource
protocol BadgesDataSource {
    func getAllbadges() -> Future<(([BadgeDTO], [Badge])), Error>
}
class LocalBadgesDataSource: BadgesDataSource {
    func getAllbadges() -> Future<(([BadgeDTO], [Badge])), Error> {
        return Future { promise in promise(.failure(CPError.init(errorCode: ErrorCodeType.genericError.rawValue)))}
    }
}
class RemoteBadgesDataSource: BadgesDataSource {
    func getAllbadges() -> Future<(([BadgeDTO], [Badge])), Error> {
        return ApiRequestHandler.request(endPointType: BadgesEndPoint.getAllBadges)
    }
}
