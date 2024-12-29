//
//  Dependencies.swift
//  whatsexpense

extension DIContainer {
    func registerDependencies() {
        // MARK: Login
        register(AuthServicing.self, {
            let service = URLSessionAPIClient<AuthTokenApiInfo>()
            return AuthRepository(apiService: service)
        })

        register(GoogleAuthServicing.self, { GoogleAuthWorker() })
        register(GoogleAuthInteractor.self, { GoogleAuthInteractor() })
        register(AppleAuthServicing.self, { AppleAuthWorker() })
        register(AppleAuthInteractor.self, { AppleAuthInteractor() })

        register(AuthUseCase.self, { AuthUseCase() })
        register(LoginViewModel.self, { LoginViewModel() })

        // MARK: Main

        // MARK: Setting
        register(SettingViewModel.self, { SettingViewModel() })
    }
}

