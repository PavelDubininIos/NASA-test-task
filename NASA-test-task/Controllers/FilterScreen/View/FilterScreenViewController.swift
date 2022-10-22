//
//  FilterScreenViewController.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 19.10.2022.
//

import UIKit

class FilterScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .navigationColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Фильтр"
        navigationController!.navigationBar.topItem!.title = "Назад"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Применить", style: .done, target: nil, action: nil)
    }
}
