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
struct Keys {
    static let accessToken = "accessToken"
}

// MARK: - Callback scheme
struct CallbackScheme {
    static let url = "nsgithub"
}

// MARK: - SF Symbols
struct SFSymbols {
    static let checkmark = "checkmark"
    static let sort = "line.3.horizontal.decrease.circle"
    static let person = "person.crop.circle"
    static let star = "star"
    static let starFill = "star.fill"
    static let hammerFill = "hammer.fill"
}

// MARK: - Lottie
struct Lottie {
    static let catLight = "cat_head_light"
    static let catDark = "cat_head_dark"
}
