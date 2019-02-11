//
//  ViewController.swift
//  artnet-app
//
//  Created by Maegan Wilson on 6/14/18.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CalculationReplaceDelegate {
    
    //answer labels
    @IBOutlet weak var fixtureUni: UILabel!
    @IBOutlet weak var subnetLabel: UILabel!
    @IBOutlet weak var universeLabel: UILabel!
    
    // CALC Buttons
    @IBOutlet weak var calcFixtBttn: UIButton!
    @IBOutlet weak var calcArtNetBttn: UIButton!
    
    //SELECT BUTTONS
    @IBOutlet weak var selectFixtureUni: UIButton!
    @IBOutlet weak var selectArtSub: UIButton!
    @IBOutlet weak var selectArtUni: UIButton!
    
    // NUMBER BUTTONS
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    
    var artnetUniverse: String = ""
    var artnetSubnet: String = ""
    var fixtureUniverse: String = ""
    
    var typeOfCalc = ""
    
    var calculations = Calculations.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subnetLabel.text = "0"
        universeLabel.text = "0"
        typeOfCalc = "fixture"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PreviousTableViewController {
            let vc = segue.destination as? PreviousTableViewController
            vc?.delegate = self
            vc?.calcs = calculations.calcs
        }
    }
    
    // ------------------------------------------
    // HELPER FUNCTIONS
    // ------------------------------------------
    
    func enableAllNumbers(){
        zero.isEnabled = true
        one.isEnabled = true
        two.isEnabled = true
        three.isEnabled = true
        four.isEnabled = true
        five.isEnabled = true
        six.isEnabled = true
        seven.isEnabled = true
        eight.isEnabled = true
        nine.isEnabled = true
        
        zero.alpha = 1
        one.alpha = 1
        two.alpha = 1
        three.alpha = 1
        four.alpha = 1
        five.alpha = 1
        six.alpha = 1
        seven.alpha = 1
        eight.alpha = 1
        nine.alpha = 1
    }
    
    func disableAllNumbers(){
        zero.isEnabled = false
        one.isEnabled = false
        two.isEnabled = false
        three.isEnabled = false
        four.isEnabled = false
        five.isEnabled = false
        six.isEnabled = false
        seven.isEnabled = false
        eight.isEnabled = false
        nine.isEnabled = false
        
        zero.alpha = 0.5
        one.alpha = 0.5
        two.alpha = 0.5
        three.alpha = 0.5
        four.alpha = 0.5
        five.alpha = 0.5
        six.alpha = 0.5
        seven.alpha = 0.5
        eight.alpha = 0.5
        nine.alpha = 0.5
    }
    func setNum(num: String) {
        switch typeOfCalc {
        case "fixture":
            selectArtUni.isEnabled = false
            selectArtSub.isEnabled = false
            calcFixtBttn.isEnabled = false
            selectArtUni.alpha = 0.5
            selectArtSub.alpha = 0.5
            calcFixtBttn.alpha = 0.5
            
            if fixtureUniverse.count < 3 {
                fixtureUniverse += num
                fixtureUni.text = fixtureUniverse
                
                if Double(fixtureUniverse)! == 25.0 {
                    six.isEnabled = false
                    six.alpha = 0.5
                    seven.isEnabled = false
                    seven.alpha = 0.5
                    eight.isEnabled = false
                    eight.alpha = 0.5
                    nine.isEnabled = false
                    nine.alpha = 0.5
                }
                else if Double(fixtureUniverse)! >= 26 {
                    disableAllNumbers()
                }
            }
        case "art-sub":
            selectFixtureUni.isEnabled = false
            calcArtNetBttn.isEnabled = false
            selectFixtureUni.alpha = 0.5
            calcArtNetBttn.alpha = 0.5
            if artnetSubnet.count < 2 {
                artnetSubnet += num
                subnetLabel.text = artnetSubnet
                
                if Double(artnetSubnet)! ==  1{
                    six.isEnabled = false
                    six.alpha = 0.5
                    seven.isEnabled = false
                    seven.alpha = 0.5
                    eight.isEnabled = false
                    eight.alpha = 0.5
                    nine.isEnabled = false
                    nine.alpha = 0.5
                }
                
                else if Double(artnetSubnet)! >= 2 && Double(artnetSubnet)! < 15 {
                    disableAllNumbers()
                }
                
                else if Double(artnetSubnet)! == 15{
                    disableAllNumbers()
                }
            }
        case "art-uni":
            selectFixtureUni.isEnabled = false
            calcArtNetBttn.isEnabled = false
            selectFixtureUni.alpha = 0.5
            calcArtNetBttn.alpha = 0.5
            if artnetUniverse.count < 2 {
                artnetUniverse += num
                universeLabel.text = artnetUniverse
                
                if Double(artnetUniverse)! == 1{
                    six.isEnabled = false
                    seven.isEnabled = false
                    eight.isEnabled = false
                    nine.isEnabled = false
                }
                else if Double(artnetUniverse)! >= 2 && Double(artnetUniverse)! < 15 {
                    disableAllNumbers()
                }
                else if Double(artnetUniverse)! == 15{
                    disableAllNumbers()
                }
            }
        default:
            fixtureUni.text = ""
            subnetLabel.text = ""
            universeLabel.text = ""
            selectFixtureUni.isEnabled = true
            selectArtSub.isEnabled = true
            selectArtUni.isEnabled = true
            calcArtNetBttn.isEnabled = true
            calcFixtBttn.isEnabled = true
            selectFixtureUni.alpha = 1
            selectArtSub.alpha = 1
            selectArtUni.alpha = 1
            calcArtNetBttn.alpha = 1
            calcFixtBttn.alpha = 1
        }
    }
    
    // ------------------------------------------
    //  BUTTON PUSH FUNCTIONS
    // ------------------------------------------
    
    // ------------------------------------------
    //  SELECT INPUT TYPE
    // ------------------------------------------
    
    @IBAction func inputUniverse(_ sender: UIButton) {
        typeOfCalc = "fixture"
        enableAllNumbers()
    }
    @IBAction func inputArtSub(_ sender: UIButton) {
        typeOfCalc = "art-sub"
        enableAllNumbers()
    }
    @IBAction func inputArtUni(_ sender: UIButton) {
        typeOfCalc = "art-uni"
        enableAllNumbers()
    }
    
    // ------------------------------------------
    // NUMBERS
    // ------------------------------------------
    @IBAction func buttonZeroPush(_ sender: UIButton) {
        setNum(num: "0")
    }
    @IBAction func buttonOnePush(_ sender: UIButton) {
        setNum(num: "1")
    }
    @IBAction func buttonTwoPush(_ sender: UIButton) {
        setNum(num: "2")
    }
    @IBAction func buttonThreePush(_ sender: UIButton) {
        setNum(num: "3")
    }
    
    @IBAction func buttonFourPush(_ sender: UIButton) {
        setNum(num: "4")
    }
    
    @IBAction func buttonFivePush(_ sender: UIButton) {
        setNum(num: "5")
    }
    
    @IBAction func buttonSixPush(_ sender:UIButton) {
        setNum(num: "6")    }
    
    @IBAction func buttonSevenPush(_ sender:UIButton) {
        setNum(num: "7")
    }
    
    @IBAction func buttonEightPush(_ sender:UIButton) {
        setNum(num: "8")
    }
    
    @IBAction func buttonNinePush(_ sender:UIButton) {
        setNum(num: "9")
    }
    
    @IBAction func buttonBackPush(_ sender: UIButton) {
        switch typeOfCalc {
        case "fixture":
            if fixtureUniverse.count != 0 {
                fixtureUniverse.remove(at: fixtureUniverse.index(before: fixtureUniverse.endIndex))
                if fixtureUniverse.count == 0 {
                    fixtureUni.text = "0"
                }
                else {
                    fixtureUni.text = fixtureUniverse
                }
            }
            else {
                fixtureUni.text = "0"
            }
            enableAllNumbers()
        case "art-sub":
            if artnetSubnet.count != 0 {
                artnetSubnet.remove(at: artnetSubnet.index(before: artnetSubnet.endIndex))
                if artnetSubnet.count == 0 {
                    subnetLabel.text = "0"
                }
                else {
                    subnetLabel.text = artnetSubnet
                }
            }
            else {
                subnetLabel.text = "0"
            }
            enableAllNumbers()
        default:
            if artnetUniverse.count != 0 {
                artnetUniverse.remove(at: artnetUniverse.index(before: artnetUniverse.endIndex))
                if artnetUniverse.count == 0 {
                    universeLabel.text = "0"
                }
                else {
                    universeLabel.text = artnetUniverse
                }
            }
            else {
                universeLabel.text = "0"
            }
            enableAllNumbers()
        }
    }
    
    // ------------------------------------------
    //  CALCULATE FUNCTIONS
    // ------------------------------------------
    @IBAction func calcArtNet(_ sender: UIButton) {
        selectFixtureUni.isEnabled = true
        selectArtUni.isEnabled = true
        selectArtSub.isEnabled = true
        calcArtNetBttn.isEnabled = true
        calcFixtBttn.isEnabled = true
        
        selectFixtureUni.alpha = 1
        selectArtSub.alpha = 1
        selectArtUni.alpha = 1
        calcArtNetBttn.alpha = 1
        calcFixtBttn.alpha = 1
        enableAllNumbers()
        
        if fixtureUniverse.count != 0 {
            let numUni: Double = Double(fixtureUniverse)!
            var sub = 0.0
            var uni = 0.0
            if numUni == 1.0 {
                sub = 0.0
                uni = 0.0
            }else {
                sub = numUni/16.0
                sub.round(.down)
                uni = numUni - (sub * 16)
            }
            let textSub:String = "\(Int(sub))"
            let textUni:String = "\(Int(uni))"
            subnetLabel.text = textSub
            universeLabel.text = textUni
            let newCalc:Calc = Calc(universe: fixtureUniverse, artsub: textSub, artuni: textUni, note: [])
            calculations.addCalc(calculation: newCalc)
            fixtureUniverse = ""
        }
    }
    @IBAction func calcFixtUni(_ sender: UIButton) {
        selectFixtureUni.isEnabled = true
        selectArtUni.isEnabled = true
        selectArtSub.isEnabled = true
        calcArtNetBttn.isEnabled = true
        calcFixtBttn.isEnabled = true
        selectFixtureUni.alpha = 1
        selectArtSub.alpha = 1
        selectArtUni.alpha = 1
        calcArtNetBttn.alpha = 1
        calcFixtBttn.alpha = 1
        
        enableAllNumbers()
        
        if subnetLabel.text == "0" && universeLabel.text == "0" {
            fixtureUni.text = "1"
            fixtureUniverse = ""
            calculations.addCalc(calculation: Calc(universe: "1", artsub: "0", artuni: "0", note: []))
        }
        else {
            if artnetUniverse.count == 0 {
                artnetUniverse = "0"
            }
            if artnetSubnet.count == 0 {
                artnetSubnet = "0"
            }
            var ans: Int = Int(artnetSubnet)!
            ans *= 16
            ans += Int(artnetUniverse)!
            // output
            fixtureUni.text = "\(ans)"
            calculations.addCalc(calculation: Calc(universe: "\(ans)", artsub: artnetSubnet, artuni: artnetUniverse, note: []))
            fixtureUniverse = ""
        }
        
        artnetSubnet = ""
        artnetUniverse = ""
    }
    
    func replaceCalc(calcs: Array<Calc>) {
        calculations.calcs = calcs
    }
}
