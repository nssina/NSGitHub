//
//  HomeViewModel.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 5/1/23.
//

import Foundation

enum SortType {
    case ascending, descending
}

final class HomeViewModel: ObservableObject {
    
    private var service = HomeService()
    
    @Published private(set) var repos: [Repo] {
        didSet {
            stopLoading()
        }
    }
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var sortType: SortType = .ascending
    
    private var page: Int = 1
    private var timer: Timer?
    private var token: String?
    private var dismissLoadingAfterSeconds: CGFloat = 1.0
    
    init() {
        self.repos = []
        self.token = Keychain.shared.load(withKey: Keys.accessToken)
    }
    
    func getReposList() async {
        guard let token = token else { return }
        
        if page < 2 {
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = true
            }
        }
        
        do {
            let result = try await service.getReposList(token: token, page: page)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                switch sortType {
                case .ascending:
                    self.repos.append(contentsOf: result)
                case .descending:
                    self.repos.append(contentsOf: result.reversed())
                }
                
                if result.count == 30 { page += 1 }
            }
        } catch  {
            #if DEBUG
            print(error)
            #endif
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
            }
        }
    }
    
    func sort(_ sort: SortType) {
        guard sort != sortType else { return }
        sortType = sort
        
        switch sort {
        case .ascending:
            repos = repos.reversed()
        case .descending:
            repos = repos.reversed()
        }
    }
    
    func loadMoreItems(item: Repo) {
        let number = repos.count - 5
        guard item.id ?? 0 == repos[number].id else { return }
        
        Task { await getReposList() }
    }
    
    private func stopLoading() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: dismissLoadingAfterSeconds, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.isLoading = false
        }
    }
}
