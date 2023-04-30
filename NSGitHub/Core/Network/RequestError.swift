//
//  RequestError.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 4/30/23.
//

import Foundation

public enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case notFound
    case unauthorized(Data)
    case unexpectedStatusCode(Int)
    case unknown(String)
}
