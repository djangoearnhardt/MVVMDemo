//
//  CourseView.swift
//  MVC Starter
//
//  Created by Sam LoBue on 2/16/21.
//

import UIKit

class CourseView: UIView {
    // Layout is using DRY to eliminate repeating code and the use of magic strings for CGFloat values
    enum Layout {
        static let zero: CGFloat = 0
        static let borderWidth: CGFloat = 2
        static let edgeInsets: CGFloat = 4
        static let smallPadding: CGFloat = 5
        static let cornerRadius: CGFloat = 8
        static let padding: CGFloat = 10
        static let subtitleFontSize: CGFloat = 12
        static let titleFontSize: CGFloat = 20
        static let imageViewWidthAndHeight: CGFloat = 65
        static let bannerHeight: CGFloat = 75
    }
    
    let bannerView: UIView = {
        let bannerView = UIView()
        bannerView.layer.cornerRadius = Layout.cornerRadius
        return bannerView
    }()
    
    let courseImageView: UIImageView = {
        let courseImageView = UIImageView()
        courseImageView.layer.cornerRadius = Layout.cornerRadius
        courseImageView.layer.borderWidth = Layout.borderWidth
        courseImageView.layer.borderColor = UIColor.white.cgColor
        return courseImageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: Layout.titleFontSize)
        return titleLabel
    }()
    
    let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.systemFont(ofSize: Layout.titleFontSize, weight: .light)
        subtitleLabel.textColor = .systemGray
        return subtitleLabel
    }()
    
    let purchaseButton: UIButton = {
        let purchaseButton = UIButton()
        purchaseButton.setTitle(ButtonTitleStrings.purchase, for: .normal)
        purchaseButton.backgroundColor = .systemGray
        purchaseButton.layer.cornerRadius = Layout.cornerRadius
        purchaseButton.titleLabel?.font = UIFont.systemFont(ofSize: Layout.subtitleFontSize, weight: .heavy)
        purchaseButton.titleEdgeInsets = UIEdgeInsets(top: Layout.zero, left: Layout.edgeInsets, bottom: Layout.zero, right: Layout.edgeInsets)
        purchaseButton.titleLabel?.adjustsFontSizeToFitWidth = true
        return purchaseButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constructSubviews()
        constructSubviewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func constructSubviews() {
        addSubview(bannerView)
        addSubview(courseImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(purchaseButton)
    }
    
    func constructSubviewConstraints() {
        let views = [bannerView, courseImageView, titleLabel, subtitleLabel, purchaseButton]
        
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        // bannerView
        NSLayoutConstraint.activate( [
            bannerView.heightAnchor.constraint(equalToConstant: Layout.bannerHeight),
            bannerView.topAnchor.constraint(equalTo: self.topAnchor, constant: Layout.padding),
            bannerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.padding),
            bannerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.padding),
        ])
        
        // courseImageView
        NSLayoutConstraint.activate( [
            courseImageView.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor),
            courseImageView.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor),
            courseImageView.heightAnchor.constraint(equalToConstant: Layout.imageViewWidthAndHeight),
            courseImageView.widthAnchor.constraint(equalToConstant: Layout.imageViewWidthAndHeight)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: Layout.padding),
            titleLabel.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor)
        ])
        
        //subtitleLabel
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.smallPadding),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Layout.padding)
        ])
        
        // purchaseButton
        NSLayoutConstraint.activate([
            purchaseButton.centerYAnchor.constraint(equalTo: subtitleLabel.centerYAnchor),
            purchaseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.padding),
        ])
    }
}
