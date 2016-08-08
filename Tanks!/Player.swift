//
//  Player.swift
//  Tanks!
//
//  Created by user on 07/08/2016.
//  Copyright © 2016 David Kennedy. All rights reserved.
//

import Foundation

class Player: tank {
    
    private var _name = "Player"
    
    var name: String {
        get {
            return _name
        }
    }
    
    convenience init(armour: Int) {
        self.init(armour: armour)
        
        _name = name
        
    }
    
    
}