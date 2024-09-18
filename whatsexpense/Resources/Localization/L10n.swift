//
//  L10n.swift
//  whatsexpense

import SwiftUI

public extension LocalizedStringKey {
    enum L10n {
        public static var Chat: LocalizedStringKey { "Chat" }
        public static var Insights: LocalizedStringKey { "Insights" }
        public static var Settings: LocalizedStringKey { "Settings" }
        
        public static var Language: LocalizedStringKey { "Language" }
        public static var English: LocalizedStringKey { "English" }
        public static var Vietnamese: LocalizedStringKey { "Vietnamese" }

        public static var Currency: LocalizedStringKey { "Currency" }
        public static var USD: LocalizedStringKey { "USD" }
        public static var VND: LocalizedStringKey { "VND" }

        public static var SignIn: LocalizedStringKey { "SignIn" }
        public static var ForgotPassword: LocalizedStringKey { "ForgotPassword" }
        public static var SignOut: LocalizedStringKey { "SignOut" }
    }
}
