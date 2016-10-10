//
//  MessageView.swift
//  Poll-ish
//
//  Created by Evan Lewis on 10/9/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit


class MessageView: UIView {

    static let messageViewFrame = CGRect(x: 0, y: 0, width: 300, height: 250)

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor(red: 0.1411764706, green: 0.1411764706, blue: 0.1411764706, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
