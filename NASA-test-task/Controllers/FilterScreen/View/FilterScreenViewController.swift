//
//  FilterScreenViewController.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 19.10.2022.
//

import UIKit

class FilterScreenViewController: UIViewController {
    
    private lazy var backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 0.3
        return view
    }()

    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.layer.borderWidth = 0.3
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .navigationColor
        tableView.register(FirstFilterScreenCell.self, forCellReuseIdentifier: FirstFilterScreenCell.identifier)
        setupViews()
        setupConstraints()
        viewTranslatesAutoresizingMaskIntoConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Фильтр"
        navigationController!.navigationBar.topItem!.title = "Назад"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Применить", style: .done, target: nil, action: nil)
    }
    
    override func viewDidLayoutSubviews() {
        tableView.layer.cornerRadius = 10
    }
    
    private func setupViews() {
        view.addSubviews(backgroundView, tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 23),
            tableView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 84)
        ])
    }
    
    private func viewTranslatesAutoresizingMaskIntoConstraints() {
        [backgroundView,
        tableView].removeConstraints()
    }
}

extension FilterScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FirstFilterScreenCell.identifier, for: indexPath) as! FirstFilterScreenCell
        switch indexPath {
        case [0, 0]:
            return cell
        default:
            return UITableViewCell()
        }
    }
}
