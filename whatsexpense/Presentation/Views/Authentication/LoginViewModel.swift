//
//  LoginViewModel.swift
//  whatsexpense

import AuthenticationServices
import Combine

class LoginViewModel: NSObject {
    @Injected private var useCase: AuthUseCase
    @Injected private var googleInteractor: GoogleAuthInteractor
    @Injected private var appleInteractor: AppleAuthInteractor
    private var cancellables = DisposeBag()

    deinit {
        cancellables.cancel()
    }

    func signInGoogle() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController
        else {
            print("There is no root view controller!")
            return
        }

        googleInteractor.signIn(
            rootViewController: rootViewController,
            additionalScopes: ["profile", "email"],
            onResponse: { [weak self] result in
                guard let self else { return }
                switch result {
                    case .success(let idToken):
                        useCase.signIn(token: idToken, provider: .google)
                            .receive(on: RunLoop.main)
                            .sink(
                                receiveCompletion: { data in
                                    dump(data)
                                },
                                receiveValue: { data in
                                    dump(data)
                                })
                            .store(in: cancellables)

                    case .failure(let error):
                        assertionFailure("[Google] \(error.localizedDescription)")
                        return
                }
            }
        )
    }

    func signInApple() {
        appleInteractor.signIn()
    }
}
