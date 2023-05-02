//
//  LoginView.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 4/30/23.
//

import SwiftUI
import LottieUI

struct LoginView: View {
    
    @ObservedObject private var vm = LoginViewModel()
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack {
            if colorScheme == .light {
                LottieView(Lottie.githubLight)
                    .loopMode(.loop)
                    .frame(width: 130, height: 130)
            } else {
                LottieView(Lottie.githubDark)
                    .loopMode(.loop)
                    .frame(width: 130, height: 130)
            }
            
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
