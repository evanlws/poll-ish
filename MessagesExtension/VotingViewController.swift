//
//  VotingViewController.swift
//  Poll-ish
//
//  Created by Evan Lewis on 10/9/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit

class VotingViewController: UIViewController {

    static let identifier = "VotingViewController"

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionOneButton: UIButton!
    @IBOutlet weak var optionTwoButton: UIButton!

    var poll: Poll?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("QUESTION: \(poll?.question)")
    }

    @IBAction func didTapOptionOne(withSender optionOneButton: UIButton) {

    }

    @IBAction func didTapOptionTwo(withSender optionTwoButton: UIButton) {

    }

}
