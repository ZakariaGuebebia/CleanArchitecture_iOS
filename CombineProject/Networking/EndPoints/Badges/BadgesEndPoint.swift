//
//  BadgesEndPoint.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 18/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation
import Alamofire

private let BaseApiMethod = ApiClient.baseURL()

enum BadgesEndPoint : EndPointType {

    case getAllBadges

    var method: HTTPMethod {
        
        switch self {
        case .getAllBadges:
            return .get
        }
    }
    var path: String {
        return EndPoints.badges+"?language=EN"
    }
    var parameters: Any? {
        switch self {
        case .getAllBadges:
            return nil
        }
    }
    
    var mockFileName: String? {
        
        switch self {
        case .getAllBadges:
            return BadgesFileNames.badges
        }
    }
}

