//
//  AsteroidTableViewCell.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 11.10.2022.
//

import UIKit

final class AsteroidTableViewCell: UITableViewCell {
    
    private lazy var asteroidImage: UIImageView = {
        var image = UIImageView(image: UIImage(named: "Asteroid"))
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
       var label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
        viewTranslatesAutoresizingMaskIntoConstraints()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewTranslatesAutoresizingMaskIntoConstraints() {
        [
         asteroidImage,
         nameLabel,
         asteroidImage
        ]
            .removeConstraints()
    }
    
    private func setupViews() {
        addSubview(nameLabel)
        addSubview(asteroidImage)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            asteroidImage.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            asteroidImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 27)
        ])
        
    }
    
    func setup(value: Asteroid) {
        nameLabel.text = value.name
    }
}
