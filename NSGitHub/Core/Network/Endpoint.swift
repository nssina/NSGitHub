//
//  Endpoint.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 4/30/23.
//

import Foundation

public protocol Endpoint {
    var baseURL:   String            { get }
    var path:      String            { get }
    var header:    [String: String]? { get }
    var urlParams: [URLQueryItem]?   { get }
}
