//
//  CreatePollViewController.swift
//  Poll-ish
//
//  Created by Evan Lewis on 9/13/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit

protocol CreatePollViewControllerDelegate: class {
    //  Called when the user taps to create a new poll
    func userCreated(poll: Poll, inViewController: CreatePollViewController)

}

class CreatePollViewController: UIViewController {

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var firstChoiceTextField: UITextField!
    @IBOutlet weak var secondChoiceTextField: UITextField!

    static let identifier = "CreatePollViewController"

    weak var delegate: CreatePollViewControllerDelegate?

    @IBAction func createPollButtonTapped(withSender createPollButton: UIButton) {
        guard
            let questionText = questionTextField.text,
            let firstChoiceText = firstChoiceTextField.text,
            let secondChoiceText = secondChoiceTextField.text
            else { return }

        let firstChoice = Choice(option: firstChoiceText)
        let secondChoice = Choice(option: secondChoiceText)
        let newPoll = Poll(question: questionText, choices: [firstChoice, secondChoice])

        // Call the delegate with the selected poll
        delegate?.userCreated(poll: newPoll, inViewController: self)
    }

}

extension CreatePollViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}
