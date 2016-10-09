//
//  CreatePollButtonViewController.swift
//  Poll-ish
//
//  Created by Evan Lewis on 9/13/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit

class CreatePollButtonViewController: UIViewController {

    static let identifier = "CreatePollButtonViewController"

    weak var delegate: CreatePollButtonViewControllerDelegate?

    @IBAction func createPollButtonTapped(withSender createPollButton: UIButton) {
        delegate?.createPollButtonTapped(from: self)
    }

}

protocol CreatePollButtonViewControllerDelegate: class {
    // Called when the user taps the "Create Poll" button
    func createPollButtonTapped(from viewController: CreatePollButtonViewController)
}
