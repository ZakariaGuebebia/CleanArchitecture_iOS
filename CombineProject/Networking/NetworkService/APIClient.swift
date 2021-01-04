//
//  APIClient.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 03/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation

class ApiClient: NSObject {
    
    class func baseURL() -> String {
        return self.serverParameters().baseURL
    }
    
    class func authorization() -> String {
        return self.serverParameters().authorization
    }
    
    fileprivate class func serverParameters() -> ServerParameters {
        return ServerParameters.devParameters
    }
    
}

