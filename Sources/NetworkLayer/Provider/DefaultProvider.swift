//
//  File.swift
//  
//
//  Created by SeoJunYoung on 12/9/24.
//

import Foundation

import Alamofire
import RxSwift

public struct DefaultProvider: Provider {
    
    public init() { }
    
    public func requestData<R: Decodable, E: EndPointable & Responsable>(
        with endpoint: E, interceptor: RequestInterceptor? = nil
    )-> Observable<R> where R == E.Response {
        return Observable.create { observer in
            do {
                let urlRequest = try endpoint.getUrlRequest()
                let request = AF.request(urlRequest, interceptor: interceptor)
                    .validate()
                    .response { response in
                        switch response.result {
                        case .success(let data):
                            if let data = data {
                                do {
                                    let decodeData = try JSONDecoder().decode(R.self, from: data)
                                    observer.onNext(decodeData)
                                    observer.onCompleted()
                                } catch {
                                    observer.onError(NetworkError.decodeError)
                                }
                            } else {
                                observer.onError(NetworkError.emptyData)
                            }
                        case .failure(let errror):
                            observer.onError(errror)
                        }
                    }
                return Disposables.create { request.cancel() }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    public func request<E: EndPointable>(
        with request: E,
        interceptor: RequestInterceptor? = nil
    ) -> Completable {
        return Completable.create { observer in
            do {
                let urlRequest = try request.getUrlRequest()
                let request = AF.request(urlRequest, interceptor: interceptor)
                    .validate()
                    .response { response in
                        switch response.result {
                        case .success:
                            observer(.completed)
                        case .failure(let error):
                            observer(.error(error))
                        }
                    }
                return Disposables.create { request.cancel() }
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}
