//
//  AuthorizationApiProxy.swift
//  whatsexpense

import Combine
import KeychainAccessibility

class AuthorizationApiProxy<ApiInfoType: ApiInfo>: URLSessionAPIClient<ApiInfoType> {
    lazy var keychainStore = { KeychainWrapper.standard }()

    override func send(_ apiInfo: ApiInfoType) -> AnyPublisher<ApiInfoType.ResponseType, Error> {
        guard apiInfo.isAuthorizationNeeded else {
            return super.send(apiInfo)
        }

        guard let request = try? buildRequest(from: apiInfo) else {
            return Fail(error: NetworkError.unauthorized).eraseToAnyPublisher()
        }

        return super.send(request)
            .tryCatch({ [weak self] error -> AnyPublisher<ApiInfoType.ResponseType, Error> in
                guard let self else { return Fail(error: error).eraseToAnyPublisher() }

                guard case NetworkError.tokenExpired = error else {
                    return Fail(error: error).eraseToAnyPublisher()
                }

                return self.refreshToken()
                    .flatMap { newToken in
                        return self.send(apiInfo)
                    }
                    .eraseToAnyPublisher()
            })
            .eraseToAnyPublisher()
    }

    func buildRequest(from apiInfo: ApiInfoType) throws -> URLRequest? {
        // Check valid token if it is a authenticated api
        guard let accessToken = keychainStore.string(forKey: .accessToken),
              !accessToken.isEmpty
        else { return nil }
        return try super.buildRequest(from: apiInfo, accessToken: accessToken)
    }

    fileprivate func refreshToken() -> AnyPublisher<AuthTokenApiInfo.ResponseType, Error> {
        guard let refreshToken = keychainStore.string(forKey: .refreshToken), !refreshToken.isEmpty else {
            return Fail(error: NetworkError.unauthorized).eraseToAnyPublisher()
        }
        let authService = URLSessionAPIClient<AuthTokenApiInfo>()
        return authService.send(.refresh(token: refreshToken))
            .share()
            .handleEvents(receiveOutput: { [weak self] entity in
                guard let self else { return }
                keychainStore.set(entity.accessToken, forKey: .accessToken)
            })
            .eraseToAnyPublisher()
    }
}
