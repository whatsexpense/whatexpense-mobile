//
//  AuthUseCase.swift
//  whatsexpense

import Foundation
import Combine

typealias AuthenticationSystem = AuthUseCase

public enum AuthProvider: String {
    case google = "Google"
    case apple = "Apple"
    case password = "Password"
}

public enum AuthError {
    case authenticationFailed
    case common(_ message: String)
}

protocol AuthServicing {
    func signIn(
        token: String,
        provider: AuthProvider
    ) -> AnyPublisher<AuthenticatorEntity, Error>

    func autoSignIn() -> AnyPublisher<AuthenticatorEntity, Error>
    func signOut() -> AnyPublisher<Bool, Never>
}

struct AuthUseCase {
    @Injected var service: AuthServicing

    func signIn(
        token: String,
        provider: AuthProvider
    ) -> AnyPublisher<AuthenticatorEntity, Error> {
        return service.signIn(token: token, provider: provider)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { _ in
                AppState.shared.signIn()
            })
            .eraseToAnyPublisher()
    }

    func signOut() -> AnyPublisher<Bool, Never> {
        return service.signOut()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { _ in
                AppState.shared.signOut()
            })
            .eraseToAnyPublisher()
    }
}
