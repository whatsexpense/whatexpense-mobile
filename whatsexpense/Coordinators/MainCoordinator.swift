//
//  ManagementCoordinator.swift
//  whatsexpense

import SwiftUI

final class MainCoordinator:
    Coordinator,
    ObservableObject
{
    @Binding var navigationPath: NavigationPath

    var id: UUID
    private var output: Output?

    struct Output {}

    init(
        navigationPath: Binding<NavigationPath>,
        output: Output? = nil
    ) {
        id = UUID()
        self._navigationPath = navigationPath
        self.output = output
    }

    @ViewBuilder
    func view() -> some View {
        MainView(output: .init(goToSettingScreen: {
            self.goToSettingScreen()
        }))
        .environmentObject(self)
    }

    func push<V>(_ value: V) where V: Hashable {
        navigationPath.append(value)
    }
}

extension MainCoordinator: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (
        lhs: MainCoordinator,
        rhs: MainCoordinator
    ) -> Bool {
        lhs.id == rhs.id
    }
}

extension MainCoordinator {
    private func goToSettingScreen() {
        self.push(
            SettingCoordinator(navigationPath: self.$navigationPath)
        )
    }
}
