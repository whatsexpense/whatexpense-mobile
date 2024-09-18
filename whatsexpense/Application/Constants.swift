//
//  Constants.swift
//  whatsexpense

import SwiftUI

public enum Constants {
    public enum Color {
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

    public enum Font {
        public enum ArialNarrow {
            public static var regular: SwiftUI.Font { .custom("ArialNarrow", size: 14) }
            public static var italic: SwiftUI.Font { .custom("ArialNarrow_Italic", size: 14) }
            public static var bold: SwiftUI.Font { .custom("ArialNarrow_Bold", size: 20) }
            public static var boldItalic: SwiftUI.Font { .custom("ArialNarrow_Bold_Italic", size: 20) }
        }
    }
}
