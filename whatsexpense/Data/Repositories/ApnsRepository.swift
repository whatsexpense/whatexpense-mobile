//
//  ApnsRepository.swift
//  whatsexpense

import Foundation
import Combine

public struct APNSRepository: APNSRepositoryInterface {

    public func register(devicePushToken: Data) -> AnyPublisher<Void, Error> {
        // upload the push token to your server
        return Just<Void>.withErrorType(Error.self)
    }
}

