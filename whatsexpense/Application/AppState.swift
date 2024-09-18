//
//  AppState.swift
//  whatsexpense

import Foundation
import SwiftUI

extension String {
    static let en: String = "en"
    static let vi: String = "vi"
}

class AppState: ObservableObject {
    static let shared = AppState()

    @Published private(set) var isLoggedIn: Bool = false

    var userData = UserData()
    var routing = ViewRouting()
    var system = System()
    var permissions = Permissions()

    func signIn() {
        isLoggedIn = true
    }

    func signOut() {
        isLoggedIn = false
    }
}

extension AppState: Equatable {
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        lhs.userData.id == rhs.userData.id
    }
}

extension AppState {
    class UserData: Identifiable {}
}

extension AppState {
    class ViewRouting {}
}

extension AppState {
    class System {
        var language: String {
            return Locale.preferredLanguages.first ?? .en
        }
    }
}

extension AppState {
    class Permissions {}
}
