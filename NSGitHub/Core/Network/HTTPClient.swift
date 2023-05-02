//
//  HTTPClient.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 4/30/23.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, httpMethod: HTTPMethod, responseModel: T.Type) async throws -> T
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, httpMethod: HTTPMethod, responseModel: T.Type) async throws -> T {
        let config: URLSessionConfiguration = .default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        var urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path)
        
        if let urlParams = endpoint.urlParams {
            urlComponents?.queryItems = urlParams
        }
        
        guard let url = urlComponents?.url else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endpoint.header
        request.httpMethod = httpMethod.rawValue
        
        do {
            let (data, response) = try await URLSession(configuration: config).data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                    return decodedResponse
                } catch {
                    #if DEBUG
                    print("💥 Execute error:")
                    print(error)
                    #endif
                    throw RequestError.decode
                }
            case 400, 401:
                throw RequestError.unauthorized(data)
            case 404:
                throw RequestError.notFound
            default:
                throw RequestError.unexpectedStatusCode(response.statusCode)
            }
        } catch {
            print(error)
            throw RequestError.unknown("Network error")
        }
    }
}