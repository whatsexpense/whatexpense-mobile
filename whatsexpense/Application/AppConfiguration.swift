//
//  AppConfiguration.swift
//  whatsexpense

import Foundation

@MainActor
struct AppConfiguration {
//    let container: DIContainer
//    let systemEventsService: SystemEventsCenter
}

extension AppConfiguration {

    static func bootstrap() -> AppConfiguration {
        return AppConfiguration()
    }

    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
}
