//
//  environment.swift
//  whatsexpense

extension String {
    public static let debug = "DEBUG"
    public static let production = "PRODUCTION"
}

public var __env__: String {
#if DEBUG || BUILD_INTERNAL
    return .debug
#else
    return .production
#endif
}

public protocol AbstractAppEnvironment {
    static var baseUrl: String { get }

    static var googleClientID: String { get }
    static var googleServerID: String { get }
}

#if DEBUG || BUILD_INTERNAL
typealias AppEnvironment = DebugAppEnvironment
#else
typealias AppEnvironment = ProductionAppEnvironment
#endif
