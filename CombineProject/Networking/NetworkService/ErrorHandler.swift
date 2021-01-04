//
//  ErrorHandler.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 03/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation

enum ErrorCodeType: String {
   
    case tryAgainError = "100"
    case dataNotAvailableError = "101"
    case saveFailedError = "116"
    case updateFailedError = "117"
    case operationNotAllowedError = "104"
    case operationUnsupportedError = "124"
    case tryRefreshError = "110"
    case tryLaterError = "111"
    case tryNewInputError = "102"
    case invalidInputError = "103"
    case gatewayWrongError = "136"
    case moiFailedError = "107"
    case woqodeFailedError = "108"
    case statusUnknownError = "135"
    case genericError = "500"
    case serverError = "-1"
    case decodingError = "-101"
    
    init(fromRawValue: String){
        self = ErrorCodeType(rawValue: fromRawValue) ?? .serverError
    }
}

class ErrorHandler: NSObject {
    
    @objc static let sharedInstance = ErrorHandler()
    
    @objc class func errorDescription(_ errorCode: String) -> String {
        
        let errorCodeType = ErrorCodeType.init(fromRawValue: errorCode)
        
        switch errorCodeType {
        case .decodingError:
            return "decoding error"

        default:
            return "server error"
        }
    }
}


