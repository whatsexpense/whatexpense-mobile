//
//  LoginView.swift
//  whatsexpense

import SwiftUI

struct LoginView: View {
    struct Output {
        var goToForgotPasswordScreen: () -> Void
    }

    @EnvironmentObject var appState: AppState
    var output: Output

    var body: some View {
        VStack {
            Button(
                action: { appState.signIn() },
                label: { Text(.L10n.SignIn) }
            ).padding()

            Button(
                action: { output.goToForgotPasswordScreen() },
                label: { Text(.L10n.ForgotPassword) }
            )
        }
        .screenMode(.full)
    }
}

#Preview {
    LoginView(
        output: .init(
            goToForgotPasswordScreen: {}
        )
    )
}
