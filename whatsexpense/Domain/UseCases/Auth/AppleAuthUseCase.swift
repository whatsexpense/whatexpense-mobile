//
//  AppleAuthUseCase.swift
//  whatsexpense

import Foundation
import AuthenticationServices

public protocol AppleAuthServicing {
    func signIn()
}

public class AppleAuthInteractor {
    @Injected private var service: AppleAuthServicing

    init () {
        self.service = service
    }

    func signIn() {
        service.signIn()
    }
}
