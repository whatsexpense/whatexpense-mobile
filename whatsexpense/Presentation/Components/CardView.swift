//
//  CardView.swift
//  whatsexpense

import SwiftUI

enum CardViewAssociateType {
    case chevron
    case none
}

struct CardView: View {
    var image: Image?
    var title: Text
    var detail: Text?
    var associateType: CardViewAssociateType = .none
    var action: (() -> Void)? = nil

    var body: some View {
        HStack {
            if let image {
                image.resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 20, height: 20)
            }
            title
            Spacer()
            if let detail { detail }
            if associateType != .none {
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .contentShape(Rectangle())
        .onTapGesture {
            action?()
        }
    }
}

#Preview {
    CardView(
        image: Image(systemName: "dollarsign.square"),
        title: Text(.L10n.Currency),
        detail: Text("$"),
        associateType: .chevron
    )
}
