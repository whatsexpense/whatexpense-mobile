//
//  GoogleAuthUseCase.swift
//  whatsexpense

import Foundation
import UIKit

public protocol GoogleAuthServicing {
    func configure()
    func signIn(
        rootViewController: UIViewController,
        hint: String?,
        additionalScopes: [String]?,
        onResponse: @escaping (Result<String, Error>) -> Void
    )
}

public class GoogleAuthInteractor {
    @Injected private var service: GoogleAuthServicing

    public init() {
        service.configure()
    }

    public func signIn(
        rootViewController: UIViewController,
        hint: String? = nil,
        additionalScopes: [String]? = nil,
        onResponse: @escaping (Result<String, Error>) -> Void
    ) {
        service.signIn(
            rootViewController: rootViewController,
            hint: hint,
            additionalScopes: additionalScopes,
            onResponse: onResponse
        )
    }
}
