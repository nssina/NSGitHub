//
//  DetailsEndpoint.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 5/2/23.
//

import Foundation

enum DetailsEndpoint {
    case readme(user: String, name: String, branch: String)
}

extension DetailsEndpoint: Endpoint {
    var baseURL: String {
        return "https://raw.githubusercontent.com/"
    }
    
    var path: String {
        switch self {
        case .readme(let user, let name, let branch):
            return "\(user)/\(name)/\(branch)/README.md"
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var urlParams: [URLQueryItem]? {
        return nil
    }
}
