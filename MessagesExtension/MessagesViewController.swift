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
        if let selectedMessage = conversation.selectedMessage {
            print("selected message \(selectedMessage.summaryText)")
        }

        // Determine the controller to present.
        let controller: UIViewController

        if presentationStyle == .compact {
            controller = instantiateCreatePollButtonViewController()
        } else {
            controller = instantiateCreatePollController()
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
    func userCreated(poll: Poll, inViewController: CreatePollViewController) {
        debugPrint("created poll \(poll.question)")
        let viiew = UIView(frame: CGRect(x: 0, y: 0, width: 376, height: 300))
        viiew.backgroundColor = UIColor.red

        guard let activeConversation = activeConversation else { print("No active convo"); return }
        //guard let selectedMessage = activeConversation.selectedMessage else { print("No message"); return }

        let message = MSMessage(session: MSSession())
        let layout = MSMessageTemplateLayout()
        layout.image = Poll.imageRepresentation(of: viiew)
        message.layout = layout

        activeConversation.insert(message) { error in
            if let error = error {
                print(error)
            }
        }

        requestPresentationStyle(.compact)
    }
}
