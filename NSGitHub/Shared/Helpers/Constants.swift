//
//  Constants.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 4/30/23.
//

import Foundation

// MARK: - Client
struct Client {
    static let uri    = "nsgithub://"
    static let id     = "b4237e637f72f57c44dd"
    static let secret = "df1d7a3dfdb6812a83c674108494d4e4d5c89156"
}

// MARK: - Keychain keys
struct KeychainKeys {
    static let accessToken = "accessToken"
}

// MARK: - Callback scheme
struct CallbackScheme {
    static let url = "nsgithub"
}
