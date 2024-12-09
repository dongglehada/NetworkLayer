//
//  Endpoint.swift
//  NetwrokLayer
//
//  Created by SeoJunYoung on 8/16/24.
//

import Foundation
import OSLog

import Alamofire

class Endpoint<R: Decodable>: Requestable, Responsable {
    typealias Response = R
    
    var baseURL: String
    var path: String
    var method: HTTPMethod
    var queryParameters: Encodable?
    var bodyParameters: Encodable?
    var headers: [String: String]?
    var sampleData: Data?
    
    init(
        baseURL: String,
        path: String = "",
        method: HTTPMethod = .get,
        queryParameters: Encodable? = nil,
        bodyParameters: Encodable? = nil,
        headers: [String: String]? = [:],
        sampleData: Data? = nil
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
        self.headers = headers
        self.sampleData = sampleData
    }
}
