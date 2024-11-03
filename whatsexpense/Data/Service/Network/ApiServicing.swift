//
//  ApiServicing.swift
//  whatsexpense

import Foundation
import Combine

public protocol Requestable: Encodable {}

public protocol Receivable: Decodable {}

public let WEClientErrorDomain = "WEClientErrorDomain"
public enum WEClientErrorCode: Int {
    case unknown = -1
}

public protocol ErrorCustomizable {
    init(code: Int, data: [String: Any]?, message: String?)
    init(clientErrorCode: NetworkError)
}

extension String {
    static let http: String = "http"
    static let https: String = "https"
}

public enum MethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public protocol ApiInfo {
    associatedtype RequestType: Requestable
    associatedtype ResponseType: Receivable
    associatedtype ErrorType: ErrorCustomizable

    var endPoint: String { get }

    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var urlParams: [String: String?] { get }
    var isAuthorizationNeeded: Bool { get }
    var methodType: MethodType { get }
}

extension ApiInfo {
    public var host: String { AppEnvironment.baseUrl }

    public var isAuthorizationNeeded: Bool { true }

    public var params: [String: Any] { [:] }

    public var urlParams: [String: String?] { [:] }

    public var headers: [String: String] { [:] }

    public func createURLRequest(_ accessToken: String? = nil) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = .https
        components.host = host
        components.path = endPoint

        if !urlParams.isEmpty {
            components.queryItems = urlParams.map {
                URLQueryItem(name: $0, value: $1)
            }
        }

        guard let url = components.url
        else { throw NetworkError.invalidURL }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = methodType.rawValue

        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }

        if isAuthorizationNeeded, let accessToken, !accessToken.isEmpty {
            urlRequest.setValue(accessToken,
                                forHTTPHeaderField: "Authorization")
        }

        urlRequest.setValue("application/json",
                            forHTTPHeaderField: "Content-Type")

        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }

        return urlRequest
    }
}

public protocol APIClient {
    associatedtype ApiInfoType: ApiInfo

    func send(_ apiInfo: ApiInfoType) -> AnyPublisher<ApiInfoType.ResponseType, Error>
}
