//
//  SettingCoordinator.swift
//  whatsexpense

import SwiftUI

final class SettingCoordinator:
    Coordinator,
    ObservableObject
{
    struct Output {}

    @Binding var navigationPath: NavigationPath

    var id: UUID
    private let output: Output?

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
        SettingView(
            output: .init(
                navigate: {
                    type in
                    switch type {
                        case .language:
                            self.push(LanguageCoordinator(navigationPath: self.$navigationPath))
                        case .currency:
                            self.push(LanguageCoordinator(navigationPath: self.$navigationPath))
                    }
                })
        )
        .environmentObject(self)
    }

    func push<V>(_ value: V) where V: Hashable {
        navigationPath.append(value)
    }
}

// MARK: - Language Coordinator
final class LanguageCoordinator: 
    Coordinator,
    ObservableObject
{
    @Binding var navigationPath: NavigationPath

    var id: UUID
    private var output: Output?

    init(
        navigationPath: Binding<NavigationPath>,
        output: Output? = nil
    ) {
        id = UUID()
        self.output = output
        self._navigationPath = navigationPath
    }

    @ViewBuilder
    func view() -> some View {
        LanguageView()
    }
}

extension LanguageCoordinator {
    struct Output {

    }
}

// MARK: - Currency Coordinator
final class CurrencyCoordinator:
    Coordinator,
    ObservableObject
{
    @Binding var navigationPath: NavigationPath

    var id: UUID
    private var output: Output?

    init(
        navigationPath: Binding<NavigationPath>,
        output: Output? = nil
    ) {
        id = UUID()
        self.output = output
        self._navigationPath = navigationPath
    }

    @ViewBuilder
    func view() -> some View {
        CurrencyView()
    }
}

extension CurrencyCoordinator {
    struct Output {}
}
