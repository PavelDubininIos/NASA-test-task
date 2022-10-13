//
//  AsteroidTableViewCell.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 11.10.2022.
//

import UIKit

final class AsteroidTableViewCell: UITableViewCell {
    
    var stackViewLabels = UIStackView()
    
    private lazy var asteroidImage: UIImageView = {
        var image = UIImageView()
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
       var label = UILabel()
        label.font = .helvetica24Bold()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var dinosaurImage: UIImageView = {
       var image = UIImageView(image: UIImage(named: "Dinosaur"))
        return image
    }()
    
    private lazy var backColor: UIView = {
       var backColor = UIView()
        return backColor
    }()
    
    private lazy var diameterLabel: UILabel = {
       var label = UILabel()
        label.font = .helvetica16()
        label.text =  Metric.diameterString
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var flyToEarthLabel: UILabel = {
       var label = UILabel()
        label.text = Metric.flyToEarthString
        label.font = .helvetica16()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var closeApproachDistanceLabel: UILabel = {
       var label = UILabel()
        label.font = .helvetica16()
        label.text = Metric.closeApproachDistanceString
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var isSentryObjectLabel: UILabel = {
       var label = UILabel()
        label.font = .helvetica16()
        label.text = Metric.isSentryObjectString
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
        viewTranslatesAutoresizingMaskIntoConstraintsToFalse()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func viewTranslatesAutoresizingMaskIntoConstraintsToFalse() {
        [
         asteroidImage,
         nameLabel,
         asteroidImage,
         backColor,
         dinosaurImage,
         diameterLabel,
         flyToEarthLabel,
         closeApproachDistanceLabel,
         isSentryObjectLabel
        ]
            .removeConstraints()
    }
    
    private func setupViews() {
        addSubview(backColor)
        
        [nameLabel, asteroidImage, dinosaurImage].forEach {
            backColor.addSubview($0)
        }
        
        stackViewLabels = UIStackView(arrangedSubviews: [diameterLabel,
                                                         flyToEarthLabel,
                                                         closeApproachDistanceLabel,
                                                         isSentryObjectLabel],
                                      axis: .vertical,
                                      spacing: 8)
        addSubview(stackViewLabels)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: backColor.leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: backColor.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            asteroidImage.topAnchor.constraint(equalTo: backColor.topAnchor, constant: 0),
            asteroidImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 27)
        ])
        
        NSLayoutConstraint.activate([
            backColor.topAnchor.constraint(equalTo: topAnchor),
            backColor.leadingAnchor.constraint(equalTo: leadingAnchor),
            backColor.trailingAnchor.constraint(equalTo: trailingAnchor),
            backColor.heightAnchor.constraint(equalToConstant: 145)
        ])
        
        NSLayoutConstraint.activate([
            dinosaurImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            dinosaurImage.bottomAnchor.constraint(equalTo: backColor.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackViewLabels.topAnchor.constraint(equalTo: backColor.bottomAnchor, constant: 16),
            stackViewLabels.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
    
    func setup(value: Asteroid) {
        nameLabel.text = value.name
        
        guard let distance = value.estimated_diameter?.meters?.estimated_diameter_min else { return }
        diameterLabel.text = "\(Metric.diameterString) " + "\(String(format: "%.0f", distance)) " + "м"
        
        guard let approachDate = value.close_approach_data?.first?.close_approach_date else { return }
        flyToEarthLabel.text = "\(Metric.flyToEarthString) " + "\(approachDate)"
        
        guard let closeApproachDistance = value.close_approach_data?.first?.miss_distance?.kilometers else { return }
        let doubleTypeDistance = Double(closeApproachDistance)
        let stringFormatDistance = String(format: "%.0f", doubleTypeDistance!)
        closeApproachDistanceLabel.text = "\(Metric.closeApproachDistanceString) " + "\(stringFormatDistance) " + "км"
        
        guard let isSentry = value.is_sentry_object else { return }
        switch isSentry {
        case true:
            isSentryObjectLabel.text = "\(Metric.isSentryObjectString) опасен"
            isSentryObjectLabel.textColor = .red
            isSentryObjectLabel.font = .helvetica16Bold()
        case false:
            isSentryObjectLabel.text = "\(Metric.isSentryObjectString) не опасен"
        }
        
        switch value.is_sentry_object {
        case true:
            backColor.backgroundColor = .red
        default:
            backColor.backgroundColor = .green
        }
        
        if value.estimated_diameter?.meters?.estimated_diameter_min ?? 0 <= 85 {
            asteroidImage.image = UIImage(named: "SmallAsteroid")
        } else if value.estimated_diameter?.meters?.estimated_diameter_min ?? 0 >= 85 && value.estimated_diameter?.meters?.estimated_diameter_min ?? 0 <= 300 {
            asteroidImage.image = UIImage(named: "MediumAsteroid")
        } else {
            asteroidImage.image = UIImage(named: "HugeAsteroid")
        }
    }
}

extension AsteroidTableViewCell {
    
    enum Metric {
        static let diameterString: String = "Диаметр:"
        static let flyToEarthString: String = "Подлетает:"
        static let closeApproachDistanceString: String = "на расстояние:"
        static let isSentryObjectString: String = "Оценка:"
    }
}
