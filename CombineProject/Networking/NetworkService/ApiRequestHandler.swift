//
//  ApiRequestHandler.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 03/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation
import Combine
import Alamofire

public enum CPResult<Value:Codable> {
    case success(Value?)
    case failure(CPError)
}

let successCode = "000"

class ApiRequestHandler: NSObject {
    
    //MARK: - Local Data
    class func loadLocalData<T:Codable, T1>(endPoint:EndPointType, decoder: JSONDecoder) -> Future<((T, T1)), Error> {

        return loadJson(fileName: endPoint.mockFileName ?? "", decoder: decoder)
    }
    
    class func loadJson<T:Codable, T1>(fileName: String, decoder: JSONDecoder) -> Future<((T, T1)), Error> {
        
        return Future { promise in
            
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            
                do {
                    
                    let data = try Data(contentsOf: url)
                    let result : Result<T, Error> = decoder.parseData(data:data)
                    
                    switch result {
                    
                    case .success(let result):
                        promise(.success(convertToDomain(object: result)))
                        
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
                catch{
                    promise(.failure(CPError(message: ErrorHandler.errorDescription(ErrorCodeType.decodingError.rawValue), statusCode:  ErrorCodeType.decodingError.rawValue)))
                }
            }
            
        }
    }
    
    class func request<T:Codable, T1>(endPointType : EndPointType) -> Future<((T, T1)), Error> {
        
        #if ENV_MOCK
        return loadLocalData(endPoint: BadgesEndPoint.getAllBadges, decoder: JSONDecoder())
        #else
        return Future {  promise in
            
            AF.request(endPointType).validate().responseJSON(completionHandler: { response in
                
                do {
                    let result : Result<T, Error>  = JSONDecoder().decodeResponse(from: response)
                    
                    switch result {
                    
                    case .success(let result):
                        promise(.success(convertToDomain(object: result)))
                        
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            })
        }
        #endif
    }
    
    class func convertToDomain<T:Codable, T1>(object:T) -> (T,T1)  {
        
        if let arr = (object.self as? Array<DataModel>) {
            
            var arrayConverted : [DomainModel] = []
            
            arr.forEach { (element) in
                if let converted = (element.toDomain()) {
                    arrayConverted.append(converted)
                }
            }
            return (object,arrayConverted as! T1 )
        } else {
            if let _ = object.dictionary  {
                let dataModel = (object.self as! DataModel)
                let domainModel = dataModel.toDomain()
                return (object,domainModel as! T1)
            }
            else {
                return (object,object as! T1)
            }
        }
    }
    
    
    
}
extension DataResponse {
    
    func description() {
        
        #if !DEBUG
        return
        #else
        print("Response:\n", self )
        #endif
    }
}
