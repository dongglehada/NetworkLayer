//
//  Provider.swift
//  MomsVillage
//
//  Created by SeoJunYoung on 8/16/24.
//

import Foundation

import RxSwift
import Alamofire

public protocol Provider {
    
    /// 네트워크 요청을 수행하고 응답값을 반환하는 메서드
    /// - Parameters:
    ///   - endpoint: 요청할 엔드포인트
    ///   - interceptor: 요청에 사용할 RequestInterceptor (옵셔널)
    /// - Returns: 요청에 대한 결과를 Observable로 반환
    public func requestData<R: Decodable, E: EndPointable & Responsable>(with endpoint: E, interceptor: RequestInterceptor?)
    -> Observable<R> where R == E.Response
    
    /// 네트워크 요청을 수행하고 결과를 반환하는 메서드
    /// - Parameters:
    ///   - request: 요청할 Requestable 객체
    ///   - interceptor: 요청에 사용할 RequestInterceptor (옵셔널)
    /// - Returns: 요청에 대한 결과를 Completable로 반환
    public func request<E: EndPointable>(with request: E, interceptor: RequestInterceptor?) -> Completable
}
