//
//  ApnsSystemService.swift
//  whatsexpense

import Foundation
import UserNotifications
import Combine

public struct APNSSystemService: APNSSystem {
    private let useCase: APNSUseCase

    public func register(devicePushToken: Data) -> AnyPublisher<Void, Error> {
        useCase.register(devicePushToken: devicePushToken)
    }

    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        completion: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        useCase.userNotificationCenter(
            center,
            willPresent: notification,
            completion: completion)
    }
    
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        completion: @escaping () -> Void
    ) {
        useCase.userNotificationCenter(
            center,
            didReceive: response,
            completion: completion)
    }

}
