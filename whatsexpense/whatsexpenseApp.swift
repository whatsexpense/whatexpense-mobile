//
//  whatsexpenseApp.swift
//  whatsexpense

import SwiftUI

@main
struct whatsexpenseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject private var appCoordinator = AppCoordinator(path: .init())
    @StateObject private var appState = AppState.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack(
                path: $appCoordinator.navigationPath,
                root: {
                    appCoordinator
                        .view()
                        .routes()
                })
            .environmentObject(appState)
            .environmentObject(appCoordinator)
        }
    }
}

private extension View {
    func routes() -> some View {
        self
        .navigationDestination(
            for: AuthenticationCoordinator.self,
            destination: { $0.view() }
        )
        .navigationDestination(
            for: MainCoordinator.self,
            destination: { $0.view() }
        )
        .navigationDestination(
            for: SettingCoordinator.self,
            destination: { $0.view() }
        )
    }
}
