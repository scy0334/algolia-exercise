//
//  SearchedUserTableViewCell.swift
//  Algolia-Exercise
//
//  Created by Si Choi on 2022/01/18.
//

import UIKit
import SDWebImage
import AlgoliaSearchClient

class SearchedUserTableViewCell: UITableViewCell {
    // MARK: - Properties
    let itemImageView: UIImageView
    let titleLabel: UILabel
    let subtitleLabel: UILabel
    
    // MARK: - Life Cycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        itemImageView = .init(frame: .zero)
        titleLabel = .init(frame: .zero)
        subtitleLabel = .init(frame: .zero)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func layout() {
        itemImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.layer.masksToBounds = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        titleLabel.numberOfLines = 2
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = .systemFont(ofSize: 10, weight: .regular)
        subtitleLabel.textColor = .gray
        subtitleLabel.numberOfLines = 0
        
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.spacing = 3
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(subtitleLabel)
        labelsStackView.addArrangedSubview(UIView())
        
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.spacing = 20
        mainStackView.addArrangedSubview(itemImageView)
        mainStackView.addArrangedSubview(labelsStackView)
        
        contentView.addSubview(mainStackView)
        contentView.layoutMargins = .init(top: 5, left: 3, bottom: 5, right: 3)
        
        NSLayoutConstraint.activate([
            itemImageView.widthAnchor.constraint(equalTo: itemImageView.heightAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
}



extension SearchedUserTableViewCell {
    func setup(with userHit: Hit<User>) {
        let user = userHit.object
        itemImageView.sd_setImage(with: URL(string:user.photoUrl), placeholderImage: UIImage(named: "ironman"))
        
        if let highlightedName = userHit.hightlightedString(forKey: "username") {
                titleLabel.attributedText = NSAttributedString(highlightedString: highlightedName,
                                                               attributes: [
                                                                .foregroundColor: UIColor.yellow])
        } else {
          titleLabel.text = user.username
        }
        
        if let highlightedDescription = userHit.hightlightedString(forKey: "selfIntroduction") {
          subtitleLabel.attributedText = NSAttributedString(highlightedString: highlightedDescription,
                                                            attributes: [
                                                              .foregroundColor: UIColor.yellow
                                                            ])
        } else {
          subtitleLabel.text = user.selfIntroduction
        }
    }
}
