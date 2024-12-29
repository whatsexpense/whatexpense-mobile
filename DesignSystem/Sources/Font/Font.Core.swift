//
//  Font.Core.swift
//  DesignSystem

import SwiftUI

public extension WEDesignSystem.Font {
    enum ArialNarrow {
        public static var regular: SwiftUI.Font { .custom("ArialNarrow", size: 14) }
        public static var italic: SwiftUI.Font { .custom("ArialNarrow_Italic", size: 14) }
        public static var bold: SwiftUI.Font { .custom("ArialNarrow_Bold", size: 20) }
        public static var boldItalic: SwiftUI.Font { .custom("ArialNarrow_Bold_Italic", size: 20) }
    }
}

#Preview {
    ScrollView(.vertical) {
        VStack(spacing: 10) {
            FontPreview(name: "ArialNarrow.regular", font: WEDS.Font.ArialNarrow.regular)
                .frame(height: 40)

            FontPreview(name: "ArialNarrow.italic", font: WEDS.Font.ArialNarrow.italic)
                .frame(height: 40)

            FontPreview(name: "ArialNarrow.bold", font: WEDS.Font.ArialNarrow.bold)
                .frame(height: 40)

            FontPreview(name: "ArialNarrow.boldItalic", font: WEDS.Font.ArialNarrow.boldItalic)
                .frame(height: 40)
        }
    }
}
