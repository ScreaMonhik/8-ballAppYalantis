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
    
    let decoder = JSONDecoder()
    var labelText = String()
    
// MARK: - Outlets
    
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
// MARK: - Functions
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = "Shake shake shake!"
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        guard let url = URL(string: "https://8ball.delegator.com/magic/JSON/question") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else { return }

            do {
                let answer = try self.decoder.decode(MagicAnswer.self, from: data)
                self.labelText = answer.magic.answer
            } catch let error {
                print(error)
            }
        }.resume()
        answerLabel.text = labelText
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = "Shake cancelled"
    }
    
}

