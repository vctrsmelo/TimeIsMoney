//
//  TodayViewController.swift
//  Today Calculator
//
//  Created by Victor Melo on 24/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    var viewModel: TodayViewModel
    var monetaryValue = NSDecimalNumber(value: 0)
    
    let worktimeLabel = UILabel()
    let toPayOffLabel = UILabel()
    let monetaryValueLabel = UILabel()
    let stackView = UIStackView()
    
    let buttonsStackView = UIStackView()
    let buttons = [
        CalculatorButton(title: "C", action: ClearAction()),
        CalculatorButton(title: "+1", action: AddValueAction.withValue(1)),
        CalculatorButton(title: "+5", action: AddValueAction.withValue(5)),
        CalculatorButton(title: "+10", action: AddValueAction.withValue(10)),
        CalculatorButton(title: "+50", action: AddValueAction.withValue(50)),
        CalculatorButton(title: "+100", action: AddValueAction.withValue(100)),
        CalculatorButton(title: "+1k", action: AddValueAction.withValue(1000))
    ]
    
    let currencyFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.isLenient = true
        return nf
    }()
    
    init() {
        self.viewModel = TodayViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = TodayViewModel()
        super.init(coder: coder)
    }
    
    override func loadView() {
        self.view = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        worktimeLabel.text = ""
        toPayOffLabel.text = "to pay off"
        monetaryValueLabel.text = currencyFormatter.string(from: monetaryValue)
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        stackView.addArrangedSubview(worktimeLabel)
        stackView.addArrangedSubview(toPayOffLabel)
        stackView.addArrangedSubview(monetaryValueLabel)
        stackView.addArrangedSubview(buttonsStackView)

        configureButtonsStackView()
        
        viewModel.updateWorkingTime(for: monetaryValue)
    }
    
    private func configureButtonsStackView() {
        buttons.forEach {
            buttonsStackView.addArrangedSubview($0)
            $0.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        }
    }
    
    @objc
    func buttonAction(sender: CalculatorButton) {
        calculate(sender.action)
        monetaryValueLabel.text = currencyFormatter.string(from: monetaryValue)
    }
    
    func calculate(_ calculatorAction: CalculatorButtonAction) {
        monetaryValue = calculatorAction.action(monetaryValue)
        viewModel.updateWorkingTime(for: monetaryValue)
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

extension TodayViewController: TodayViewModelDelegate {
    
    func didUpdateWorkingTime(_ workingTime: String) {
        self.worktimeLabel.text = workingTime
    }
    
}
