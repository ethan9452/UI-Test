//
//  ViewController.swift
//  UI Test
//
//  Created by Ethan Lo on 10/19/17.
//  Copyright © 2017 EthanLo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     Left Send button
     When pressed, takes the lowercase of the left text-field
     and appends to label
     */
    @IBAction func LeftButton(_ sender: UIButton) {
        // Question: is using the ?? how people normally check for nil? It seems shorter than 'if let'
        MiddleLable.text = (MiddleLable.text ?? "") + (LeftTextField.text?.lowercased() ?? "")
    }
    
    /*
     Right send button
     When pressed, takes the uppercase of the right text-field
     and appends to label
     */
    @IBAction func RightButton(_ sender: UIButton) {
        MiddleLable.text = (MiddleLable.text ?? "") + (RightTextField.text?.uppercased() ?? "")
    }
    
    /*
     Clears vowels from text label
     */
    @IBAction func ClearVowelButton(_ sender: UIButton) {
//        let voweless = (MiddleLable.text ?? "").filter(while: {["a", "e", "i", "o", "u"].contains($0)})
        let voweless = (MiddleLable.text ?? "").filter({!["a", "e", "i", "o", "u"].contains($0)})
        print(voweless)
        MiddleLable.text = voweless
    }
    
    /*
     Clears all from text label
     */
    @IBAction func ClearButton(_ sender: UIButton) {
        MiddleLable.text = ""
    }
    
    @IBOutlet weak var LeftTextField: UITextField!
    
    @IBOutlet weak var RightTextField: UITextField!
    
    @IBOutlet weak var MiddleLable: UILabel!
}

