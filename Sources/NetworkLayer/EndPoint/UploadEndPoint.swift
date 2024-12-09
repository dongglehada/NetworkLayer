//
//  UploadEndPoint.swift
//  NetwrokLayer
//
//  Created by SeoJunYoung on 10/25/24.
//

import UIKit
import OSLog

import Alamofire

public class UploadEndPoint<R: Decodable>: Uploadable, Responsable {
    typealias Response = R
    
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
