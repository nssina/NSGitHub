//
//  HomeService.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 5/1/23.
//

import Foundation

protocol HomeServiceDelegate {
    func getReposList(token: String) async throws -> [Repo]
}

struct HomeService: HTTPClient, HomeServiceDelegate {
    func getReposList(token: String) async throws -> [Repo]  {
        let response = try await sendRequest(endpoint: HomeEndpoint.repos(token: token), httpMethod: .get, responseModel: [Repo].self)
        
        return response
    }
}
