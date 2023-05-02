//
//  HomeItemView.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 5/2/23.
//

import SwiftUI

struct HomeItemView: View {
    var avatar: String
    var owner: String
    var name: String
    var description: String
    var language: String
    var stars: Int
    
    var body: some View {
        VStack {
            
            HStack {
                // Owner avatar
                if let avatarURL = URL(string: avatar) {
                    AsyncImage(url: avatarURL) { image in
                        image
                            .resizable()
                    } placeholder: {
                        Image(systemName: "person.crop.circle")
                    }
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                }

                // Owner name
                Text(owner)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    // Repo name
                    Text(name)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    // Repo description
                    Text(description)
                        .font(.footnote)
                        .lineLimit(3)
                        .minimumScaleFactor(0.75)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
            }
            
            HStack(spacing: 15) {
                // Stars
                HStack(spacing: 1) {
                    Image(systemName: stars > 0 ? "star.fill" : "star")
                        .foregroundColor(stars > 0 ? .yellow : .primary)
                    Text(String(stars))
                }
                
                // Language
                if !language.isEmpty {
                    HStack(spacing: 2) {
                        Image(systemName: "hammer.fill")
                        Text(language)
                    }
                }
                
                Spacer()
            }
            .font(.footnote)
            .padding(.top, 1)
        }
        .padding(.horizontal)
    }
}

// MARK: - Preview
struct HomeItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeItemView(avatar: "person.crop.circle",
                     owner: "nssina",
                     name: "NSAsyncCachedImage",
                     description: "Lightweight way to load and cache images asynchronously in SwiftUI views",
                     language: "Swift",
                     stars: 10)
    }
}
