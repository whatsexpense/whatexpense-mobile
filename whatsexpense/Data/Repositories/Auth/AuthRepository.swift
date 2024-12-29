//
//  AuthRepository.swift
//  whatsexpense

import Combine
import KeychainAccessibility

extension AuthError: ErrorCustomizable {
    public init(code: Int, data: [String : Any]?, message: String?) {
        self = .authenticationFailed
    }
    
    public init(clientErrorCode: NetworkError) {
        self = .common("Something went wrong")
    }
}

extension AuthenticatorEntity: Receivable {}

public enum AuthTokenApiInfo: ApiInfo {
    public typealias RequestType = Request
    public typealias ResponseType = AuthenticatorEntity
    public typealias ErrorType = AuthError

    case auth(token: String, provider: AuthProvider)
    case refresh(token: String)

    public var endPoint: String {
        switch self {
            case .auth(_, _): "/api/v1/auth/oauth/sign-in"
            case .refresh(_): "/api/v1/auth/renew"
        }
    }

    public var urlParams: [String : String?] {
        switch self {
            case .refresh(let token): ["refreshToken": token]
            default: [:]
        }
    }

    public var params: [String: Any] {
        switch self {
            case let .auth(token, provider):
                ["code": token, "provider": provider.rawValue]
            default: [:]
        }
    }

    public var isAuthorizationNeeded: Bool { false }

    public var methodType: MethodType {
        switch self {
            case .auth(_, _): .post
            case .refresh(_): .get
        }
    }

    public struct Request: Requestable {}
}

public struct AuthRepository: AuthServicing {
    private let keychainStore = KeychainWrapper.standard
    private var apiService: URLSessionAPIClient<AuthTokenApiInfo>

    public init(apiService: URLSessionAPIClient<AuthTokenApiInfo>) {
        self.apiService = apiService
    }

    public func signIn(
        token: String,
        provider: AuthProvider
    ) -> AnyPublisher<AuthenticatorEntity, Error> {
        return apiService.send(.auth(token: token, provider: provider))
            .handleEvents(receiveOutput: { entity in
                keychainStore.set(entity.accessToken, forKey: .accessToken)
                keychainStore.set(entity.refreshToken, forKey: .refreshToken)
            })
            .eraseToAnyPublisher()
    }

    func autoSignIn() -> AnyPublisher<AuthenticatorEntity, Error> {
        guard let refreshToken = keychainStore.string(forKey: .refreshToken),
              !refreshToken.isEmpty
        else {
            return Fail(error: NetworkError.unauthorized).eraseToAnyPublisher()
        }
        return apiService.send(.refresh(token: refreshToken))
            .handleEvents(receiveOutput: { entity in
                keychainStore.set(entity.accessToken, forKey: .accessToken)
            })
            .eraseToAnyPublisher()
    }

    func signOut() -> AnyPublisher<Bool, Never> {
        keychainStore.removeObject(forKey: .accessToken)
        keychainStore.removeObject(forKey: .refreshToken)
        return Just(true).eraseToAnyPublisher()
    }
}
