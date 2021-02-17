//
//  CourseCell.swift
//  MVC Starter
//
//  Created by David on 2/10/21.
//

import UIKit

class CourseCell: UITableViewCell {
    
    var courseView: CourseView = CourseView()
    var courseViewModel: CourseViewModel? {
        didSet {
            styleCell()
        }
    }
    
    // MARK: - NOTE
    // Included a delegate pattern and passing a completion to demonstrate two ways of handling a UIButton tap
    // In a larger project, the appropriate choice is to use one. The delegate pattern is commented out, but works.
//    var delegate: CellButtonTapping?
    var buttonTapped: ((_: String) -> ())?
    
    /// needed for initialization because their are no outlets
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        constructSubviews()
        constructSubviewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func constructSubviews() {
        contentView.addSubview(courseView)
    }
    
    func constructSubviewConstraints() {
        courseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            courseView.topAnchor.constraint(equalTo: contentView.topAnchor),
            courseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            courseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            courseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func styleCell() {
        if let courseViewModel = courseViewModel {
            courseView.titleLabel.text = courseViewModel.titleText
            courseView.subtitleLabel.text = courseViewModel.detailText
            courseView.courseImageView.image = UIImage(named: courseViewModel.name.rawValue) // image
            courseView.bannerView.backgroundColor = UIColor(named: courseViewModel.name.rawValue)! // color
            courseView.purchaseButton.addTarget(self, action: #selector(cellButtonTapped), for: .touchUpInside) // delegate tap
        }
    }
    
    @objc func cellButtonTapped() {
        buttonTapped?(courseViewModel?.titleText ?? "")
//        delegate?.didTapButton(with: courseViewModel?.titleText ?? "")
    }
}
