//
//  LoginViewModel.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 4/30/23.
//

import Foundation
import AuthenticationServices

final class LoginViewModel: NSObject, ObservableObject {
    
    private var loginService = LoginService()
    
    func login() {
        
        // Step 1: Getting user Code
        let endpoint = LoginEndpoint.login(id: Client.id, uri: Client.uri)
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else { return }

        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: CallbackScheme.url) { [weak self] url, error in
            guard let self = self else { return }

            guard let url = url else {
                if let error = error {
                    print("login: ", error.localizedDescription)
                }
                return
            }

            let component = URLComponents(url: url, resolvingAgainstBaseURL: false)
            guard let code = component?.queryItems?.first(where: { $0.name == "code" })?.value else {
                print("Invalid URL")
                return
            }

            // Step 2: Getting access token
            Task {
                do {
                    let result = try await self.loginService.getAccessToken(id: Client.id, secret: Client.secret, code: code, uri: Client.uri, httpMethod: .post)
                    
                    // Step 3: Save access token in keychain
                    Keychain.shared.save(result.accessToken, forKey: KeychainKeys.accessToken)
                } catch {
                    #if DEBUG
                    print(error.localizedDescription)
                    #endif
                }
            }
        }

        session.presentationContextProvider = self
        
        // Using private session
        session.prefersEphemeralWebBrowserSession = true

        session.start()
    }
}

// MARK: - Conform to ASWebAuthenticationPresentationContextProviding
extension LoginViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
