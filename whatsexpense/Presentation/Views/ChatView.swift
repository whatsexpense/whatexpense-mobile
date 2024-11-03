//
//  ChatView.swift
//  whatsexpense

import SwiftUI

struct ChatView: View {
    var body: some View {
        ZStack {
            Text(.L10n.Chat)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}
