//
//  MainView.swift
//  whatsexpense

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var appState: AppState

    @ViewBuilder
    var body: some View {
        Group {
            if appState.isLoggedIn {
                mainCoordinator()
                    .transition(.opacity.animation(.easeInOut(duration: 1)))
            }
            else {
                authenticationCoordinator()
                    .transition(.opacity.animation(.easeInOut(duration: 1)))
            }
        }
        .onChange(of: appState.isLoggedIn) { _ in
            appCoordinator.clearStack()
        }
    }
}

extension RootView {
    private func mainCoordinator() -> some View {
        MainCoordinator(
            navigationPath: $appCoordinator.navigationPath,
            output: .init())
        .view()
    }

    private func authenticationCoordinator() -> some View {
        AuthenticationCoordinator(
            route: .login,
            navigationPath: $appCoordinator.navigationPath,
            output: .init())
        .view()
    }
}

//#Preview {
//    MainView()
//}
