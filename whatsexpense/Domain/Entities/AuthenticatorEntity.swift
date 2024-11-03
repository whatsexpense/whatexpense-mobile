//
//  AuthenticatorEntity.swift
//  whatsexpense

public struct Token {
    public let accessToken: String
    public let refreshToken: String
}

final public class AuthenticatorEntity: Decodable {
    public let user: UserEntity
    public let accessToken: String
    public let refreshToken: String
}
