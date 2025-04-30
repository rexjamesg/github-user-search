//
//  APIRouter.swift
//  GithubAPI
//
//  Created by Yu Li Lin on 2025/4/30.
//

import Foundation
import Alamofire

public typealias Parameters = [String: Any]
public typealias Headers = [String: String]

// MARK: - APIRouter

enum APIRouter: URLRequestConvertible {
    case searchUsers(query: String, page: Int)
}

extension APIRouter {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    var path: String {
        switch self {
        case .searchUsers:
            return "/search/users"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .searchUsers:
            return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case let .searchUsers(query, page):
            return ["q": query, "page": page]
        }
    }

    var headers: Headers? {
        return nil
    }

    // 5. URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        // GET 用 URLEncoded；POST/PUT 等用 JSON Encoder
        if let params = parameters {
            request = try URLEncoding.default.encode(request, with: params)
            print("request", request)
        }

        // 全域 Header（若有）
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        // e.g. add auth token if needed:
        // request.setValue("Bearer \(TokenManager.shared.token)", forHTTPHeaderField: "Authorization")

        return request
    }
}
