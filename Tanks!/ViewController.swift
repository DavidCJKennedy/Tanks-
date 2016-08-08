//
//  ViewController.swift
//  Tanks!
//
//  Created by user on 05/08/2016.
//  Copyright © 2016 David Kennedy. All rights reserved.
//

import UIKit
import AVFoundation

var bgSound: AVAudioPlayer!
var fireSound: AVAudioPlayer!
var destroyedSound: AVAudioPlayer!

class ViewController: UIViewController {
    
    var enemyAttackPwr: Int!
    var playerAttackPwr: Int!
    var playerArmour: Int = 1000
    var enemyArmour: Int = 1000
    var enemyWinsScore: Int = 0
    var playerWinsScore: Int = 0
    
    @IBOutlet weak var redTank: UIImageView!
    @IBOutlet weak var greenTank: UIImageView!
    @IBOutlet weak var fireBtn: UIButton!
    @IBOutlet weak var printView: UIImageView!
    @IBOutlet weak var gameLbl: UILabel!
    @IBOutlet weak var playerArmourLbl: UILabel!
    @IBOutlet weak var enemyArmourLbl: UILabel!
    @IBOutlet weak var winnerLbl: UILabel!
    @IBOutlet weak var replayLbl: UIButton!
    @IBOutlet weak var playerWinsLbl: UILabel!
    @IBOutlet weak var enemyWinsLbl: UILabel!
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        playerArmourLbl.text = "\(playerArmour) Armour"
        
        
        let path = NSBundle.mainBundle().pathForResource("tanks", ofType: "mp3")
        let soundUrl = NSURL (fileURLWithPath: path!)
        
        do {
            try bgSound = AVAudioPlayer(contentsOfURL: soundUrl)
            bgSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        bgSound.play()
        
       let _path = NSBundle.mainBundle().pathForResource("tankFiring", ofType: "mp3")
        let _soundUrl = NSURL(fileURLWithPath: _path!)
        
        do {
            try fireSound = AVAudioPlayer(contentsOfURL: _soundUrl)
            fireSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        let path2 = NSBundle.mainBundle().pathForResource("tankFiring", ofType: "mp3")
        let soundUrl2 = NSURL (fileURLWithPath: path2!)
        
        do {
            try destroyedSound = AVAudioPlayer(contentsOfURL: soundUrl2)
            destroyedSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
        
        
        
        
        
    }
    
    @IBAction func replayBtnPressed(sender: AnyObject){
        restartGame()
    }
    
    @IBAction func fireBtnPressed(sender: AnyObject) {
        
        playerAttackPwr = randAttPower([10,20,40,200])
        enemyAttackPwr = randAttPower([10,20,40,200])
        
        enemyArmour = enemyArmour - playerAttackPwr
        enemyArmourLbl.text = "\(enemyArmour) Armour"
        gameLbl.text = "You attacked enemy \(playerAttackPwr)"
        
        playerArmour = playerArmour - enemyAttackPwr
        playerArmourLbl.text = "\(playerArmour) Armour"
        
        playFireSound()
        fireSound.play()
        
        if isEnemyAlive == false {
            _destroyedSound()
            destroyedSound.play()
            
            playerWins()
         }
        
        if isPlayerAlive == false {
            _destroyedSound()
            destroyedSound.play()
            
            enemyWins()
        }
        
        if self.fireBtn.enabled == false && enemyAttackPwr > 100 {
            
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "enableButton", userInfo: nil, repeats: false)
            enableButton()
        playerArmour = playerArmour - 200
            playerArmourLbl.text = "\(playerArmour) Armour"
        }

    }
    
    func _destroyedSound() {
        if fireSound.playing {
            fireSound.stop()
        }
    }
    
    func playFireSound() {
        if fireSound.playing {
            fireSound.stop()
        }
    }
    
    func randAttPower(attackPwr: [Int]) -> Int {
        let rand = Int(arc4random_uniform(UInt32(attackPwr.count)))
        return attackPwr[rand]
    }


    func tankImobilse() {
        
            
        }
    
    func enableButton() {
        self.fireBtn.enabled = true
    }
    
    var loot: [String] {
        return ["Super Ammo", "Health Regen", "Armour Repair"]
    }
    
    func dropLoot() -> String? {
        if !isEnemyAlive {
            let rand = Int(arc4random_uniform(UInt32(loot.count)))
            return loot[rand]
        }
        
        return nil
        
    }
    
    var isPlayerAlive: Bool {
        get {
            if playerArmour <= 0 {
                return false

            } else {
                return true
            }
        }
    
    }
    
    var isEnemyAlive: Bool {
        get {
            if enemyArmour <= 0 {
                return false
            } else {
                return true
            }
        }
    }
    
    func playerWins () {
        redTank.hidden = false
        greenTank.hidden = true
        fireBtn.hidden = true
        printView.hidden = true
        gameLbl.hidden = true
        playerArmourLbl.hidden = true
        enemyArmourLbl.hidden = true
        winnerLbl.hidden = false
        replayLbl.hidden = false
        
        playerWinsScore++
        winnerLbl.text = "You won!"
        playerWinsLbl.text = "Player wins = \(playerWinsScore)"

    }
    
    func enemyWins () {
        greenTank.hidden = false
        redTank.hidden = true
        fireBtn.hidden = true
        printView.hidden = true
        gameLbl.hidden = true
        playerArmourLbl.hidden = true
        enemyArmourLbl.hidden = true
        winnerLbl.hidden = false
        replayLbl.hidden = false
        
        enemyWinsScore++
        winnerLbl.text = "Enemy Tank won!"
        enemyWinsLbl.text = "Enemy wins = \(enemyWinsScore)"
    }
    
    func restartGame () {
        redTank.hidden = false
        greenTank.hidden = false
        fireBtn.hidden = false
        printView.hidden = false
        gameLbl.hidden = false
        playerArmourLbl.hidden = false
        enemyArmourLbl.hidden = false
        winnerLbl.hidden = true
        replayLbl.hidden = true
        
        playerArmour = 1000
        playerArmourLbl.text = "\(playerArmour) Armour"
        enemyArmour = 1000
        enemyArmourLbl.text = "\(enemyArmour) Armour"

    }
    
}