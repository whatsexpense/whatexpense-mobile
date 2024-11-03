//
//  SettingViewModel.swift
//  whatsexpense

import SwiftUI
import Combine

// MARK: - UI Model
enum SettingType {
    case language
    case currency
}

public struct SettingItem {
    let title: LocalizedStringKey
    let detail: LocalizedStringKey
    let destination: SettingType

    init(
        title: LocalizedStringKey,
        detail: LocalizedStringKey,
        destination: SettingType
    ) {
        self.title = title
        self.detail = detail
        self.destination = destination
    }
}

struct SettingItemUI: Identifiable, Hashable {
    typealias ItemColor = (light: Color, dark: Color)

    let id: UUID = UUID()
    var item: SettingItem
    var color: (title: ItemColor, detail: ItemColor)

    init(
        item: SettingItem,
        color: (title: ItemColor?, detail: ItemColor?)
    ) {
        self.item = item
        self.color = (
            color.title ?? (.primary, .primary),
            color.detail ?? (.secondary, .secondary)
        )
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: SettingItemUI, rhs: SettingItemUI) -> Bool { lhs.id == rhs.id }
}

// MARK: - ViewModel
class SettingViewModel {
    private var cancellables = DisposeBag()
    @Injected private var useCase: AuthUseCase

    deinit {
        cancellables.cancel()
    }

    var dataSource: [SettingItemUI] {
        [
            SettingItemUI(
                item: SettingItem(
                    title: .L10n.Currency,
                    detail: .L10n.USD,
                    destination: .currency
                ),
                color: (title: nil, detail: nil)
            ),
            SettingItemUI(
                item: SettingItem(
                    title: .L10n.Language,
                    detail: AppState.shared.system.language == .en
                            ? .L10n.English
                            : .L10n.Vietnamese,
                    destination: .language
                ),
                color: (title: nil, detail: nil)
            ),
        ]
    }

    func signOut() {
        useCase.signOut()
            .sink(receiveValue: { _ in })
            .store(in: cancellables)
    }
}
