//
//  UploadEndPoint.swift
//
//
//  Created by SeoJunYoung on 12/9/24.
//

import Foundation
import OSLog

import Alamofire

public class NoResponseUploadEndPoint: Uploadable {
    var baseURL: String
    var path: String
    var method: HTTPMethod
    var queryParameters: Encodable?
    var jsonData: [String: Any]?
    var headers: [String: String]?
    
    public init(
        baseURL: String,
        path: String,
        method: HTTPMethod,
        queryParameters: Encodable? = nil,
        jsonData: [String: Any]? = nil,
        headers: [String: String]? = nil
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.jsonData = jsonData
        self.headers = headers
    }
}
