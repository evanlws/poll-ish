//
//  Poll+Image.swift
//  Poll-ish
//
//  Created by Evan Lewis on 10/8/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit

extension Poll {

    static func imageRepresentation(of poll: Poll) -> UIImage? {
        let messageView = MessageView(frame: MessageView.messageViewFrame)

        let question = questionLabel(with: poll.question)
        let containerStackView = stackView(with: [question])

        messageView.addSubview(containerStackView)

        let topConstraint = NSLayoutConstraint(item: containerStackView, attribute: .top, relatedBy: .equal, toItem: messageView, attribute: .top, multiplier: 1.0, constant: 0)
        messageView.addConstraint(topConstraint)

        let bottomConstraint = NSLayoutConstraint(item: containerStackView, attribute: .bottom, relatedBy: .equal, toItem: messageView, attribute: .top, multiplier: 1.0, constant: 0)
        messageView.addConstraint(bottomConstraint)

        let leftConstraint = NSLayoutConstraint(item: containerStackView, attribute: .leading, relatedBy: .equal, toItem: messageView, attribute: .leading, multiplier: 1.0, constant: 0)
        messageView.addConstraint(leftConstraint)
        
        let rightConstraint = NSLayoutConstraint(item: containerStackView, attribute: .trailing, relatedBy: .equal, toItem: messageView, attribute: .trailing, multiplier: 1.0, constant: 0)
        messageView.addConstraint(rightConstraint)

        print(messageView.subviews.count)
        print(containerStackView.subviews)

        // Take the UIView and create a UIImage
        guard let pollImage = Poll.image(for: messageView) else {
            assertionFailure("Could not create image")
            return nil
        }

        return pollImage
    }

    private static func image(for view: UIView) -> UIImage? {
        UIGraphicsBeginImageContext(view.bounds.size)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: contextRef)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    // MARK: UI Helper Methods
    private static func stackView(with subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private static func questionLabel(with text: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 20))
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .green
        label.text = text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
