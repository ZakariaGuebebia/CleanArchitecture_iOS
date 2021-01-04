//
//  EndPointType.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 03/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation
import Alamofire

protocol EndPointType: URLRequestConvertible {
    
    var mainURL: String { get }
    
    var path: String { get }
    
    var parameters: Any? { get}
    
    var method: HTTPMethod { get }
    
    var requestBodyData: [String: Any]? { get }
    
    var additionalHeader: [String: String]? { get }
    
    var mockFileName: String? { get }
    
}
extension EndPointType {
    
    var additionalHeader: [String: String]? {
        return ServerParameters.headers
    }
    var requestBodyData: [String: Any]? {
        return nil
    }
    
    
    var mainURL: String {
        return ApiClient.baseURL()
    }
    
    
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        
        let urlString = mainURL + path
        let escapedAddress = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        var urlRequest = URLRequest(url: (URL.init(string: escapedAddress!)!))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.createHeader()
        
        additionalHeader?.forEach({ (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        })
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        urlRequest.curlRepresentation()
        
        return urlRequest
    }
}

extension URLRequest {
    
    mutating func createHeader() {
        
        self.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
    }
}

