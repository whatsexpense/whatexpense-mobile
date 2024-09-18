//
//  ForgotPasswordView.swift
//  whatsexpense

import SwiftUI

struct ForgotPasswordView: View {
    struct Output {
        var openForgotPasswordWebsite: () -> Void
    }

    var output: Output

    var body: some View {
        Button(
            action: { output.openForgotPasswordWebsite() },
            label: { Text("Open Website") }
        ).padding()
    }
}

#Preview {
    ForgotPasswordView(output: .init(openForgotPasswordWebsite: {}))
}
