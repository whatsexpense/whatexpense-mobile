//
//  Text+Extensions.swift
//  whatsexpense

import SwiftUI

public extension Text {
    @inlinable
    @available(iOS 15, *)
    @backDeployed(before: iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0)
    func adaptableForegroundStyle(_ color: Color) -> Text {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
            return self.foregroundStyle(color)
        }
        else {
            return self.foregroundColor(color)
        }
    }

    @inline(__always)
    func contrastTint(with backgroundColor: Color) -> some View {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        UIColor(backgroundColor).getRed(&r, green: &g, blue: &b, alpha: &a)
        let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  luminance < 0.6 ? self.foregroundColor(.white) : self.foregroundColor(.black)
    }
}
