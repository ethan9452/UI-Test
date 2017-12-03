//
//  ViewController.swift
//  UI Test
//
//  Created by Ethan Lo on 10/19/17.
//  Copyright © 2017 EthanLo. All rights reserved.
//

import UIKit

class NewCacheViewController: UIViewController {
    
    var cache: GeoCache? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var cacheLabel: UITextView!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        cache = nil
        dismiss(animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("segue adding new cachee")
                
        guard let newTitle: String = titleField.text, !newTitle.isEmpty else {
            cache = nil
            return
        }
        guard let newDetails: String = detailsField.text, !newDetails.isEmpty else {
            cache = nil
            return
            
        }
        guard let newCreator: String = creatorField.text, !newCreator.isEmpty else {
            cache = nil
            return
        }
        guard let newReward: String = rewardField.text, !newReward.isEmpty else {
            cache = nil
            return
        }
        
        if let newGeoCache = GeoCache(fromDictionary: [IdKey: randomCacheId(), TitleKey: newTitle, DetailsKey: newDetails, CreatorKey: newCreator, RewardKey: newReward ]) {
            cache = newGeoCache
        }
        
    }
    
//    @IBAction func save(_ sender: UIBarButtonItem) {
//    }
    
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var detailsField: UITextField!
    
    @IBOutlet weak var creatorField: UITextField!
    
    @IBOutlet weak var rewardField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var rewaredLabel: UILabel!
    
}

