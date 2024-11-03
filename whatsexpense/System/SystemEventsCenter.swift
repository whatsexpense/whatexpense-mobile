//
//  SystemEventsHandler.swift
//  whatsexpense

import UIKit
import Combine

protocol SystemEventsCenter {
    func sceneOpenURLContexts(_ urlContexts: Set<UIOpenURLContext>)
    func sceneDidBecomeActive()
    func sceneWillResignActive()
    func handlePushRegistration(result: Result<Data, Error>)
    func appDidReceiveRemoteNotification(payload: NotificationPayload,
                                         fetchCompletion: @escaping FetchCompletion)
}

@MainActor
struct SystemEventsService: SystemEventsCenter {

    let container: DIContainer
    let deepLinksSystemService: DeepLinkSystem
    let apnsSystemService: APNSSystem
    let authenticationService: AuthenticationSystem
    private let disposeBag = DisposeBag()

    init(
        container: DIContainer,
        deepLinksSystem: DeepLinkSystem,
        apnsSystem: APNSSystem,
        authenticationService: AuthenticationSystem
    ) {

        self.container = container
        self.deepLinksSystemService = deepLinksSystem
        self.apnsSystemService = apnsSystem
        self.authenticationService = authenticationService

        installKeyboardHeightObserver()
        installPushNotificationsSubscriberOnLaunch()
    }

    private func installKeyboardHeightObserver() {
//        let appState = container.appState
//        NotificationCenter.default.keyboardHeightPublisher
//            .sink { [appState] height in
//                appState[\.system.keyboardHeight] = height
//            }
//            .store(in: disposeBag)
    }

    private func installPushNotificationsSubscriberOnLaunch() {
//        weak var permissions = container.interactors.userPermissionsInteractor
//        container.appState
//            .updates(for: AppState.permissionKeyPath(for: .pushNotifications))
//            .first(where: { $0 != .unknown })
//            .sink { status in
//                if status == .granted {
//                    // If the permission was granted on previous launch
//                    // requesting the push token again:
//                    permissions?.request(permission: .pushNotifications)
//                }
//            }
//            .store(in: disposeBag)
    }

    func sceneOpenURLContexts(_ urlContexts: Set<UIOpenURLContext>) {
//        guard let url = urlContexts.first?.url else { return }
//        handle(url: url)
    }

    private func handle(url: URL) {
//        guard let deepLink = DeepLink(url: url) else { return }
//        deepLinksSystemService.open(deepLink: deepLink)
    }

    func sceneDidBecomeActive() {
//        container.appState[\.system.isActive] = true
//        container.interactors.userPermissionsInteractor.resolveStatus(for: .pushNotifications)
    }

    func sceneWillResignActive() {
//        container.appState[\.system.isActive] = false
    }

    func handlePushRegistration(result: Result<Data, Error>) {
//        if let apnsToken = try? result.get() {
//            apnsSystemService
//                .register(devicePushToken: apnsToken)
//                // .sinkToResult { _ in }
//                // .store(in: disposeBag)
//        }
    }

    func appDidReceiveRemoteNotification(payload: NotificationPayload,
                                         fetchCompletion: @escaping FetchCompletion) {
//        container.interactors.countriesInteractor
//            .refreshCountriesList()
//            .sinkToResult { result in
//                fetchCompletion(result.isSuccess ? .newData : .failed)
//            }
//            .store(in: disposeBag)
    }
}
