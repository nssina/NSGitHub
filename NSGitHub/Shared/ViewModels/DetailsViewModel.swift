//
//  DetailsViewModel.swift
//  NSGitHub
//
//  Created by Sina Rabiei on 5/2/23.
//

import Foundation

final class DetailsViewModel: ObservableObject {
    
    @Published private(set) var readme: String
    @Published private(set) var isLoading: Bool
    
    private var timer: Timer?
    private var dismissLoadingAfterSeconds: CGFloat = 1.0
    
    init() {
        isLoading = true
        readme = ""
    }
    
    /// This function will get the readme file content from Internet and make it ready for UI to render it
    func getStringFromURL(endpoint: DetailsEndpoint) async {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else { return }
        
        do {
            let contents = try String(contentsOf: url)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.readme = contents
                self.stopLoading()
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.readme = ""
                self.stopLoading()
            }
            
            #if DEBUG
            print(error)
            #endif
        }
    }
    
    /// This function will dismiss the loading after one second
    private func stopLoading() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: dismissLoadingAfterSeconds, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.isLoading = false
        }
    }
}
