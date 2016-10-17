//
//  Poll+Image.swift
//  Poll-ish
//
//  Created by Evan Lewis on 10/8/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit

extension Poll {

    func imageRepresentation() -> UIImage? {
        let messageView = MessageView(with: self.choices.count)
        let containerStackView = stackView()

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
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: contextRef)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    // MARK: Message UI
    private var questionLabel: UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 50, width: MessageView.messageViewFrame.width, height: 50))
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.text = self.question
        label.numberOfLines = 2
        label.textAlignment = .center
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func messageLabels() -> [UILabel] {
        var labelArray = [questionLabel]
        for (index, choice) in self.choices.enumerated() {
            let label = UILabel(frame: CGRect(x: 0, y: yOrigin(for: index), width: MessageView.messageViewFrame.width, height: 20))
            label.textColor = .white
            label.text = choice.option
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            labelArray.append(label)
        }
        return labelArray
    }

    private func yOrigin(for choiceIndex: Int) -> CGFloat {
        switch choiceIndex {
        case 0:
            return 125
        case 1:
            return 170
        case 2:
            return 210
        case 3:
            return 250
        case 4:
            return 290
        case 5:
            return 330
        default:
            return MessageView.messageViewFrame.height
        }
    }

    private func stackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: messageLabels())
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

}
