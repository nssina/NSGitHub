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
        NavigationStack {
            ZStack {
                if vm.isLoading {
                    VStack(spacing: 10) {
                        LottieView(colorScheme == .light ? "cat_head_light" : "cat_head_dark")
                            .loopMode(.loop)
                            .frame(width: 130, height: 130)
                    }
                    .padding(.bottom, 90)
                } else {
                    List {
                        ForEach(vm.repos, id: \.id) { item in
                            HomeItemView(avatar: item.owner?.avatarURL ?? "",
                                         owner: item.owner?.login ?? "",
                                         name: item.name ?? "",
                                         description: item.description ?? "",
                                         language: item.language ?? "",
                                         stars: item.stargazersCount ?? 0)
                            .onAppear {
                                vm.loadMoreItems(item: item)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Home")
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
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                            
                            Button {
                                vm.sort(.descending)
                            } label: {
                                Text("Descending")
                                if vm.sortType == .descending {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
        .task {
            await vm.getReposList()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
