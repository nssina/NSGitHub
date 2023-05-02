//
//  HomeEndpoint.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 5/1/23.
//

import Foundation

enum HomeEndpoint {
    case repos(token: String)
}

extension HomeEndpoint: Endpoint {
    var baseURL: String {
        return "https://api.github.com/"
    }
    
    var path: String {
        switch self {
        case .repos(_):
            return "user/repos"
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .repos(let token):
            return ["Authorization" : "Bearer \(token)", "Accept": HTTPContentType.applicationJSON]
        }
    }
    
    var urlParams: [URLQueryItem]? {
        return nil
    }
}
