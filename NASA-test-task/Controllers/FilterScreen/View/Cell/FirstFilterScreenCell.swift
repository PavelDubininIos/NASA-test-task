//
//  FirstFilterScreenCell.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 24.10.2022.
//

import UIKit

class FirstFilterScreenCell: UITableViewCell {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Ед. изм. расстояний"
        label.font = UIFont(name: "SF Pro Text", size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //TODO: - create segment control
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .tableViewColor
        setupViews()
        viewTranslatesAutoresizingMaskIntoConstraintsToFalse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewTranslatesAutoresizingMaskIntoConstraintsToFalse() {
        [label].removeConstraints()
    }
    
    private func setupViews() {
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
        ])
    }
}
