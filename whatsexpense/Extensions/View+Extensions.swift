//
//  SwiftUIView.swift
//  whatsexpense

import SwiftUI

public enum ScreenMode {
    case full
    case center
}

public extension View {
    @inlinable
    func screenMode(_ mode: ScreenMode) -> some View {
        switch mode {
            case .full:
                self.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea(.all)
            default:
                self.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea(.all)
        }
    }
}
