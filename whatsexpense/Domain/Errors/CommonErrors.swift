//
//  CommonErrors.swift
//  whatsexpense

public enum CommonErrorCode: Error {
    case clientError(code: Int, message: String?, data: [String: Any]?)
    case networkError(code: Int)
    case dynamicError(code: Int)

    init(
        clientErrorCode: Int,
        message: String? = nil,
        data: [String: Any]? = nil
    ) {
        self = .clientError(code: clientErrorCode, message: message, data: data)
    }

    init(networkError: NetworkError) {
        self = .networkError(code: networkError.rawValue)
    }

    init(dynamicError: Int) {
        self = .dynamicError(code: dynamicError)
    }
}

