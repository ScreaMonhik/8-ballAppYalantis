//
//  SettingsViewController.swift
//  8-ballAppYalantis
//
//  Created by Dima Sunko on 13.10.2021.
//

import UIKit

enum BallAnswers: String, CaseIterable {
    case answer1 = "Ball says yes"
    case answer2 = "Ball doesn't like it"
    case answer3 = "Totally not worth it!"
    case answer4 = "Just do it!"
    case answer5 = "Change your mind"
}

class SettingsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var buttons: [AnswerButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
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
