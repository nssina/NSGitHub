//
//  LoginService.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 4/30/23.
//

import Foundation

protocol LoginServiceDelegate {
    func getAccessToken(id: String, secret: String, code: String, uri: String, httpMethod: HTTPMethod) async throws -> Token
}

struct LoginService: HTTPClient, LoginServiceDelegate {
    func getAccessToken(id: String, secret: String, code: String, uri: String, httpMethod: HTTPMethod) async throws -> Token {
        let response = try await sendRequest(endpoint: LoginEndpoint.token(id: id, secret: secret, code: code, uri: uri), httpMethod: httpMethod, responseModel: Token.self)
        
        return .init(accessToken: response.accessToken, scope: response.scope, tokenType: response.tokenType)
    }
}

