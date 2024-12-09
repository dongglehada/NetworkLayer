import XCTest
import OSLog

import RxSwift

@testable import NetworkLayer

final class NetworkLayerTests: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    func testDefaultProvider() throws {
        let provider: Provider = DefaultProvider()
        
        struct JokeResponse: Decodable {
            var type: String?
            var setup: String?
            var punchline: String?
            var id: Int
        }
        
        let endPoint = Endpoint<JokeResponse>(baseURL: "https://official-joke-api.appspot.com/random_joke")
        
        provider.requestData(with: endPoint, interceptor: nil)
            .subscribe(onNext: { response in
                XCTAssertNotNil(response.type, "type should not be nil")
                XCTAssertNotNil(response.setup, "setup should not be nil")
                XCTAssertNotNil(response.punchline, "punchline should not be nil")
                XCTAssertNotNil(response.id, "id should not be nil")
            }, onError: { error in
                XCTFail("Network request failed with error: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
