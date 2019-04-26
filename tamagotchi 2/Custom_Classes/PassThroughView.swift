//
//  PassThroughView.swift
//  Tamagotchi
//
//  Created by Ilse Hernandez on 4/25/19.
//  Copyright © 2019 Arzola. All rights reserved.
//

import Foundation
import UIKit

class PassThroughView: UIView
{
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool
    {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}
