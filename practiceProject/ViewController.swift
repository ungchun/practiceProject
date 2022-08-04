//
//  ViewController.swift
//  practiceProject
//
//  Created by 김성훈 on 2022/08/04.
//

import UIKit

class ViewController: UIViewController {
    
    private let demoLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        view.self.addSubview(demoLabel)
        
        demoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        demoLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}
