//
//  NoResponseEndPoint.swift
//  NetwrokLayer
//
//  Created by SeoJunYoung on 8/16/24.
//

import Foundation
import OSLog

import Alamofire

public class NoResponseEndPoint: Requestable {
    
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
    
    public func getUrlRequest() throws -> URLRequest {
        let url = try buildURL()
        os_log("\(url) URL 생성")
        
        var urlRequest = URLRequest(url: url)
        // httpBody
        if let bodyParameters = try bodyParameters?.toDictionary() {
            if !bodyParameters.isEmpty {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
            }
        }
        // httpMethod
        urlRequest.httpMethod = method.rawValue
        // header
        headers?.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        return urlRequest
    }
    
    public func buildURL() throws -> URL {
        // baseURL + path
        let fullPath = "\(baseURL)\(path)"
        guard var urlComponents = URLComponents(string: fullPath) else {
            throw NetworkError.components
        }
        // (baseURL + path) + queryParameters
        var urlQueryItems = [URLQueryItem]()
        if let queryParameters = try queryParameters?.toDictionary() {
            queryParameters.forEach {
                urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
            }
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        
        guard let url = urlComponents.url else { throw NetworkError.components }
        return url
    }
}
