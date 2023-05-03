//
//  UserEndpoint.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 4/30/23.
//

import Foundation

enum LoginEndpoint {
    case login(id: String, uri: String)
    case token(id: String, secret: String, code: String, uri: String)
}

extension LoginEndpoint: Endpoint {
    var baseURL: String {
        return "https://github.com/login/oauth/"
    }
    
    var path: String {
        switch self {
        case .login(let id, let uri):
            return "authorize?client_id=\(id)&redirect_uri=\(uri)"
        case .token(let id, let secret, let code, let uri):
            return "access_token?client_id=\(id)&client_secret=\(secret)&code=\(code)&redirect_uri=\(uri)"
        }
    }
    
    var header: [String: String]? {
        return ["Accept": HTTPContentType.applicationJSON]
    }
}
