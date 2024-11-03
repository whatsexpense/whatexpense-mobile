//
//  SettingCoordinator.swift
//  whatsexpense

import SwiftUI

enum SettingPage: Hashable {
    case language
    case currency
}

final class SettingCoordinator:
    Coordinator,
    ObservableObject
{
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
        settingView()
            .navigationDestination(for: SettingPage.self) {
                switch $0 {
                    case .language: self.languageView()
                    case .currency: self.currencyView()
                }
            }
    }

    func push<V>(_ value: V) where V: Hashable {
        navigationPath.append(value)
    }

    func push(_ page: SettingPage) {
        navigationPath.append(page)
    }
}

extension SettingCoordinator {
    private func settingView() -> some View {
        return SettingView(
            output: .init(
                navigate: {
                    type in
                    switch type {
                        case .language:
                            self.push(.language)
                        case .currency:
                            self.push(.currency)
                    }
                })
        )
        .environmentObject(self)
    }

    @ViewBuilder
    private func languageView() -> some View {
        LanguageView()
    }

    @ViewBuilder
    private func currencyView() -> some View {
        CurrencyView()
    }
}

extension SettingCoordinator {
    struct Output {}
}
