//
//  AsteroidTableViewCell.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 11.10.2022.
//

import UIKit

final class AsteroidTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private var fullStackView = UIStackView()
    private var paramsStackView = UIStackView()
    private var infoStackView = UIStackView()
    private var fillStackView = UIStackView()
    
    private lazy var topView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    enum TypeAsteroid {
        case small
        case medium
        case huge
        
        var string: String {
            switch self {
                
            case .small:
                return "SmallAsteroid"
            case .medium:
                return "MediumAsteroid"
            case .huge:
                return "HugeAsteroid"
            }
        }
    }
    
    private lazy var visibleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var asteroidImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "SmallAsteroid")
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .helvetica24Bold()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var dinosaurImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Dinosaur"))
        return image
    }()
    
    private lazy var diameterLabel: UILabel = {
        let label = UILabel()
        label.font = .helvetica16()
        label.text =  Metric.diameterString
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var flyToEarthLabel: UILabel = {
        let label = UILabel()
        label.text = Metric.flyToEarthString
        label.font = .helvetica16()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var closeApproachDistanceLabel: UILabel = {
        let label = UILabel()
        label.font = .helvetica16()
        label.text = Metric.closeApproachDistanceString
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var isSentryObjectLabel: UILabel = {
        let label = UILabel()
        label.font = .helvetica16()
        label.text = Metric.isSentryObjectString
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("УНИЧТОЖИТЬ", for: .normal)
        button.titleLabel?.tintColor = .white
        button.backgroundColor = .systemBlue
        button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
        button.clipsToBounds = true
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(destroyButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupViews()
        viewTranslatesAutoresizingMaskIntoConstraintsToFalse()
        makeShadowUnderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func viewTranslatesAutoresizingMaskIntoConstraintsToFalse() {
        [
            visibleView,
            asteroidImage,
            nameLabel,
            dinosaurImage,
            diameterLabel,
            flyToEarthLabel,
            closeApproachDistanceLabel,
            isSentryObjectLabel,
            button,
            fullStackView,
            fillStackView
        ]
            .removeConstraints()
    }
    
    
    func sizeAsteroid(type: TypeAsteroid) {
        asteroidImage.image = UIImage(named: type.string)
    }
    
    private func configStacks() {
        fullStackView = UIStackView(.vertical, .fill, .fill, 0, [topView, bottomView])
        paramsStackView = UIStackView(.vertical, .equalSpacing, .fill, 8, [diameterLabel, flyToEarthLabel, closeApproachDistanceLabel])
        infoStackView = UIStackView(.horizontal, .equalSpacing, .fill, 10, [isSentryObjectLabel, button])
        fillStackView = UIStackView(.vertical, .equalSpacing, .fill, 16, [paramsStackView, infoStackView])
        
    }
    
    private func gradientView(isSentryAsteroid: Bool) {
        switch isSentryAsteroid {
        case true:
            let leftColor = UIColor(red: 1, green: 0.694, blue: 0.6, alpha: 1).cgColor
            let rightColor = UIColor(red: 1, green: 0.031, blue: 0.267, alpha: 1).cgColor
            insertGradient(leftColor: leftColor, rightColor: rightColor)
        case false:
            let leftColor = UIColor(red: 0.811, green: 0.952, blue: 0.491, alpha: 1).cgColor
            let rightColor = UIColor(red: 0.492, green: 0.908, blue: 0.549, alpha: 1).cgColor
            insertGradient(leftColor: leftColor, rightColor: rightColor)
        }
    }
    
//TODO: - Change frame of gradient
    
    private func insertGradient(leftColor: CGColor, rightColor: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [leftColor, rightColor]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame.origin.x = CGFloat(0)
        gradientLayer.frame.origin.y = CGFloat(145)
        gradientLayer.frame.size.height = CGFloat(-145)
        gradientLayer.frame.size.width = CGFloat(385)
        gradientLayer.frame.size.width = contentView.layer.frame.size.width + dinosaurImage.layer.frame.size.width + CGFloat(29)
        topView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupViews() {
        contentView.addSubview(visibleView)
        configStacks()
        visibleView.addSubview(fullStackView)
        topView.addSubviews(dinosaurImage, asteroidImage, nameLabel)
        bottomView.addSubviews(fillStackView)
        
        NSLayoutConstraint.activate([
            visibleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.5),
            visibleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            visibleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            visibleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.5),
            
            fullStackView.topAnchor.constraint(equalTo: visibleView.topAnchor),
            fullStackView.leadingAnchor.constraint(equalTo: visibleView.leadingAnchor),
            fullStackView.trailingAnchor.constraint(equalTo: visibleView.trailingAnchor),
            fullStackView.bottomAnchor.constraint(equalTo: visibleView.bottomAnchor),
            
            fillStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            fillStackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            fillStackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            fillStackView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -16),
            
            dinosaurImage.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -12),
            dinosaurImage.topAnchor.constraint(equalTo: topView.topAnchor, constant: 115),
            dinosaurImage.widthAnchor.constraint(equalToConstant: 35),
            dinosaurImage.heightAnchor.constraint(equalToConstant: 30),
            
            nameLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: dinosaurImage.leadingAnchor, constant: -10),
            nameLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 32),
            
            asteroidImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 22),
            asteroidImage.trailingAnchor.constraint(lessThanOrEqualTo: topView.trailingAnchor),
            asteroidImage.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -23),
            asteroidImage.topAnchor.constraint(greaterThanOrEqualTo: topView.topAnchor, constant: 0),
            
            button.heightAnchor.constraint(equalToConstant: 28),
            button.widthAnchor.constraint(equalToConstant: 121)
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
            gradientView(isSentryAsteroid: true)
        case false:
            isSentryObjectLabel.text = "\(Metric.isSentryObjectString) не опасен"
            gradientView(isSentryAsteroid: false)
        }
    }
}

//MARK: - Extensions

@objc
extension AsteroidTableViewCell {
    private func destroyButtonAction() {
        print(#function)
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
