//
//  AsteroidViewController.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 07.10.2022.
//

import UIKit

final class AsteroidViewController: UIViewController {
    
    private let presenter = AsteroidPresenter()
    private lazy var dictionaryAsteroids = [String: [Asteroid]]()
    private var bool = true
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.borderWidth = 0.2
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainViewBackgroundColor
        
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
