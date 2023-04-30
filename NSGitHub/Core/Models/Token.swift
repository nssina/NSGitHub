//
//  Token.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 4/30/23.
//

import Foundation

struct Token: Codable {
    let accessToken: String
    let scope: String?
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case scope
        case tokenType = "token_type"
    }
}
