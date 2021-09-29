//
//  ViewController.swift
//  Leviathon!
//
//  Created by Troy Chibbaro on 2/14/18.
//  Copyright © 2018 Troy Chibbaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
            /*
            Health, and Attributes!
                    */
    

    
        //User Attributes
    
    var userHealth = 100
    var userMana = 0
    var basicAttackDamageLowDef = 0
    var basicAttackDamageHighDef = 0
    
    
    
        //Spell damage modifiers
    func setHighDamage(){
        basicAttackDamageHighDef = Int(arc4random_uniform(81)+40)
    }
    func setLowDamage(){
        basicAttackDamageLowDef = Int(arc4random_uniform(41)+10)
    }
    func setLowLighteningDamage(){
        basicAttackDamageLowDef = Int(arc4random_uniform(51) + 50)
    }
    func setHighLighteningDamage(){
        basicAttackDamageHighDef = Int(arc4random_uniform(101)+50)
    }
    
    
        //Leviathan attributes
    var leviathonDefense = 10
    var leviathonHealth = 1500
    
    
    
            /*
               Spells!
                      */
    
    
    
        //Leviathan Spells
    var leviathonCombatLogText = String ("")
    
    var leviathanDamageVariable = 0
    
    func leviathonStrike(){
        leviathanDamageVariable = Int(arc4random_uniform(5)+6)
        userHealth -= leviathanDamageVariable
        userHealthLabel.text = String ("Player Health: \(userHealth)")
        leviathonCombatLogText = String ("The leviathan strikes you with its wipping tail. it deals \(leviathanDamageVariable) damage.")
        getUserPercentFloat()
    }
    
    func leviathonStrikeDefended(){
        leviathanDamageVariable = Int(arc4random_uniform(6))
        userHealth -= leviathanDamageVariable
        userHealthLabel.text = String ("Player Health: \(userHealth)")
        leviathonCombatLogText = String ("The leviathan strikes your barrier, but it deteriorates and another tenicle hits you. \(leviathanDamageVariable) damage")
        getUserPercentFloat()
    }
    
                /*
                SPELL FUNCTIONS
                      */
    
    
    func basicStrikeAttack () {
        if leviathonDefense >= 5{
            setLowDamage()
            leviathonHealth -= basicAttackDamageLowDef
            combatLogTextView.text = String ("You Strike the Leviathon and it deals \(basicAttackDamageLowDef) damage! \n Tap the green check to finish your turn")
            leviathanHealthLabel.text = String ("Leviathon Health: \(leviathonHealth)")
        } else if leviathonDefense <= 6 {
            setHighDamage()
            leviathonHealth -= basicAttackDamageHighDef
            combatLogTextView.text = String ("You srike the leviathon and it deals \(basicAttackDamageHighDef) damage! \n Tap the green check to finish your turn.")
            leviathanHealthLabel.text = String ("Leviathon Health: \(leviathonHealth)")
            
        }
    }
    
    
    func lighteningAttack(){
        if leviathonDefense <= 5{
            userMana -= 4
            manaLabel.text = String ("\(userMana)")
            setLowLighteningDamage()
            leviathonHealth -= basicAttackDamageLowDef
            combatLogTextView.text = String("A surge of lights and fire rain from the sky... \(basicAttackDamageLowDef)  damage! \n Tap the green check to finished your turn.")
            leviathanHealthLabel.text = String ("Leviathon Health: \(leviathonHealth)")
            
        } else if leviathonDefense >= 6{
            userMana -= 4
            manaLabel.text = String ("\(userMana)")
            setHighLighteningDamage()
            leviathonHealth -= basicAttackDamageHighDef
            combatLogTextView.text = String ("An epic surge of tornado shaped lightening pours out of the sky... \(basicAttackDamageHighDef) Damage! \n Tap the green check to finish your turn.")
            leviathanHealthLabel.text = String ("Leviathon Health: \(leviathonHealth)")
        }
    }
    
    
    func lowerSeaAttack(){
        leviathonDefense -= 1
        userMana -= 2
        manaLabel.text = String("\(userMana)")
        combatLogTextView.text = String ("The timid water that surround the beast begin to simmer... the leviathons defence is now \(leviathonDefense) \n Tap the green check to finish your turn")
        leviathonDefenseLabel.text = String ("\(leviathonDefense)")
    }
    
    
    func blessingAttack(){
        userHealth += 5
        userMana -= 3
        userHealthLabel.text = String ("Player Health: \(userHealth)")
        manaLabel.text = String ("\(userMana)")
        combatLogTextView.text = String ("The Old Gods of Tiginian answer your calls and gift you with this blessing... 10 Health recovered! \n Tap the green check to complete your turn.")
    }
    
    
            /*
            SPELL BUTTONS = PRESSED
                    */
 
    
    func resetSpellbook(){
        spells.setTitle("Spellbook", for: UIControlState.normal)
        spellbookText = "Spellbook"
    }
    
    
    
    @IBAction func basicStrike(_ sender: UIButton) {
        basicStrikeAttack()
        confirmMovePresent()
        lockSpells()
        collapseAttacks()
        resetSpellbook()
        hideBlur()
        getLeviathanHealthFloat()
    }
    
    @IBAction func lightening(_ sender: Any) {
        if userMana <= 3 {
            combatLogTextView.text = String ("You don't have enough mana to cast that!")
            collapseAttacks()
            hideBlur()
            resetSpellbook()
        } else {
        lighteningAttack()
        confirmMovePresent()
        lockSpells()
        collapseAttacks()
        resetSpellbook()
        hideBlur()
        getLeviathanHealthFloat()
        }
    }
    
    @IBAction func lowerSea(_ sender: Any) {
        if userMana <= 1 {
            combatLogTextView.text = String ("You don't have enough mana to cast that!")
            collapseAttacks()
            hideBlur()
            resetSpellbook()
        } else{
        lowerSeaAttack()
        confirmMovePresent()
        lockSpells()
        collapseAttacks()
        resetSpellbook()
        hideBlur()
        getLeviathanHealthFloat()
        }
    }
    
    @IBAction func blessing(_ sender: Any) {
        if userMana <= 2 {
            combatLogTextView.text = String ("You don't have enough mana to cast that!")
            collapseAttacks()
            hideBlur()
            resetSpellbook()
        } else {
        blessingAttack()
        confirmMovePresent()
        lockSpells()
        collapseAttacks()
        resetSpellbook()
        hideBlur()
        getLeviathanHealthFloat()
        }
    }
   
    
                /*
                  outlets
                        */
    
        //spell outlets
    @IBOutlet weak var basic: UIButton!
    @IBOutlet weak var lightening: UIButton!
    @IBOutlet weak var lower: UIButton!
    @IBOutlet weak var blessing: UIButton!
    @IBOutlet weak var spells: UIButton!
    @IBOutlet weak var defendButtonOutlet: UIButton!
    @IBOutlet weak var prayButtonOutlet: UIButton!
    
    
    
    
        // Combat log and health labels
    @IBOutlet weak var leviathanHealthLabel: UILabel!
    @IBOutlet weak var userHealthLabel: UILabel!
    @IBOutlet weak var combatLogTextView: UITextView!
    @IBOutlet weak var manaLabel: UILabel!
    @IBOutlet weak var leviathonDefenseLabel: UILabel!
    @IBOutlet weak var monsterBlurOutlet: UIVisualEffectView!
    
    
            /*
            CONFIRM ACTION BUTTON
                */
    
        //Animation Start point Outlet
    
    @IBOutlet weak var startConfirmLocation: UILabel!
    
        //CGPoint for Actual Confirm Action Location
    
    var confirmMoveLocation: CGPoint!
    
        //CGPoint for animation start location
    
    var confirmButtonEndLocation: CGPoint!
    
    
        //Confirm Button = pressed
    
    @IBAction func confirmMoveButton(_ sender: UIButton) {
        leviathonAttackMessage()
        unlockSpells()
        
        confirmMoveOutlet.isHidden = true
        spellbookText = "Spellbook"
        defendButtonOutlet.isHidden = false
        prayButtonOutlet.isHidden = false
    }
    
        //Outlet for confirm button
    
    @IBOutlet weak var confirmMoveOutlet: UIButton!
    
    
        //Confirm Button = Presented (animation from bottom to top)
    
    func confirmMovePresent(){
        confirmMoveOutlet.isHidden = false
        UIView.animate(withDuration: 0.12, animations: {
            self.confirmMoveOutlet.center = self.confirmButtonEndLocation
        })
    }
    
    
              /*
            DEFEND AND PRAY BUTTONS PRESSED
                    */
    
    @IBAction func prayButtonPressed(_ sender: UIButton) {
        userMana += 1
        manaLabel.text = String ("\(userMana)")
        hidePrayDef()
        leviathonStrike()
        combatLogTextView.text = String ("The gods answer your prayers... You gain 1 mana point! \(leviathonCombatLogText)")
        self.confirmMoveOutlet.center = self.startConfirmLocation.center
    }
    
    
    @IBAction func defendButtonPressed(_ sender: UIButton) {
        hidePrayDef()
        self.confirmMoveOutlet.center = self.startConfirmLocation.center
        leviathonStrikeDefended()
        combatLogTextView.text = String ("You raise a magic barrier to protect you from the monsters strike... \(leviathonCombatLogText)")
    }
    
    
    func hidePrayDef(){
        prayButtonOutlet.isHidden = true
        defendButtonOutlet.isHidden = true
        self.confirmMoveOutlet.center = self.startConfirmLocation.center
    }
    
    
    
               /*
                UI Spellbook Animation Functions
                          */
  
    
        //Health Bars!!!
    @IBOutlet weak var userHealthBar: UIProgressView!
    @IBOutlet weak var leviathanHealthBar: UIProgressView!
    
    
    var userHealthFloat = Float (0.0)
    
    var leviathanHealthFloat = Float (0.0)
    
    func getUserPercentFloat() {
        userHealthFloat = Float (userHealth) / 100.0
        userHealthBar.setProgress(userHealthFloat, animated: true)
    }
    
    func getLeviathanHealthFloat(){
        leviathanHealthFloat = Float (leviathonHealth) / 1500.0
        leviathanHealthBar.setProgress(leviathanHealthFloat, animated: true)
    }
    
        //App animation function
    
    
    func showAttacks(){
        UIView.animate(withDuration: 0.2, animations: {
            self.basic.center = self.strikeLocation
            self.lightening.center = self.lighteningLocation
            self.lower.center = self.seaLocation
            self.blessing.center = self.blessingLocation
        })
    }
    
    
    func collapseAttacks() {
        
        UIView.animate(withDuration: 0.2, animations:{
            self.basic.center = self.spells.center
            self.lightening.center = self.spells.center
            self.lower.center = self.spells.center
            self.blessing.center = self.spells.center
        })
    }
    
    
               /*
            Spell Enabeling functions
                    */
    
    
            //Disables Spellbook
    
    func lockSpells(){
        basic.isEnabled = false
        lightening.isEnabled = false
        lower.isEnabled = false
        blessing.isEnabled = false
    }
    
    func unlockSpells(){
        basic.isEnabled = true
        lightening.isEnabled = true
        lower.isEnabled = true
        blessing.isEnabled = true
    }
    
        // Prints to combat log that Lav is attacking
    
    func leviathonAttackMessage(){
        combatLogTextView.text = String ("The leviathon prepares to strike. Will you")
    }
    
            /*
            Spellbook button animations
                    */
    
    var spellbookText: String = ("Spellbook")

    @IBAction func spellbook(_ sender: UIButton) {

        if spellbookText == "Spellbook"{
            spellbookText = "Close"
            spells.setTitle("Close", for: UIControlState.normal)
            showAttacks()
            UIView.animate(withDuration: 0.2, animations:{
                
                self.basic.isHidden = false
                self.lightening.isHidden = false
                self.lower.isHidden = false
                self.blessing.isHidden = false
                self.showblur()
            } )
        } else {
            spellbookText = "Spellbook"
            spells.setTitle("Spellbook", for: UIControlState.normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.basic.center = self.spells.center
                self.lightening.center = self.spells.center
                self.lower.center = self.spells.center
                self.blessing.center = self.spells.center
                self.hideBlur()
            })
            
            
        }
    }

    
    //blur functions
    
    func showblur(){
        UIView.animate(withDuration: 0.4, animations: {
            self.monsterBlurOutlet.isHidden = false
        })
    }
    func hideBlur(){
        UIView.animate(withDuration: 0.4, animations: {
            self.monsterBlurOutlet.isHidden = true
        })
    }
    
            // Locations of spells
    
    var strikeLocation: CGPoint!
    var lighteningLocation: CGPoint!
    var seaLocation: CGPoint!
    var blessingLocation:CGPoint!
    var spellbookLocation:CGPoint!
    
    
    
                /*
                initial view settings
                    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        leviathanHealthLabel.text = String ("Leviathan Health: \(leviathonHealth)")
        
        //hides buttons till they're pressed
        basic.isHidden = true
        lightening.isHidden = true
        lower.isHidden = true
        blessing.isHidden = true
        
        confirmMoveOutlet.isHidden = true
        
        monsterBlurOutlet.isHidden = true
        
        prayButtonOutlet.isHidden = true
        defendButtonOutlet.isHidden = true
        
        
        strikeLocation = basic.center
        lighteningLocation = lightening.center
        seaLocation = lower.center
        blessingLocation = blessing.center
        spellbookLocation = spells.center
        
        confirmButtonEndLocation = confirmMoveOutlet.center
        confirmMoveOutlet.center = startConfirmLocation.center
        
        basic.center = spells.center
        lightening.center = spells.center
        lower.center = spells.center
        blessing.center = spells.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

