//
//  CalculadoraViewController.swift
//  swiftTranning
//
//  Created by Renan Hozumi Barbieri on 16/02/17.
//  Copyright © 2017 Universidade Radix. All rights reserved.
//

import UIKit

class CalculadoraViewController: UIViewController {
    @IBOutlet weak var numOne: UITextField!
    @IBOutlet weak var numTwo: UITextField!
    @IBOutlet weak var result: UILabel!

    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func computeResult(_ sender: Any) {
        let numOneValue = Int(numOne.text!)
        let numTwoValue = Int(numTwo.text!)
        let resultValue: Int = numOneValue! + numTwoValue!
        
        result.text = String(resultValue)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
