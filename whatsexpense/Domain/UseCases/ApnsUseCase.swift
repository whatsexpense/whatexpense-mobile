//
//  ApnsUseCase.swift
//  whatsexpense

import Foundation
import Combine
import UserNotifications

public protocol APNSRepositoryInterface {
    func register(devicePushToken: Data) -> AnyPublisher<Void, Error>
}

public protocol APNSSystem: APNSRepositoryInterface {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        completion: @escaping (UNNotificationPresentationOptions) -> Void
    )

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        completion: @escaping () -> Void
    )
}

public struct APNSUseCase: APNSSystem {
    private let repository: APNSRepositoryInterface

    public func register(devicePushToken: Data) -> AnyPublisher<Void, Error> {
        repository.register(devicePushToken: devicePushToken)
    }

    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        completion: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completion([.list, .banner, .sound])
    }

    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        completion: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        handleNotification(userInfo: userInfo, completion: completion)
    }

    public func handleNotification(
        userInfo: [AnyHashable: Any],
        completion: @escaping () -> Void
    ) {
        guard let payload = userInfo["aps"] as? NotificationPayload 
        else { return completion() }
        // handle payload
        APNSResolution.resolveAPNS(payload)
        completion()
    }
}

private struct APNSResolution {
    static func resolveAPNS(_ payload: NotificationPayload) {
        // TODO: resolve and handle APNS
    }
}
