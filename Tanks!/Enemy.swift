//
//  Enemy.swift
//  Tanks!
//
//  Created by user on 07/08/2016.
//  Copyright © 2016 David Kennedy. All rights reserved.
//

import Foundation

class Enemy: tank {
    
    var loot: [String] {
        return ["Super Ammo", "Health Regen", "Armour Repair"]
    }
    
    func dropLoot() -> String? {
        if !isAlive {
            let rand = Int(arc4random_uniform(UInt32(loot.count)))
            return loot[rand]
        }
        
        return nil
        
    }
    
}