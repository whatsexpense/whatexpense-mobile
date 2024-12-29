//
//  DesignSystem_Previews.swift
//  DesignSystem

import SwiftUI
import WEFoundation

struct DesignSystem_Previews: View {
    var body: some View {
        Text("Preview Components")
    }
}

struct ColorPreview: View {
    let name: String
    let color: Color

    var body: some View {
        ZStack {
            color
            Text(name).contrastTint(with: color)
        }
    }
}

struct FontPreview: View {
    let name: String
    let font: Font

    var body: some View {
        Divider()
            .frame(minHeight: 1.0)
        Text(name)
            .font(font)
        Divider()
            .frame(minHeight: 1.0)
    }
}

#Preview {
    VStack(spacing: 20) {
        ColorPreview(name: "primary", color: WEDS.Color.primary)
            .frame(width: .infinity, height: 80)

        FontPreview(name: "ArialNarrow.regular", font: WEDS.Font.ArialNarrow.regular)
            .frame(width: .infinity, height: 40)
    }
}
