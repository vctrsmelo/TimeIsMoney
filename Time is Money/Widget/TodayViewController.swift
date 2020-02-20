//
//  TodayViewController.swift
//  Widget
//
//  Created by Victor Melo on 16/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    let titleLabel = UILabel()
    let toPayOffLabel = UILabel()
    let monetaryValueLabel = UILabel()
    let stackView = UIStackView()
    
    let buttonsStackView = UIStackView()
    let clearButton = UIButton()
    let plus1Button = UIButton()
    let plus10Button = UIButton()
    let plus50Button = UIButton()
    let plus100Button = UIButton()
    let plus1000Button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "3 weeks, 2 hours"
        toPayOffLabel.text = "to pay off"
        monetaryValueLabel.text = "$5,234.00"
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(toPayOffLabel)
        stackView.addArrangedSubview(monetaryValueLabel)
        stackView.addArrangedSubview(buttonsStackView)

        configureButtonsStackView()
    }
    
    private func configureButtonsStackView() {
        clearButton.setTitle("C", for: .normal)
        plus1Button.setTitle("+1", for: .normal)
        plus10Button.setTitle("+10", for: .normal)
        plus50Button.setTitle("+50", for: .normal)
        plus100Button.setTitle("+100", for: .normal)
        plus1000Button.setTitle("+1000", for: .normal)
        
        buttonsStackView.addArrangedSubview(clearButton)
        buttonsStackView.addArrangedSubview(plus1Button)
        buttonsStackView.addArrangedSubview(plus10Button)
        buttonsStackView.addArrangedSubview(plus50Button)
        buttonsStackView.addArrangedSubview(plus100Button)
        buttonsStackView.addArrangedSubview(plus1000Button)
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
