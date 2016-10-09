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
  
}

class Poll {
  
  let question: String
  var choices: [Choice]
  
  init(question: String, choices: [Choice]) {
    self.question = question
    self.choices = choices
  }
  
  func userVotedForChoice(at index: Int) {
    choices[index].votes += 1
  }
  
}
