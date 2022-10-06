//
//  AsteroidViewController.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 07.10.2022.
//

import UIKit

final class AsteroidViewController: UIViewController {
    
    private let presenter = AsteroidPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        presenter.delegate = self
        presenter.update()
    }
}

extension AsteroidViewController: AsteroidPresenterProtocol {
    
    func reloadData(value: NasaModel) {
        print(value)
    }
}
