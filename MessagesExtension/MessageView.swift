//
//  MessageView.swift
//  Poll-ish
//
//  Created by Evan Lewis on 10/9/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit

class MessageView: UIView {

    static let messageViewFrame = CGRect(x: 0, y: 0, width: 400, height: 600)  //400 , 600 Max 7 Plus //

    convenience init(with pollNumber: Int) {
        let frameHeight: Int

        switch pollNumber {
        case 2:
            frameHeight = 300
        default:
            frameHeight = 340
        }
        
        self.init(frame:CGRect(x: 0, y: 0, width: 250, height: frameHeight))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.1411764706, green: 0.1411764706, blue: 0.1411764706, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
