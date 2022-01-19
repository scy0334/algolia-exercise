//
//  SearchResultsController.swift
//  Algolia-Exercise
//
//  Created by Si Choi on 2022/01/18.
//

import UIKit
import InstantSearch

private let userCell = "userCell"
class SearchResultsViewController: UITableViewController {
    
    // MARK: - Properties
    weak var hitsInteractor: HitsInteractor<Hit<User>>? {
        didSet {
            oldValue?.onResultsUpdated.cancelSubscription(for: tableView)
            guard let interactor = hitsInteractor else { return }
            interactor.onResultsUpdated.subscribe(with: tableView) { tableView, _ in
                tableView.reloadData()
            }.onQueue(.main)
        }
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SearchedUserTableViewCell.self, forCellReuseIdentifier: userCell)
    }
    
    
    
    // MARK: - Helpers
    
}

extension SearchResultsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hitsInteractor?.numberOfHits() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: userCell, for: indexPath) as? SearchedUserTableViewCell
            , let hit = hitsInteractor?.hit(atIndex: indexPath.row) {
            cell.setup(with: hit)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "팁퍼"
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: it was tapped")
    }
    
}
