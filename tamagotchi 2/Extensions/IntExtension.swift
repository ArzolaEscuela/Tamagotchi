//
//  IntExtension.swift
//  Tamagotchi
//
//  Created by Ilse Hernandez on 4/25/19.
//  Copyright © 2019 Arzola. All rights reserved.
//

import Foundation
import GameKit
import GameplayKit

extension Int
{
    static func random(min: Int, max: Int) -> Int {
        precondition(min <= max)
        let randomizer = GKRandomSource.sharedRandom()
        return min + randomizer.nextInt(upperBound: max - min + 1)
    }
}
