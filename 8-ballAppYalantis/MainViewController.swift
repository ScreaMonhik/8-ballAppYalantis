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
    
    // MARK: - Outlets
    @IBOutlet private weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = "Shake the phone and receive an answer!"
    }
    
    // MARK: - Functions
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = "Shake shake shake!"
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        let decoder = JSONDecoder()
        guard let url = URL(string: "https://8ball.delegator.com/magic/JSON/question") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let data = data else { return }
            do {
                let answer = try decoder.decode(MagicAnswer.self, from: data)
                DispatchQueue.main.async {
                    self?.answerLabel.text = answer.magic.answer
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = "Shake cancelled"
    }
}
