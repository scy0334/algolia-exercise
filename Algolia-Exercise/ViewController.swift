//
//  ViewController.swift
//  Algolia-Exercise
//
//  Created by Si Choi on 2022/01/18.
//

import UIKit
import InstantSearch

struct User: Codable {
    let username: String
    let lastmodified: Date
    let categories: [String]
    var selfIntroduction: String = "TIPP iOS 개발자"
    var photoUrl: String = ""
}

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let searcher: HitsSearcher
    let searchResultsViewController: SearchResultsViewController
    let searchController: UISearchController
    
    let queryInputConnector: QueryInputConnector
    let textFieldController: TextFieldController
    let hitsInteractor: HitsInteractor<Hit<User>>
    
    
    // MARK: - Life Cycles
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let appId = Bundle.main.infoDictionary?["ALGOLIA_APP_ID"] as? String ?? ""
        
        let apiKey = Bundle.main.infoDictionary?["ALGOLIA_API_KEY"] as? String ?? ""
        
        searcher = .init(appID: ApplicationID(rawValue: appId), apiKey: APIKey(rawValue: apiKey), indexName: "users")
        searchResultsViewController = .init(style: .plain)
        hitsInteractor = .init(infiniteScrolling: .on(withOffset: 20))
        searchController = .init(searchResultsController: searchResultsViewController)
        textFieldController = .init(searchBar: searchController.searchBar)
        queryInputConnector = .init(searcher: searcher,
                                    searchTriggeringMode: .searchOnSubmit,
                                    controller: textFieldController)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSearchBar()
        hitsInteractor.connectSearcher(searcher)
        searchResultsViewController.hitsInteractor = hitsInteractor
        
        searcher.search()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.showsSearchResultsController = true
        searchController.automaticallyShowsCancelButton = false
        searchController.searchBar.sizeToFit();
//        navigationItem.searchController = searchController
        self.navigationItem.titleView = searchController.searchBar
        self.navigationController?.navigationBar.tintColor = .black

    }
    
    private func configureSearchBar() {
        searchController.searchBar.placeholder = "어떤 도움이 필요하신가요?"
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.setDimensions(width: 330, height: 40)
            textfield.centerY(inView: searchController.searchBar, leftAnchor: searchController.searchBar.leftAnchor, paddingLeft: 40)
    
            
            //서치바 백그라운드 컬러
//            textfield.backgroundColor = .white
            
            //플레이스홀더 글씨 색 정하기
//            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            //서치바 텍스트입력시 색 정하기
//            textfield.textColor = UIColor.white
            //왼쪽 아이콘 이미지넣기
//            if let leftView = textfield.leftView as? UIImageView {
//                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
//                //이미지 틴트컬러 정하기
//                leftView.tintColor = UIColor.white
//            }
//            //오른쪽 x버튼 이미지넣기
//            if let rightView = textfield.rightView as? UIImageView {
//                rightView.image = rightView.image?.withRenderingMode(.alwaysTemplate)
//                //이미지 틴트 정하기
//                rightView.tintColor = UIColor.white
//            }
            
        }
    }
}

