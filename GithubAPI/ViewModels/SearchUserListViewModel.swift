//
//  SearchUserListViewModel.swift
//  GithubAPI
//
//  Created by Yu Li Lin on 2025/4/30.
//

import Foundation
import Combine

class SearchUserListViewModel {
    
    //MARK: - Input
    var setSearchText: CurrentValueSubject<String, Never> = .init("")
    var didReceiveSearchResult: PassthroughSubject<[SearchUserListItem], Never> = .init()
    
    //MARK: - Private Properties
    private(set) var searchUserResultList = [SearchUserListItem]()
    private var subscribers = [AnyCancellable]()
    private(set) var currentPage: Int = 1
    
    init() {
        bind()
    }
    
    func clearLastSearch() {
        setSearchText.send("")
        searchUserResultList = []
        currentPage = 1
    }
}

//MARK: - Bind
private extension SearchUserListViewModel {
    func bind() {
        setSearchText.sink { [weak self] text in
            guard let self = self else { return }
            if !text.isEmpty {
                self.fetchUsers(query: text)
            }
        }.store(in: &subscribers)
    }
}

//MARK: - Private Methods
private extension SearchUserListViewModel {
    func fetchUsers(query: String) {
        APIClient.shared
            .request(.searchUsers(query: query, page: currentPage), type: SearchUserList.self)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("API Error:\(error)")
                    
                }
            } receiveValue: { [weak self] users in
                guard let self = self else { return }
                if let items = users.items {
                    self.currentPage += 1
                    self.searchUserResultList.append(contentsOf: items)
                    self.didReceiveSearchResult.send(self.searchUserResultList)
                }
            }
            .store(in: &subscribers)
    }
}
