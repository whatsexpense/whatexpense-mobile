//
//  Color.Core.swift
//  DesignSystem

import WEFoundation
import SwiftUI

extension WEDesignSystem.Color {
    public static let primary: SwiftUI.Color = .init(hex: "#3f83eeff")
    public static let secondary: SwiftUI.Color = .init(hex: "#1f3661ff")
    public static let danger: SwiftUI.Color = .init(hex: "#ef4444ff")

    public static let gray400: SwiftUI.Color = .init(hex: "#9ca3afff")
    public static let gray500: SwiftUI.Color = .init(hex: "#6b7280ff")
    public static let gray600: SwiftUI.Color = .init(hex: "#4b5563ff")

    public static let slate500: SwiftUI.Color = .init(hex: "#64748bff")

    public static let stone600: SwiftUI.Color = .init(hex: "#57534eff")

    public static let neutral500: SwiftUI.Color = .init(hex: "#737373ff")
}

#Preview {
    ScrollView(.vertical) {
        VStack(alignment: .leading, spacing: 10) {
            ColorPreview(name: ".primary", color: WEDS.Color.primary)
                .frame(height: 80)

            ColorPreview(name: ".secondary", color: WEDS.Color.secondary)
                .frame(height: 80)

            ColorPreview(name: ".danger", color: WEDS.Color.danger)
                .frame(height: 80)

            Divider()
                .frame(maxWidth: .infinity, idealHeight: 1.0)
                .overlay(Color.primary)
            Text("--- Core Section ---")
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .center)

            ColorPreview(name: "#gray400", color: WEDS.Color.gray400)
                .frame(height: 80)

            ColorPreview(name: "#gray500", color: WEDS.Color.gray500)
                .frame(height: 80)

            ColorPreview(name: "#gray600", color: WEDS.Color.gray600)
                .frame(height: 80)

            ColorPreview(name: "#slate500", color: WEDS.Color.slate500)
                .frame(height: 80)

            ColorPreview(name: "#stone600", color: WEDS.Color.stone600)
                .frame(height: 80)

            ColorPreview(name: "#neutral500", color: WEDS.Color.neutral500)
                .frame(height: 80)
        }
    }
}
