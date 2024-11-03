//
//  DependencyInjector.swift
//  whatsexpense

import SwiftUI
import Combine

#if UNIT_TEST
fileprivate let testEnv: Bool = true
#else
fileprivate let testEnv: Bool = false
#endif

// MARK: - DIContainer
@propertyWrapper
struct Injected<Dependency> {
    var wrappedValue: Dependency

    init() {
        wrappedValue = DIContainer.shared.resolve(Dependency.self)
    }
}

class DIContainer {
    static let shared = DIContainer()

    private let lock = ReadWriteLock()
    private var services: [String: Any] = [:]

    // MARK: Register
    func register<T>(
        _ type: T.Type,
        _ service: @escaping () -> T,
        _ mock: (() -> T)? = nil
    ) {
#if DEBUG
        print("[Dependency Injection] Registered \(T.self)")
#endif
        if testEnv, let mock {
            lock.acquireWriteLock {
                services[String(describing: T.self)] = mock
            }
            return
        }

        lock.acquireWriteLock {
            services[String(describing: T.self)] = service
        }
    }

    func register<X, T>(
        _ type: T.Type,
        _ service: @escaping (X) -> T,
        _ mock: ((X) -> T)? = nil
    ) {
#if DEBUG
        print("[Dependency Injection] Registered \(T.self)")
#endif
        if testEnv, let mock {
            lock.acquireWriteLock {
                services[String(describing: T.self)] = mock
            }
            return
        }

        lock.acquireWriteLock {
            services[String(describing: T.self)] = service
        }
    }

    // MARK: Resolve
    func resolve<T>(_ serviceType: T.Type) -> T {
        var dependencyCreation: Any?
        lock.acquireReadLock {
            dependencyCreation = services[String(describing: T.self)]
        }

        guard let dependency = dependencyCreation as? () -> T
        else {
            fatalError("‼️‼️‼️ Missing dependency: \(T.self) - Check your code again ‼️‼️‼️")
        }
#if DEBUG
        let instant = dependency()
        print("[Dependency Injection] Resolved \(T.self) with \(instant.self)")
        return instant
#endif
        return dependency()
    }


    func resolve<X, T>(_ serviceType: T.Type, params: X) -> T {
        var dependencyCreation: Any?
        lock.acquireReadLock {
            dependencyCreation = services[String(describing: T.self)]
        }

        guard let dependency = dependencyCreation as? (X) -> T
        else {
            fatalError("‼️‼️‼️ Missing dependency: \(T.self) - Check your code again ‼️‼️‼️")
        }
#if DEBUG
        let instant = dependency(params)
        print("[Dependency Injection] Resolved \(T.self) with \(instant.self)")
        return instant
#endif
        return dependency(params)
    }
}
