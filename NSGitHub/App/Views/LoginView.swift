//
//  LoginView.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 4/30/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var vm = LoginViewModel()
    
    var body: some View {
        ZStack {
            Image("GitHubLogo")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.primary)
                .frame(width: 90, height: 90)
                .padding(.bottom, 50)
            
            VStack {
                Spacer()
                
                Button {
                    vm.login()
                } label: {
                    Text("Sign in with GitHub")
                        .foregroundColor(.primary)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                
                Text("By signing in you accept our [Term of use](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service) and\n[Privacy policy](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service).")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
            }
            .padding(.bottom, 50)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
