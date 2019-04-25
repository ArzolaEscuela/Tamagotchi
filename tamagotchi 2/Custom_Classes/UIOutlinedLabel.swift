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
    override func drawText(in rect: CGRect)
    {
        let attrString = NSAttributedString(string: self.text ?? "", attributes: [NSAttributedStringKey.strokeColor: UIColor.black, NSAttributedStringKey.strokeWidth: -4.0]);

        self.attributedText = attrString;
        super.drawText(in: rect)
    }
    
    /*override func drawText(in rect: CGRect)
    {
        
        let strokeTextAttributes = [
            convertFromNSAttributedStringKey(NSAttributedString.Key.strokeColor) : outlineColor,
            convertFromNSAttributedStringKey(NSAttributedString.Key.strokeWidth) : -1 * outlineWidth,
            ] as [String : Any]
        
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: convertToOptionalNSAttributedStringKeyDictionary(strokeTextAttributes))
        super.drawText(in: rect)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})*/
}
