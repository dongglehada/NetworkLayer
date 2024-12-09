//
//  Encodable+.swift
//
//
//  Created by SeoJunYoung on 12/9/24.
//

import Foundation

public extension Encodable {
    
    /// URL에 요청할 쿼리 데이터를 JSON 형식에 맞게 딕셔너리 구조로 변환하는 메서드
    /// - Returns: jsonData
    public func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}
