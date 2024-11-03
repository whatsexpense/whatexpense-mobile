//
//  ApiService.swift
//  whatsexpense

import Foundation
import Combine

public enum NetworkError: Decodable, Error {
    case unknown
    case invalidURL
    case invalidRequest
    case invalidResponse
    case dataNotFound
    case noInternetConnection
    case connectionTimeOut
    case badRequest
    case tokenExpired
    case unauthorized
    case clientError(_ code: Int, _ message: String?)

    var rawValue: Int {
        switch self {
            case .invalidURL, .invalidRequest, .invalidResponse: 1
            case .dataNotFound: 2
            case .noInternetConnection: -1000
            case .connectionTimeOut: -500
            case .badRequest: 502
            case .tokenExpired: 401
            case .unauthorized: 403
            case .clientError(let code, _): code
            case .unknown: -1
        }
    }
}

struct NetworkQueue {
    public static let networkQueue = DispatchQueue(label: "com.NetworkQueue", 
                                                   attributes: .concurrent)
}

public class URLSessionAPIClient<ApiInfoType: ApiInfo>: APIClient {
    public func send(_ apiInfo: ApiInfoType) -> AnyPublisher<ApiInfoType.ResponseType, Error> {
        guard let request = try? buildRequest(from: apiInfo) else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }

#if DEBUG
        dump(request, name: "[API Service][DEBUG] Request:")
#endif

        return send(request)
    }

    func buildRequest(from apiInfo: ApiInfoType, accessToken: String? = nil) throws -> URLRequest? {
        return try apiInfo.createURLRequest(accessToken)
    }

    func send(_ request: URLRequest) -> AnyPublisher<ApiInfoType.ResponseType, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: NetworkQueue.networkQueue)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse
                else { throw NetworkError.invalidResponse }

#if NETWORK_DEBUG
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("[API Service][DEBUG] response JSON: -\(httpResponse.statusCode)- \(json)")
                    }
                } catch let error as NSError {
                    fatalError("Failed to load: \(error.localizedDescription)")
                }
#endif

                switch httpResponse.statusCode {
                    case 200...299:
                        return data
                    case 401:
                        // session Token expired
                        throw NetworkError.tokenExpired
                    default:
                        throw NetworkError.badRequest
                }
            }
            // .retry(3)
            .decode(type: ApiInfoType.ResponseType.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

