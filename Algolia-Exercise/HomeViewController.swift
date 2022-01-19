//
//  HomeViewController.swift
//  Algolia-Exercise
//
//  Created by Si Choi on 2022/01/19.
//

import UIKit

class HomeViewController: UIViewController {
    let button = UIButton()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Actions
    
    @objc func handleButtonTapped(_ sender: UIButton) {
        let vc = ViewController(nibName: nil, bundle: nil)
        show(vc, sender: self)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.backButtonTitle = ""
        navigationItem.titleView?.tintColor = .black
        let layoutGuide = view.safeAreaLayoutGuide
        button.setTitle("어떤 도움이 필요하신가요?", for: .normal)
        button.setImage(UIImage(named: "ic_back"), for: .normal)
        button.imageView?.tintColor = .black
        button.backgroundColor = .gray
        button.imageView?.contentMode = .scaleAspectFit
        button.semanticContentAttribute = .forceLeftToRight
        button.contentHorizontalAlignment = .left
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        
        [button].forEach({ view.addSubview($0) })
        button.anchor(top: layoutGuide.topAnchor, left: layoutGuide.leftAnchor, right: layoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        button.setDimensions(width: 300, height: 50)
        
        button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
    }
}
