//
//  APIClient.swift
//  GithubAPI
//
//  Created by Yu Li Lin on 2025/4/30.
//

import Foundation
import Combine
import Alamofire

class APIClient {
    static let shared = APIClient()
    private init() {}
    
    func request<T: Decodable>(_ router: APIRouter, type: T.Type) -> AnyPublisher<T, AFError> {
        AF.request(router)
            .validate()
            .publishDecodable(type: T.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
