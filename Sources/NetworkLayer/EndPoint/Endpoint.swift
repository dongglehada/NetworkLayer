//
//  Endpoint.swift
//  NetwrokLayer
//
//  Created by SeoJunYoung on 8/16/24.
//

import Foundation
import OSLog

import Alamofire

public class Endpoint<R: Decodable>: Requestable, Responsable {
    public typealias Response = R
    
    public var baseURL: String
    public var path: String
    public var method: HTTPMethod
    public var queryParameters: Encodable?
    public var bodyParameters: Encodable?
    public var headers: [String: String]?
    public var sampleData: Data?
    
    public init(
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
