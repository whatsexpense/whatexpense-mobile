//
//  AuthenticationCoordinator.swift
//  whatsexpense

import SwiftUI

enum AuthenticationRoute {
    case login, forgotPassword
}

final class AuthenticationCoordinator: 
    Coordinator,
    ObservableObject
{
    var id: UUID
    @Binding var navigationPath: NavigationPath

    private var route: AuthenticationRoute
    private var output: Output?

    struct Output {
    }

    init(
        route: AuthenticationRoute,
        navigationPath: Binding<NavigationPath>,
        output: Output? = nil
    ) {
        id = UUID()
        self.route = route
        self.output = output
        self._navigationPath = navigationPath
    }

    @ViewBuilder
    func view() -> some View {
        switch route {
            case .login: observable(loginView())
            case .forgotPassword: observable(forgotPasswordView())
        }
    }

    func observable(_ view: some View) -> some View {
        view.environmentObject(self)
    }
}

extension AuthenticationCoordinator {
    func openWebsite(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }

    func push<V>(_ value: V) where V: Hashable {
        navigationPath.append(value)
    }
}

extension AuthenticationCoordinator {
    private func loginView() -> some View {
        return LoginView(
            output: .init(
                goToForgotPasswordScreen: {
                    self.push(
                        AuthenticationCoordinator(route: .forgotPassword,
                                                  navigationPath: self.$navigationPath))
            })
        )
    }

    private func forgotPasswordView() -> some View {
        ForgotPasswordView(
            output: .init(openForgotPasswordWebsite: {
                self.openWebsite("https://www.google.com")
            })
        )
    }
}

extension AuthenticationCoordinator: Hashable {
    static func == (lhs: AuthenticationCoordinator, rhs: AuthenticationCoordinator) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
