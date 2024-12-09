//
//  File.swift
//  
//
//  Created by SeoJunYoung on 12/9/24.
//

import Foundation

public protocol EndPointable {
    func getUrlRequest() throws -> URLRequest
    func buildURL() throws -> URL
}
