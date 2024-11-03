//
//  LoginView.swift
//  whatsexpense

import SwiftUI
import UIKit

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @Injected var viewModel: LoginViewModel
    @State var isLoadding: Bool = false
    var output: Output

    init(output: Output) {
        self.output = output
    }

    var body: some View {
        VStack {
            Button(
                action: viewModel.signInGoogle,
                label: {
                    HStack {
                        Image(.google)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIConst.iconSize, height: UIConst.iconSize)

                        Text(.L10n.SignInWithGoogle)
                    }
                    .padding(.vertical, UIConst.padding.vertical)
                    .padding(.horizontal, UIConst.padding.horizontal)
                })
            .frame(width: UIConst.buttonWidth, height: 30)
            .foregroundStyle(.black)
            .clipShape(RoundedRectangle(cornerRadius: 30 / 2))
            .overlay(
                RoundedRectangle(cornerRadius: 30 / 2)
                    .stroke(.black, lineWidth: UIConst.borderWidth)
            )

            Button(
                action: viewModel.signInApple,
                label: {
                    HStack {
                        Image(systemName: "apple.logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIConst.iconSize, height: UIConst.iconSize)

                        Text(.L10n.SignInWithApple)
                    }
                    .padding(.vertical, UIConst.padding.vertical)
                    .padding(.horizontal, UIConst.padding.horizontal)
                })
            .frame(width: UIConst.buttonWidth, height: 32)
            .background(.black)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 32 / 2))

            Button(
                action: { isLoadding.toggle() },
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

extension LoginView {
    struct Output {
        var goToForgotPasswordScreen: () -> Void
    }

    enum UIConst {
        static var iconSize: CGFloat { 18.0 }
        static var padding: (horizontal: CGFloat, vertical: CGFloat) { (12.0, 6.0) }
        static var borderWidth: CGFloat { 1.0 }

        static var buttonWidth: CGFloat { 250 }
    }
}

#Preview {
    LoginView(
        output: .init(
            goToForgotPasswordScreen: {}
        )
    )
}
