//
//  CPError.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 03/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation

public class CPError : Error {
    
    public var message : String?
    
    public var statusCode : String?
    
    init(message: String?, statusCode: String?) {
        self.message = message
        self.statusCode = statusCode
    }
    
    init(errorCode : String) {
        self.statusCode = errorCode
        message = getMessage(statusCode ?? ErrorCodeType.serverError.rawValue)
    }
    
    
    
    func getMessage(_ errorStatus: String) -> String {
        
        _ =  ErrorCodeType.init(rawValue: errorStatus)
        
        let errorMessage = ""
        
        //switch on errorStatus and return returnedMessage
        return  errorMessage
    }
}
