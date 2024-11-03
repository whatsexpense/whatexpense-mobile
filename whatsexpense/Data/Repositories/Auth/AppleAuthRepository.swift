//
//  AppleAuthRepository.swift
//  whatsexpense

import Foundation
import AuthenticationServices

public class AppleAuthWorker: NSObject, AppleAuthServicing {
    public func signIn() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension AppleAuthWorker:
    ASAuthorizationControllerDelegate,
    ASAuthorizationControllerPresentationContextProviding
{
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else {
            assertionFailure("There is no window!")
            return UIWindow()
        }

        return window
    }

    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
          guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return
          }

          guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
          }

          let userIdentifier = appleIDCredential.user
          let fullName = appleIDCredential.fullName
          let email = appleIDCredential.email ?? "n/a"

          print(idTokenString)
          print(userIdentifier)
          print(fullName)
          print(email)
        }
      }

    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        // Handle error.
        guard let error = error as? ASAuthorizationError else { return }

        switch error.code {
            case .canceled:
                print("Canceled")
            case .unknown:
                print("Unknown")
            case .invalidResponse:
                print("Invalid Respone")
            case .notHandled:
                print("Not handled")
            case .failed:
                print("Failed")
            case .notInteractive:
                print("notInteractive")
            @unknown default:
                print("Default")
        }
    }
}
