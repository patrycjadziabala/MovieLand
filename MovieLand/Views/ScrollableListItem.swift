//
//  ScrollableListItem.swift
//  MovieLand
//
//  Created by Patka on 11/03/2023.
//

import UIKit

class ScrollableItemView: UIView {
    
    init(frame: CGRect, title: String, subtitle: String, image: UIImage?) {
        super.init(frame: frame)
        let stackView = UIStackView(frame: .zero)
        let imageView = UIImageView(frame: .zero)
        let titleLabel = UILabel(frame: .zero)
        let subTitleLabel = UILabel(frame: .zero)
        imageView.image = image
        titleLabel.text = title
        subTitleLabel.text = subtitle
        addSubview(stackView)
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        backgroundColor = .cyan
        clipsToBounds = true
        layer.cornerRadius = 8
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.constraint(to: self, insets: UIEdgeInsets(top: 8,
                                                            left: 8,
                                                            bottom: 8,
                                                            right: -8))
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
