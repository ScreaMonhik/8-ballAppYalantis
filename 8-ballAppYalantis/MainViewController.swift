//
//  MainViewController.swift
//  8-ballAppYalantis
//
//  Created by Dima Sunko on 16.10.2021.
//

import UIKit

// MARK: - Structs
struct Answer: Codable {
    var answer: String
}

struct MagicAnswer: Codable {
    var magic: Answer
}

class MainViewController: UIViewController {
    var buttonsStatements = [ButtonStatement]()

    // MARK: - Outlets
    @IBOutlet private weak var answerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = "Shake the phone and receive an answer!"
    }
    
    @IBAction func didTapSettingsButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let settingsViewController = storyBoard.instantiateViewController(withIdentifier: "settingsViewController") as? SettingsViewController else { return }
        settingsViewController.buttonsStatementCallback = { [weak self] buttonsStatementStruct in
            self?.buttonsStatements.removeAll()
            self?.buttonsStatements = buttonsStatementStruct
        }
        settingsViewController.buttonsStatements = buttonsStatements
        present(settingsViewController, animated: true)
    }
    
    // MARK: - Functions
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = "Shake shake shake!"
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        let decoder = JSONDecoder()
        var additionalAnswers = [String]()
        guard let url = URL(string: "https://8ball.delegator.com/magic/JSON/question") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            guard let data = data else { return }
            do {
                let answer = try decoder.decode(MagicAnswer.self, from: data)
                DispatchQueue.main.async {
                    self?.answerLabel.text = answer.magic.answer
                }
            } catch {
                DispatchQueue.main.async {
                for counter in 0..<(self?.buttonsStatements.count)! {
                    guard let buttonTitle = self?.buttonsStatements[counter].title else { return }
                    additionalAnswers.append(buttonTitle)
                }
                    if additionalAnswers.isEmpty {
                        self?.alert(title: "Check your internet connection!", message: "Also you can add additional answers from settings", style: .alert)
                    } else {
                        self?.answerLabel.text = additionalAnswers.randomElement()
                    }
                }
            }
        }.resume()
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = "Shake cancelled"
    }
    
    func alert(title: String, message: String, style: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let alertControllerAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertControllerAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
