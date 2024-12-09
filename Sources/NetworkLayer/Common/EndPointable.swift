//
//  File.swift
//  
//
//  Created by SeoJunYoung on 12/9/24.
//

import Foundation

public protocol EndPointable {
    public func getUrlRequest() throws -> URLRequest
    public func buildURL() throws -> URL
}
