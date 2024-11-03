//
//  Dependencies.swift
//  whatsexpense

extension DIContainer {
    func registerDependencies() {
        // MARK: Login
        register(AuthServicing.self, { AuthRepository() })
        register(AuthUseCase.self, { AuthUseCase() })

        register(GoogleAuthServicing.self, { GoogleAuthWorker() })
        register(GoogleAuthInteractor.self, { GoogleAuthInteractor() })
        register(AppleAuthServicing.self, { AppleAuthWorker() })
        register(AppleAuthInteractor.self, { AppleAuthInteractor() })

        register(LoginViewModel.self, { LoginViewModel() })

        // MARK: Main
        
    }
}

