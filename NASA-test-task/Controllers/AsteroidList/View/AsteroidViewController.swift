//
//  AsteroidViewController.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 07.10.2022.
//

import UIKit

final class AsteroidViewController: UIViewController {
    
    private let presenter = AsteroidPresenter()
    private var dictionaryAsteroids = [String: [Asteroid]]()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.borderWidth = 0.2
        tableView.layer.cornerRadius = 10
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .navigationColor
        
        presenter.delegate = self
        presenter.update()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .done, target: self, action: #selector(openFilterAction))
        title = "Армагеддон 2022"
        
        tableView.register(AsteroidTableViewCell.self, forCellReuseIdentifier: AsteroidTableViewCell.identifier)
        
        setupViews()
        viewTranslatesAutoresizingMaskIntoConstraints()
        setupConstraints()
    }
    
    private func viewTranslatesAutoresizingMaskIntoConstraints() {
        [tableView].removeConstraints()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension AsteroidViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dictionaryAsteroids.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        308
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = Array(dictionaryAsteroids.keys)[section]
        return dictionaryAsteroids[key]?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = Array(dictionaryAsteroids.keys)[indexPath.section]
        let value = dictionaryAsteroids[key]![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: AsteroidTableViewCell.identifier, for: indexPath) as! AsteroidTableViewCell
        cell.setup(value: value)
        
        var type: AsteroidTableViewCell.TypeAsteroid {
            switch value.estimated_diameter?.meters?.estimated_diameter_min ?? 0 {
            case ...85:
                return .small
            case 85...300:
                return .medium
            case 300...:
                return .huge
            default:
                return .small
            }
        }
        
        cell.sizeAsteroid(type: type)
        return cell
    }
}

extension AsteroidViewController: AsteroidPresenterProtocol {
    
    func reloadData(value: NasaModel) {
        dictionaryAsteroids = value.near_earth_objects ?? [:]
        tableView.reloadData()
    }
}

@objc
extension AsteroidViewController {
    func openFilterAction() {
        print(#function)
    }
}

//
//  AsteroidTableViewCell.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 11.10.2022.
//

import UIKit

final class AsteroidTableViewCell: UITableViewCell {
    
    var stackViewLabels = UIStackView()
        
    enum TypeAsteroid: CGFloat {
        case small = 22
        case medium = -25
        case huge = -260
        
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
    
    private lazy var asteroidImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "SmallAsteroid")
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
    
    private lazy var greenGradient: CAGradientLayer = {
       var layer = CAGradientLayer()
        layer.colors = [UIColor(red: 0.811, green: 0.952, blue: 0.491, alpha: 1).cgColor,
                        UIColor(red: 0.492, green: 0.908, blue: 0.549, alpha: 1).cgColor]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer.bounds = bounds.insetBy(dx: -1*frame.size.width, dy: -2.31*frame.size.height)
        layer.position = center
        return layer
    }()
    
    private lazy var redGradient: CAGradientLayer = {
       var layer = CAGradientLayer()
        layer.colors = [UIColor(red: 1, green: 0.694, blue: 0.6, alpha: 1).cgColor,
                        UIColor(red: 1, green: 0.031, blue: 0.267, alpha: 1).cgColor]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer.bounds = bounds.insetBy(dx: -0.5*bounds.size.width, dy: -2.31*bounds.size.height)
        layer.position = center
        return layer
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
    
    func sizeAsteroid(type: TypeAsteroid) {
        asteroidImage.image = UIImage(named: type.string)
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        let view = UIView()
        view.backgroundColor = .red
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        let topView = UIView()
        let bottomView = UIView()
        topView.backgroundColor = .green
        let stackView = UIStackView(.vertical, .fill, .fill, 0, [topView, bottomView])
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let paramsStackView = UIStackView(.vertical, .equalSpacing, .fill, 8, [diameterLabel, flyToEarthLabel, closeApproachDistanceLabel])
        
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("УНИЧТОЖИТЬ", for: .normal)
        
        let infoStackView = UIStackView(.horizontal, .equalSpacing, .fill, 10, [isSentryObjectLabel, button])
        
        let fillStackView = UIStackView(.vertical, .equalSpacing, .fill, 16, [paramsStackView, infoStackView])
        topView.addSubviews(backColor, dinosaurImage, asteroidImage, nameLabel)
        bottomView.addSubviews(fillStackView)
        fillStackView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.5),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.5),
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            fillStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            fillStackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            fillStackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            fillStackView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -16),
            
            dinosaurImage.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -12),
            dinosaurImage.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            dinosaurImage.widthAnchor.constraint(equalToConstant: 35),
            dinosaurImage.heightAnchor.constraint(equalToConstant: 30),
            
            nameLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: dinosaurImage.leadingAnchor, constant: -10),
            nameLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 32),
            
            asteroidImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 22),
            asteroidImage.trailingAnchor.constraint(lessThanOrEqualTo: topView.trailingAnchor),
            asteroidImage.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -21),
            asteroidImage.topAnchor.constraint(greaterThanOrEqualTo: topView.topAnchor, constant: 0)
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
        
        
        
//        switch value.is_sentry_object {
//        case true:
//            backColor.backgroundColor = .red
//        default:
//            backColor.backgroundColor = .green
//        }
        
        

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


//MARK: - SwiftUI
import SwiftUI
struct AsteroidViewController_Provider : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return AsteroidViewController()
        }
        
        typealias UIViewControllerType = UIViewController
        
        
        let viewController = AsteroidViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<AsteroidViewController_Provider.ContainterView>) -> AsteroidViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: AsteroidViewController_Provider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<AsteroidViewController_Provider.ContainterView>) {
            
        }
    }
    
}
