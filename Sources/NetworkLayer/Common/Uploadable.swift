//
//  Uploadable.swift
//
//
//  Created by SeoJunYoung on 12/9/24.
//

import Foundation
import OSLog

import Alamofire

public protocol Uploadable: EndPointable {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: Encodable? { get }
    var jsonData: [String: Any]? { get }
    var headers: [String: String]? { get }
    
    func asMultipartFormData(multipartFormData: MultipartFormData)
}

extension Uploadable {
    
    func getUrlRequest() throws -> URLRequest {
        let url = try buildURL()
        os_log("\(url) URL 생성")
        
        var urlRequest = URLRequest(url: url)
        // httpMethod
        urlRequest.httpMethod = method.rawValue
        // header
        headers?.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        return urlRequest
    }
    
    func buildURL() throws -> URL {
        // baseURL + path
        let fullPath = "\(baseURL)\(path)"
        guard var urlComponents = URLComponents(string: fullPath) else {
            throw NetworkError.components
        }
//         (baseURL + path) + queryParameters
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
    
    func asMultipartFormData(multipartFormData: MultipartFormData) {
        // JSON 데이터를 각 키-값 필드로 추가
        if let jsonData = jsonData {
            // jsonData는 [String: Any] 형태로 가정
            for (key, value) in jsonData {
                // 값이 Array 또는 Dictionary인 경우에도 처리
                if let valueData = try? JSONSerialization.data(withJSONObject: value, options: []) {
                    multipartFormData.append(valueData, withName: key)
                } else if let stringValue = value as? String {
                    // 값이 String이면 직접 추가
                    multipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
                }
            }
        }
    }
}
