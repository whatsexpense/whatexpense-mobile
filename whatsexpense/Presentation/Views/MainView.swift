//
//  ManagementView.swift
//  whatsexpense

import SwiftUI

// MARK: - Tabs Builder
enum Tabs: Int, CaseIterable, Hashable {
    case chat = 0
    case insights = 1

    var title: LocalizedStringKey {
        switch self {
            case .chat: .L10n.Chat
            case .insights: .L10n.Insights
        }
    }

    var icon: String {
        switch self {
            case .chat: "message"
            case .insights: "chart.bar"
        }
    }

    @ViewBuilder
    func view() -> some View {
        switch self {
            case .chat: ChatView()
            case .insights: InsightsView()
        }
    }
}

// MARK: - Main View
struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var selectedTab = 0

    let tabs: [Tabs] = [.chat, .insights]
    var output: Output

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(tabs, id: \.self) { tab in
                tab.view()
                   .tabItem {
                       Label(tab.title, systemImage: tab.icon)
                           .environment(\.symbolVariants, selectedTab == tab.rawValue ? .fill : .none)
                   }
                   .tag(tab.rawValue)
            }
        }
        .toolbar(.visible, for: .navigationBar, .tabBar)
        .toolbar(content: {
            Button(
                action: {
                    output.goToSettingScreen()
                },
                label: {
                    Image(systemName: "gear")
                        .foregroundStyle(colorScheme == .light
                                         ? Constants.Color.secondary
                                         : Constants.Color.primary)
                })
        })
        .screenMode(.full)
        .tint(colorScheme == .light
              ? Constants.Color.secondary
              : Constants.Color.primary)
    }
}

extension MainView {
    struct Output {
        var goToSettingScreen: () -> Void
    }
}

#Preview {
    MainView(output: .init(goToSettingScreen: {}))
}
