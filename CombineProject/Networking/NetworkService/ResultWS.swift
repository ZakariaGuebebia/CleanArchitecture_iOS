//
//  ResultWS.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 03/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation

public class ResultWS<T:Codable> : Codable {
    public var isSuccessful : Bool?
    public var header : Header?
    public var body : Body<T>?
}
public class Header: Codable {
    
    // MARK: Properties
    public var providerCode: String?
    public var providerDescription: String?
    public var statusCode: String?
    public var title: String?
}
public class Body<T: Codable>: Codable {
    
    // MARK: Properties
    public var result: T?
    public var type: String?
    public var list: T?
    public var count: Int?
    
}
