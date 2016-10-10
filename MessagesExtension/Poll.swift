//
//  Poll.swift
//  Poll-ish
//
//  Created by Evan Lewis on 9/15/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import Foundation

struct Choice {

    let option: String
    var votes: Int = 0

    init(option: String) {
        self.option = option
    }

    init(option: String, votes: Int) {
        self.init(option: option)
        self.votes = votes
    }

}

class Poll {

    let question: String
    var choices: [Choice]
    var urlQueryItems = [URLQueryItem]()

    init(question: String, choices: [Choice]) {
        self.question = question
        self.choices = choices

        let questionURLComponent = URLQueryItem(name: "question", value: question)
        urlQueryItems.append(questionURLComponent)

        for choice in choices {
            let choiceOptionURLComponent = URLQueryItem(name: "choice", value: choice.option)
            urlQueryItems.append(choiceOptionURLComponent)
            let votesURLComponent = URLQueryItem(name: "votes", value: String(choice.votes))
            urlQueryItems.append(votesURLComponent)
        }

    }

    init?(queryItemsComponents: [URLQueryItem]) {
        // Initialize a poll with an existing URL
        var questionQueryItem: String?
        var choices = [Choice]()

        for (index, queryItem) in queryItemsComponents.enumerated() {
            guard let queryItemValue = queryItem.value else { return nil }

            switch index {
            case 0:
                // Get the question string in the first part of the url
                questionQueryItem = queryItemValue
            case index where index % 2 != 0:
                // Add the vote string and the number of votes. The number of votes is the item after each vote string
                guard let voteString = queryItemsComponents[index + 1].value else { return nil }
                guard let votes = Int(voteString) else { return nil }

                let choice = Choice(option: queryItemValue, votes: votes)
                choices.append(choice)
            default:
                continue
            }
        }

        guard let questionQuery = questionQueryItem else { return nil }

        self.urlQueryItems = queryItemsComponents
        self.question = questionQuery
        self.choices = choices
    }

    func userVotedForChoice(at index: Int) {
        choices[index].votes += 1
        urlQueryItems[index + 1].value = String(choices[index].votes)
    }

}
