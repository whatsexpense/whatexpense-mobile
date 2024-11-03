//
//  AppCoordinator.swift
//  whatsexpense

import SwiftUI

protocol Coordinator: Hashable {
    var id: UUID { get set }
    var navigationPath: NavigationPath { get set }
}

extension Coordinator {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class AppCoordinator:
    Coordinator,
    ObservableObject
{
    var id = UUID()
    @Published var navigationPath: NavigationPath

    init(path: NavigationPath) {
        self.navigationPath = path
    }
    
    @ViewBuilder
    func view() -> some View {
        RootView()
    }

    func push<V>(_ value: V) where V: Hashable {
        navigationPath.append(value)
    }

    @MainActor
    func clearStack() {
        navigationPath.removeLast(navigationPath.count)
    }
}
