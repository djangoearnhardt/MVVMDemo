//
//  CourseView.swift
//  MVC Starter
//
//  Created by Sam LoBue on 2/16/21.
//

import UIKit

class CourseView: UIView {
    
    let bannerView: UIView = {
        let bannerView = UIView()
        bannerView.layer.cornerRadius = 8
        return bannerView
    }()
    
    let courseImageView: UIImageView = {
        let courseImageView = UIImageView()
        courseImageView.layer.cornerRadius = 8
        courseImageView.layer.borderWidth = 2
        courseImageView.layer.borderColor = UIColor.white.cgColor
        return courseImageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return titleLabel
    }()
    
    let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        subtitleLabel.textColor = .systemGray
        return subtitleLabel
    }()
    
    let purchaseButton: UIButton = {
        let purchaseButton = UIButton()
        purchaseButton.setTitle("Purchase", for: .normal)
        purchaseButton.backgroundColor = .systemGray
        purchaseButton.layer.cornerRadius = 8
        purchaseButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        purchaseButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        purchaseButton.titleLabel?.adjustsFontSizeToFitWidth = true
        return purchaseButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constructSubviews()
        constructSubviewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        NSLayoutConstraint.activate( [
            bannerView.heightAnchor.constraint(equalToConstant: 75),
            bannerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            bannerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            bannerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate( [
            courseImageView.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor),
            courseImageView.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor),
            courseImageView.heightAnchor.constraint(equalToConstant: 65),
            courseImageView.widthAnchor.constraint(equalToConstant: 65)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            purchaseButton.centerYAnchor.constraint(equalTo: subtitleLabel.centerYAnchor),
            purchaseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
}
