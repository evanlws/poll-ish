//
//  Poll+Image.swift
//  Poll-ish
//
//  Created by Evan Lewis on 10/8/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit

extension Poll {

    static func imageRepresentation(of view: UIView) -> UIImage? {
        UIGraphicsBeginImageContext(view.bounds.size)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: contextRef)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
    
}
