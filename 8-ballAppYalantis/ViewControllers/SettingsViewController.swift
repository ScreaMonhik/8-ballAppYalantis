//
//  SettingsViewController.swift
//  8-ballAppYalantis
//
//  Created by Dima Sunko on 13.10.2021.
//

import UIKit

struct ButtonStatement {
    var isSelected: Bool
    var title: String
}

enum BallAnswers: String, CaseIterable {
    case answer1 = "Ball says yes"
    case answer2 = "Ball doesn't like it"
    case answer3 = "Totally not worth it!"
    case answer4 = "Just do it!"
    case answer5 = "Change your mind"
}

class SettingsViewController: UIViewController {
    
    var buttonsStatementCallback: (([ButtonStatement]) -> ())?
    var buttonsStatements = [ButtonStatement]()
    
    // MARK: - Outlets
    @IBOutlet var buttons: [AnswerButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        buttonsStatements.forEach {
            for count in 0..<buttons.count {
                if $0.title == buttons[count].titleLabel?.text {
                    buttons[count].isSelected = true
                }
            }
        }
        buttonsStatements.removeAll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        buttons.forEach {
            guard let title = $0.titleLabel?.text else { return }
            if $0.isSelected {
                let statements = ButtonStatement(isSelected: $0.isSelected, title: title)
                buttonsStatements.append(statements)
            }
        }
        buttonsStatementCallback?(buttonsStatements)
    }
    
    // MARK: - Actions
    @objc private func didTapButton(_ sender: AnswerButton) { sender.isSelected = !sender.isSelected }
    
    // MARK: - Functions
    private func setupButtons() {
        for count in 0..<buttons.count {
            buttons[count].setTitle(BallAnswers.allCases[count].rawValue, for: .normal)
            buttons[count].titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            buttons[count].layer.cornerRadius = 10
            buttons[count].addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
    }
}
