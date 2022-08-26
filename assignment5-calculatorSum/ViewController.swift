//
//  ViewController.swift
//  assignment5-calculatorSum
//
//  Created by Burkay Atar on 24.08.2022.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var numberDisplayingOnScreen: Double = 0
    var previousNumber: Double = 0.0
    var inCalculationProcess: Bool = false
    var operation: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resultLabel.text = ""
    }

    @IBAction func numbers(_ sender: UIButton) {
        
        if inCalculationProcess == true {
            resultLabel.text = String(sender.tag - 1)
            numberDisplayingOnScreen = Double(resultLabel.text!)!
            inCalculationProcess = false
        } else {
            resultLabel.text = resultLabel.text! + String(sender.tag - 1)
            numberDisplayingOnScreen = Double(resultLabel.text!)!
        }
    }
    
    @IBAction func operationButtons(_ sender: Any) {
        
        //11: AC, 12:C ,13: +, 14: =, 15: ,
        
        if resultLabel.text != ""
            && (sender as AnyObject).tag != 11
            && (sender as AnyObject).tag != 12
            && (sender as AnyObject).tag != 14 {
            
            previousNumber = Double(resultLabel.text!)!
            operation = (sender as AnyObject).tag
            inCalculationProcess = true
        } else if (sender as AnyObject).tag == 14 {
            
            if resultLabel.text!.isEmpty {
                AudioServicesPlaySystemSound(SystemSoundID(1057))
            }
            if operation == 13 {
                //sum
                resultLabel.text = String(previousNumber + numberDisplayingOnScreen)
            }
            if previousNumber != 0 {
                //add for to clear the label and enter new input after calculation
                inCalculationProcess = true
            }
            
        } else if (sender as AnyObject).tag == 11 {
                //AC
            resultLabel.text = ""
            previousNumber = 0.0
            numberDisplayingOnScreen = 0.0
            operation = 0
        } else if (sender as AnyObject).tag == 12 {
            //Clear
            resultLabel.text = ""
            numberDisplayingOnScreen = 0
        }
    }
    
    @IBAction func decimalPoint(_ sender: Any) {
        
        if inCalculationProcess || resultLabel.text!.isEmpty {
            resultLabel.text = "0."
            inCalculationProcess = false
        } else {
            if !resultLabel.text!.contains(".") {
                resultLabel.text = resultLabel.text! + "."
            }else {
                AudioServicesPlaySystemSound(SystemSoundID(1057))
            }
        }
        numberDisplayingOnScreen = Double(resultLabel.text!)!
    }
}

