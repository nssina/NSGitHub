//
//  DetailsView.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 5/2/23.
//

import SwiftUI
import LottieUI

struct DetailsView: View {
    
    var item: Repo?
    
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject private var vm = DetailsViewModel()
    
    var body: some View {
        List {
            Section(header: Text("`Details`")) {
                header
            }
            
            /// Repo Description
            if let description = item?.description {
                Section(header: Text("`Description`")) {
                    Text(description)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
            }
            
            /// Repo README
            Section(header: Text("`README.md`")) {
                readme
            }
        }
        .navigationTitle(item?.name ?? "Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await vm.getStringFromURL(endpoint: .readme(user: item?.owner?.login ?? "",
                                                        name: item?.name ?? "",
                                                        branch: item?.defaultBranch ?? ""))
        }
    }
}

// MARK: - Header
extension DetailsView {
    private var header: some View {
        VStack {
            HStack {
                /// Owner avatar
                if let avatarURL = URL(string: item?.owner?.avatarURL ?? "") {
                    AsyncImage(url: avatarURL) { image in
                        image
                            .resizable()
                    } placeholder: {
                        Image(systemName: SFSymbols.person)
                    }
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                }
                
                /// Owner name
                Text(item?.owner?.login ?? "")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            
            HStack {
                /// Repo name
                Text(item?.name ?? "")
                    .font(.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                Spacer()
            }
            
            HStack(spacing: 15) {
                
                /// Private
                if item?.repoPrivate ?? false {
                    HStack(spacing: 2) {
                        Image(systemName: SFSymbols.lock)
                        Text("Private")
                    }
                    .font(.footnote)
                    .fontWeight(.semibold)
                }
                
                /// Stars
                HStack(spacing: 5) {
                    Image(systemName: SFSymbols.star)
                    
                    HStack(spacing: 2) {
                        Text(String(item?.stargazersCount ?? 0))
                            .fontWeight(.semibold)
                        
                        Text(item?.stargazersCount ?? 0 == 1 ? "star" : "stars")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                }
                .fontWeight(.semibold)
                
                /// Forks
                HStack(spacing: 4) {
                    Image(systemName: SFSymbols.fork)
                    
                    HStack(spacing: 2) {
                        Text(String(item?.forksCount ?? 0))
                        
                        Text(item?.forksCount ?? 0 == 1 ? "fork" : "forks")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                }
                .fontWeight(.semibold)
                
                Spacer()
            }
            .font(.footnote)
            .padding(.top, 1)
        }
    }
}

// MARK: - Readme
extension DetailsView {
    private var readme: some View {
        Group {
            if vm.isLoading {
                HStack {
                    Spacer()
                    LottieView(colorScheme == .light ? Lottie.catLight : Lottie.catDark)
                        .loopMode(.loop)
                        .frame(width: 130, height: 130)
                    Spacer()
                }
            } else {
                if vm.readme.isEmpty {
                    HStack {
                        Spacer()
                        LottieView(Lottie.error404)
                            .loopMode(.loop)
                            .frame(width: 300, height: 200)
                        Spacer()
                    }
                } else {
                    MarkdownView(vm.readme)
                }
            }
        }
    }
}

// MARK: - Preview
struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
