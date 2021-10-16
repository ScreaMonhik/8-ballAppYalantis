//
//  AnswerButton.swift
//  8-ballAppYalantis
//
//  Created by Dima Sunko on 16.10.2021.
//

import UIKit

class AnswerButton: UIButton {
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.27, animations: { [weak self] in
                guard let self = self else {
                    return
                }
                self.alpha = self.isSelected ? 1 : 0.5
            })
        }
    }
}
