//
//  HomeView.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 5/1/23.
//

import SwiftUI
import LottieUI

struct HomeView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @ObservedObject private var vm = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if vm.isLoading {
                    VStack(spacing: 10) {
                        LottieView(colorScheme == .light ? Lottie.catLight : Lottie.catDark)
                            .loopMode(.loop)
                            .frame(width: 130, height: 130)
                    }
                    .padding(.bottom, 90)
                } else {
                    List {
                        ForEach(vm.repos, id: \.id) { item in
                            NavigationLink(destination: DetailsView(item: item)) {
                                HomeItemView(avatar: item.owner?.avatarURL ?? "",
                                             owner: item.owner?.login ?? "",
                                             name: item.name ?? "",
                                             description: item.description ?? "",
                                             language: item.language ?? "",
                                             stars: item.stargazersCount ?? 0)
                            }
                            .onAppear {
                                vm.loadMoreItems(item: item)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Section("Sort by:") {
                            Button {
                                vm.sort(.ascending)
                            } label: {
                                HStack {
                                    Text("Ascending")
                                    if vm.sortType == .ascending {
                                        Image(systemName: SFSymbols.checkmark)
                                    }
                                }
                            }
                            
                            Button {
                                vm.sort(.descending)
                            } label: {
                                Text("Descending")
                                if vm.sortType == .descending {
                                    Image(systemName: SFSymbols.checkmark)
                                }
                            }
                        }
                    } label: {
                        Image(systemName: SFSymbols.sort)
                    }
                }
            }
            .navigationTitle("Home")
        }
        .task {
            await vm.getReposList()
        }
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
