//
//  UserEntity.swift
//  whatsexpense

public class UserEntity: Decodable {
    public let id: String

    public let familyName: String
    public let givenName: String
    public let fullName: String

    public let email: String
    public let picture: String

    public let currency: String
    public let language: String

    public let regions: [String]

    public let createdAt: String?
    public let updatedAt: String?
}
