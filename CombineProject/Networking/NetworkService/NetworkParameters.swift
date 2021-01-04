//
//  NetworkParameters.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 03/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation

struct ServerParameters {
    
    let baseURL : String
    let authorization : String
    
    static let devParameters : ServerParameters = ServerParameters(
        baseURL: "",
        authorization: "")
    
    static var  headers :  [String: String]?
    
}


struct EndPoints  {
    static let badges = "fintune_content/badges/all"
}

enum ContentType: String {
    case json = "application/json"
    case data = "multipart/form-data"
    case url =  "application/x-www-form-urlencoded"
}
enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case subscriptionKey = "Ocp-Apim-Subscription-Key"
    case authorization = "Authorization"
    case tenantId = "X-Fintune-Tenant-ID"
    case acceptLanguage = "Accept-Language"
    case deviceId = "Device-Id"
    case devicePlatform = "Device-Platform"
    case ocpTraceValue = "Ocp-Apim-Trace"
    case fintuneSubscriptionKey = "Fintune-Subscription-Key"
}

