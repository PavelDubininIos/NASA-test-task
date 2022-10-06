//
//  AsteroidPresenter.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 07.10.2022.
//

import Foundation

protocol AsteroidPresenterProtocol: AnyObject {
    
    func reloadData(value: NasaModel)
}

typealias AsteroidPresenterDelegate = AsteroidPresenterProtocol & AsteroidViewController

final class AsteroidPresenter {
    
    weak var delegate: AsteroidPresenterDelegate?
    
    private func loading(startDate: Date, endDate: Date?) {
        let myStartDate = startDate.toStringFormate(dataBase.dateFormate)
        let myEndDate = endDate?.toStringFormate(dataBase.dateFormate)
        Network.shared.getAsteroids(startDate: myStartDate, endDate: myEndDate) { [weak self] value, error in
            guard let value = value else { print(error?.localizedDescription ?? "")
                return
            }
            self?.reloadData(value: value, erorr: error)
        }
    }
}

//MARK: - Input
extension AsteroidPresenter {
    
    func update() {
        loading(startDate: Date(), endDate: nil)
    }
}

//MARK: - Output
extension AsteroidPresenter {
    
    private func reloadData(value: NasaModel?, erorr: Error?) {
        guard let value = value else {
            print(erorr?.localizedDescription ?? "")
            return
        }
        DispatchQueue.main.async {
            self.delegate?.reloadData(value: value)
        }
    }
}
