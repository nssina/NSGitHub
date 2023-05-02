//
//  NSGitHubApp.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 4/27/23.
//

import SwiftUI

@main
struct NSGitHubApp: App {
    
    private var token: String?
    
    init() {
        self.token = Keychain.shared.load(withKey: Keys.accessToken)
    }
                                                     
    var body: some Scene {
        WindowGroup {
            if token != nil {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}
