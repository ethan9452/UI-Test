//
//  DetailViewController.swift
//  UI Test
//
//  Created by Ethan Lo on 11/23/17.
//  Copyright © 2017 EthanLo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var cacheDescription: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if cacheDescription != nil {
            details.text = cacheDescription
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var details: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
