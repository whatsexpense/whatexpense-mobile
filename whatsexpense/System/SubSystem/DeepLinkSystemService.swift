//
//  DeepLinkSystemService.swift
//  whatsexpense

import Foundation

enum DeepLink: Equatable {

    case showStatistic(value: String)

    init?(url: URL) {
        guard
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            components.host == "www.example.com",
            let query = components.queryItems
            else { return nil }
        if let item = query.first(where: { $0.name == "code" }),
            let value = item.value {
            self = .showStatistic(value: value)
            return
        }
        return nil
    }
}

protocol DeepLinkSystem {
    func open(deepLink: DeepLink)
}

struct DeepLinkSystemService: DeepLinkSystem {

    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }

    func open(deepLink: DeepLink) {
        switch deepLink {
            case let .showStatistic(value):
                return
        }
    }
}

