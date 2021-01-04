//
//  JsonDecoderExtension.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 21/12/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation
import Alamofire
import Combine

extension JSONDecoder {
    
    func decodeResponse<T: Codable>(from responseData : DataResponse<Any, AFError>?) -> Result<T, Error> {
        
        responseData?.description()
        
        guard let dataResponse = responseData, dataResponse.error == nil else {
            return  .failure(CPError(errorCode: "-1"))
        }
        
        return self.parseData(data: dataResponse.data)
    }
    
    
    func parseData<T: Codable>(data : Data?) -> Result<T, Error> {
        do {
            if let data = data {
                let item = try decode(ResultWS<T>.self, from: data)
                
                if let result = item.body?.result  {
                    return .success(result)
                    
                } else if let header = item.header {
                    return .failure(CPError(message: header.title, statusCode:  header.statusCode))
                }
            }
        } catch {
            return .failure(CPError(message: ErrorHandler.errorDescription(ErrorCodeType.decodingError.rawValue), statusCode:  ErrorCodeType.decodingError.rawValue))
        }
        return .failure(CPError(message: ErrorHandler.errorDescription(ErrorCodeType.decodingError.rawValue), statusCode:  ErrorCodeType.decodingError.rawValue))
    }
}
