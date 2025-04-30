//
//  SearchUserListViewController.swift
//  GithubAPI
//
//  Created by Yu Li Lin on 2025/4/30.
//

import Combine
import UIKit

// MARK: - SearchUserListViewController

class SearchUserListViewController: UIViewController {
    // MARK: - Private Properties

    private let viewModel = SearchUserListViewModel()
    private let contentView = SearchUserListView()
    private var tableViewDiffableDataSource: UITableViewDiffableDataSource<Int, SearchUserListItem>?
    private lazy var searchBarController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "123"
        sc.searchResultsUpdater = self
        return sc
    }()

    private var subscribers = [AnyCancellable]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        bind()
    }
}

// MARK: - Bind

private extension SearchUserListViewController {
    func bind() {
        tableViewDiffableDataSource = UITableViewDiffableDataSource(tableView: contentView.tableView, cellProvider: { tableView, indexPath, itemIdentifier in

            let cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchUserListCell.self)", for: indexPath)
            if let cell = cell as? SearchUserListCell {
                cell.setData(item: itemIdentifier)
            }

            return cell
        })

        viewModel.didReceiveSearchResult
            .receive(on: DispatchQueue.main)
            .sink { [weak self] searchResult in
                guard let self = self else { return }
                self.updateSnapShot(items: searchResult)
            }.store(in: &subscribers)
    }
}

// MARK: - Private Methods

private extension SearchUserListViewController {
    func setupViews() {
        setNavbarStyle()
        setupSearchbar()
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        contentView.tableView.delegate = self
    }

    func setNavbarStyle() {
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = .red
        appearence.titleTextAttributes = [
            .foregroundColor: UIColor.green,
            .font: UIFont.systemFont(ofSize: 15.0),
        ]

        guard let navBar = navigationController?.navigationBar else {
            return
        }

        navBar.standardAppearance = appearence
        navBar.scrollEdgeAppearance = appearence
        navBar.compactAppearance = appearence
    }

    func setupSearchbar() {
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchBarController.searchBar.delegate = self
        let textField = searchBarController.searchBar.searchTextField
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 5.0
        textField.clipsToBounds = true
    }

    func updateSnapShot(items: [SearchUserListItem]) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, SearchUserListItem>()
        snapShot.appendSections([0])
        items.forEach { snapShot.appendItems([$0], toSection: 0) }
        tableViewDiffableDataSource?.apply(snapShot, animatingDifferences: false)
    }
}

// MARK: UISearchResultsUpdating

// MARK: - UISearchResultsUpdating

extension SearchUserListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //print("\(searchController.searchBar.text)")
    }
}

// MARK: UISearchBarDelegate

// MARK: - UISearchBarDelegate

extension SearchUserListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !query.isEmpty else {
            return
        }
        viewModel.clearLastSearch()
        viewModel.setSearchText.send(query)
        print("\(query)")
        searchBar.resignFirstResponder()
    }
}

// MARK: UITableViewDelegate

// MARK: - UITableViewDelegate

extension SearchUserListViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: UIScrollViewDelegate

extension SearchUserListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let tableViewHeight = scrollView.frame.size.height

        // 當滑動到距底部 100pt 以內時觸發
        if offsetY > contentHeight - tableViewHeight - 100 {
            let lastSearchtext = viewModel.setSearchText.value
            viewModel.setSearchText.send(lastSearchtext)
        }
    }
}
