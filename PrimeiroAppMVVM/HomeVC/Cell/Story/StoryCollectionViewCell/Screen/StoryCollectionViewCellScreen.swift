//
//  StoryCollectionViewCellScreen.swift
//  PrimeiroAppMVVM
//
//  Created by Igor Fortti on 16/02/23.
//

import UIKit

class StoryCollectionViewCellScreen: UIView {
    
    lazy var profileImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()

    lazy var addButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setBackgroundImage(UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageView?.tintColor = .white
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 12.5
        return btn
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        configConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(profileImageView)
        addSubview(addButton)
        addSubview(userNameLabel)
    }
    
    private func configConstrains() {
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            
            addButton.heightAnchor.constraint(equalToConstant: 25),
            addButton.widthAnchor.constraint(equalToConstant: 25),
            addButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            addButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            
            userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
}
