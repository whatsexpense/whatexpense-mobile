//
//  Text+Extensions.swift
//  whatsexpense

import SwiftUI

extension Text {
    @inlinable
    @available(iOS 15, *)
    @backDeployed(before: iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0)
    public func adaptableForegroundStyle(_ color: Color) -> Text {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
            return self.foregroundStyle(color)
        }
        else {
            return self.foregroundColor(color)
        }
    }
}
