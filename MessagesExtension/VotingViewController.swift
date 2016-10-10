//
//  VotingViewController.swift
//  Poll-ish
//
//  Created by Evan Lewis on 10/9/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit

protocol VotingViewControllerDelegate: class {
    func userVoted(in poll: Poll, from viewController: VotingViewController)
}

class VotingViewController: UIViewController {

    static let identifier = "VotingViewController"

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionOneButton: UIButton!
    @IBOutlet weak var optionTwoButton: UIButton!

    weak var delegate: VotingViewControllerDelegate?
    
    var poll: Poll?

    override func viewDidLoad() {
        guard let poll = poll else {
            assertionFailure("Poll not initialized yet!")
            return
        }

        questionLabel.text = poll.question
        optionOneButton.setTitle(poll.choices[0].option, for: .normal)
        optionTwoButton.setTitle(poll.choices[1].option, for: .normal)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("QUESTION: \(poll!.question)")
    }

    @IBAction func didTapOptionOne(withSender optionOneButton: UIButton) {
        poll?.userVotedForChoice(at: 0)
        userDidVote()
    }

    @IBAction func didTapOptionTwo(withSender optionTwoButton: UIButton) {
        poll?.userVotedForChoice(at: 1)
        userDidVote()
    }

    // MARK: Navigation
    func userDidVote() {
        guard let poll = poll else { return }
        delegate?.userVoted(in: poll, from: self)
    }

}
