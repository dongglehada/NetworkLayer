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
    public var baseURL: String
    public var path: String
    public var method: HTTPMethod
    public var queryParameters: Encodable?
    public var jsonData: [String: Any]?
    public var headers: [String: String]?
    
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
