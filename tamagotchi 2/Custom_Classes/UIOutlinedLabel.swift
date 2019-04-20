//
//  UIOutlinedLabel.swift
//  Tamagotchi
//
//  Created by alumno on 4/20/19.
//  Copyright © 2019 Arzola. All rights reserved.
//

import UIKit

class UIOutlinedLabel: UILabel
{
    
    var outlineWidth: CGFloat = 5
    var outlineColor: UIColor = UIColor.black
    
    override func drawText(in rect: CGRect)
    {
        
        let strokeTextAttributes = [
            NSStrokeColorAttributeName : outlineColor,
            NSStrokeWidthAttributeName : -1 * outlineWidth,
            ] as [String : Any]
        
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
        super.drawText(in: rect)
    }
}
