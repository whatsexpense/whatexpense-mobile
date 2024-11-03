//
//  GoogleAuthRepository.swift
//  whatsexpense

import Foundation
import GoogleSignIn

public let googleAuthenticationErrorDomain = "GoogleAuthenticationErrorDomain"

public class GoogleAuthWorker: GoogleAuthServicing {
    public func configure() {
        GIDSignIn.sharedInstance.configuration = .init(
            clientID: AppEnvironment.googleClientID,
            serverClientID: AppEnvironment.googleServerID
        )
    }

    public func signIn(
        rootViewController: UIViewController,
        hint: String?,
        additionalScopes: [String]?,
        onResponse: @escaping (Result<String, Error>) -> Void
    ) {
        GIDSignIn.sharedInstance.signIn(
            withPresenting: rootViewController,
            hint: nil,
            additionalScopes: ["profile", "email"],
            completion: { [weak self] result, error in
                guard let self else { return }
                if let error { return onResponse(.failure(error)) }
                guard let idToken = result?.user.idToken?.tokenString else {
                    let error = NSError(
                        domain: googleAuthenticationErrorDomain,
                        code: -1
                    )
                    return onResponse(.failure(error))
                }

                return onResponse(.success(idToken))
            }
        )
    }
}
