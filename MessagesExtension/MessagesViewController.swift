//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Evan Lewis on 9/12/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {

    override func willBecomeActive(with conversation: MSConversation) {
        super.willBecomeActive(with: conversation)
        debugPrint(#function)
        // Present the view controller appropriate for the conversation and presentation style.
        presentViewController(for: conversation, with: presentationStyle)
    }

    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        guard let conversation = activeConversation else { fatalError("Expected an active converstation") }
        debugPrint(#function)
        // Present the view controller appropriate for the conversation and presentation style.
        presentViewController(for: conversation, with: presentationStyle)
    }

    //    First entrypoint when user opens the app
    func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        debugPrint(#function)
        // Determine the controller to present.
        let controller: UIViewController

        // If we already have a converstation (if the user clicked on a message), go to voting

        if conversation.selectedMessage != nil {
            print("Selected message")

            if conversation.selectedMessage?.url != nil {
                print("URL \(conversation.selectedMessage?.url)")
            } else {
                print("No URL")
            }
        }

        if let selectedMessageURL = conversation.selectedMessage?.url {
            controller = instantiateVotingViewController(with: selectedMessageURL)
        } else {
            if presentationStyle == .compact {
                controller = instantiateCreatePollButtonViewController()
            } else {
                controller = instantiateCreatePollController()
            }
        }

        // Remove any existing child controllers.
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }

        // Embed the new controller.
        addChildViewController(controller)

        controller.view.frame = view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)

        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        controller.didMove(toParentViewController: self)
    }

    // MARK: Navigation
    private func instantiateCreatePollController() -> UIViewController {
        debugPrint(#function)
        guard let createPollViewController = storyboard?.instantiateViewController(withIdentifier: CreatePollViewController.identifier) as? CreatePollViewController else { fatalError("Unable to instantiate CreatePollViewController from storyboard") }
        
        createPollViewController.delegate = self
        return createPollViewController
    }

    private func instantiateCreatePollButtonViewController() -> UIViewController {
        debugPrint(#function)
        guard let createPollButtonViewController = storyboard?.instantiateViewController(withIdentifier: CreatePollButtonViewController.identifier) as? CreatePollButtonViewController else { fatalError("Unable to instantiate CreatePollViewController from storyboard") }

        createPollButtonViewController.delegate = self
        return createPollButtonViewController
    }

    private func instantiateVotingViewController(with url: URL) -> UIViewController {
        debugPrint(#function)
        guard let votingViewController = storyboard?.instantiateViewController(withIdentifier: VotingViewController.identifier) as? VotingViewController,
        let queryItems = NSURLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        else { fatalError("Unable to instantiate VotingViewController from storyboard") }

        votingViewController.poll = Poll(queryItemsComponents: queryItems)
        votingViewController.delegate = self
        return votingViewController
    }

    // MARK: Send poll MSMessage
    func stage(poll: Poll) {
        let layout = MSMessageTemplateLayout()
        layout.image = poll.imageRepresentation()

        let message = MSMessage(session: MSSession())
        message.layout = layout

        var components = URLComponents()
        components.queryItems = poll.urlQueryItems

        guard let componentURL = components.url else { fatalError("URL not found for poll \(poll.question)") }
        message.url = componentURL

        guard let activeConversation = activeConversation else { print("No active convo"); return }
        activeConversation.insert(message) { error in
            if let error = error {
                print(error)
            }
        }
    }
}

//Called when the user clicks the Create Poll Button to start creating a poll
extension MessagesViewController: CreatePollButtonViewControllerDelegate {
    func createPollButtonTapped(from viewController: CreatePollButtonViewController) {
        print("Requested")
        requestPresentationStyle(.expanded)
    }
}

//Called when the user just created a poll
extension MessagesViewController: CreatePollViewControllerDelegate {
    func userCreated(poll: Poll, from viewController: CreatePollViewController) {
        debugPrint("created poll \(poll.question)")
        stage(poll: poll)
        requestPresentationStyle(.compact)
    }
}

//Called wheh a user votes in a poll
extension MessagesViewController: VotingViewControllerDelegate {
    func userVoted(in poll: Poll, from viewController: VotingViewController) {
        debugPrint("Voted in poll \(poll.question)")
        stage(poll: poll)
        requestPresentationStyle(.compact)
    }
}
