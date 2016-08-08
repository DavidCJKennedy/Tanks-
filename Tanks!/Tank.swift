//
//  Tank.swift
//  Tanks!
//
//  Created by user on 06/08/2016.
//  Copyright © 2016 David Kennedy. All rights reserved.
//

import Foundation


class tank {
    
    private var _tankArmour : Int = 1000
    private var _specialAttack : Int = 200
    private var _attackPwr : Int = 10
    
    var randomAttackPwr : UInt32 = 0
    
    
    var tankArmour : Int {
        get {
            return _tankArmour
        }
    }
        
    var specialAttack : Int {
        get {
            return _specialAttack
        }
    }
    
    var attackPwr : Int {
        get {
            return _attackPwr
        }
    }
    
    var isAlive: Bool {
        get {
            if tankArmour <= 0 {
                return false
            } else {
                return true
            }
        }
    }
    
    init(startingTankArmour: Int, specialAttack : Int, attackPwr: Int) {
        self._tankArmour = startingTankArmour
        self._specialAttack = specialAttack
        self._attackPwr = attackPwr
    }
    
    func attemptAttack(attackPwr: Int) -> Bool {
        
        self._tankArmour -= attackPwr
        
        return true
        
    }
    
}