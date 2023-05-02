//
//  HomeEndpoint.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 5/1/23.
//

import Foundation

enum HomeEndpoint {
    case repos(token: String, page: Int)
}

extension HomeEndpoint: Endpoint {
    var baseURL: String {
        return "https://api.github.com/"
    }
    
    var path: String {
        switch self {
        case .repos(_, let page):
            return "user/repos?page=\(page)"
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .repos(let token, _):
            return ["Authorization" : "Bearer \(token)", "Accept": HTTPContentType.applicationJSON]
        }
    }
    
    var urlParams: [URLQueryItem]? {
        return nil
    }
}
