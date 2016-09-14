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
    
    // Present the view controller appropriate for the conversation and presentation style.
    presentViewController(for: conversation, with: presentationStyle)
  }
  
  func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
    // Determine the controller to present.
    let controller: UIViewController
    
    if presentationStyle == .compact {
      controller = instantiatePollsViewController()
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
    guard let createPollViewController = storyboard?.instantiateViewController(withIdentifier: CreatePollViewController.identifier) as? CreatePollViewController else { fatalError("Unable to instantiate CreatePollViewController from storyboard") }
    
    return createPollViewController
  }
  
  private func instantiatePollsViewController() -> UIViewController {
    guard let pollsViewController = storyboard?.instantiateViewController(withIdentifier: PollsViewController.identifier) as? PollsViewController else { fatalError("Unable to instantiate CreatePollViewController from storyboard") }
    
    return pollsViewController
  }

}
