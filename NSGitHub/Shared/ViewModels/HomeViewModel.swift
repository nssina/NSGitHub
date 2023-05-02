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
    
    private var timer: Timer?
    private var token: String?
    private var dismissLoadingAfterSeconds: CGFloat = 2.0
    
    init() {
        self.repos = []
        self.token = Keychain.shared.load(withKey: Keys.accessToken)
    }
    
    func getReposList() async {
        guard let token = token else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = true
        }
        
        do {
            let result = try await service.getReposList(token: token)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.repos = result
            }
        } catch  {
            #if DEBUG
            print(error)
            #endif
            isLoading = false
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
    
    private func stopLoading() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: dismissLoadingAfterSeconds, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.isLoading = false
        }
    }
}
