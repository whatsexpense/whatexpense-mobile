//
//  SettingView.swift
//  whatsexpense

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var viewModel = SettingViewModel()
    var output: Output

    var body: some View {
        List {
            Section {
                ForEach(viewModel.dataSource, id: \.self) { model in
                    CardView(
                        title: Text(model.item.title)
                                .font(Constants.Font.ArialNarrow.regular)
                                .foregroundStyle(colorScheme == .light
                                                 ? model.color.title.light
                                                 : model.color.title.dark),
                        detail: Text(model.item.detail)
                            .font(Constants.Font.ArialNarrow.regular)
                            .foregroundStyle(colorScheme == .light
                                             ? model.color.detail.light
                                             : model.color.detail.dark),
                        associateType: .chevron,
                        action: {
                            output.navigate(model.item.destination)
                        })
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(.all)
                    .listRowInsets(EdgeInsets(.zero))
                }
            }

            Section {
                CardView(
                    title: Text(.L10n.SignOut)
                        .font(Constants.Font.ArialNarrow.regular)
                        .foregroundStyle(Constants.Color.danger),
                    action: {
                        appState.signOut()
                    })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
                .listRowInsets(EdgeInsets(.zero))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(.L10n.Settings)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}

extension SettingView {
    struct Output {
        var navigate: (SettingType) -> Void
    }
}

//#Preview {
//    SettingView(output: .init())
//}
