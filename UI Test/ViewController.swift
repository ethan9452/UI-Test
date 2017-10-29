//
//  ViewController.swift
//  UI Test
//
//  Created by Ethan Lo on 10/19/17.
//  Copyright © 2017 EthanLo. All rights reserved.
//

import UIKit
//import GeoCache

class ViewController: UIViewController {
    
    var geoCacheList: [GeoCache] = []
    var listIdx: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        geoCacheList = loadCachesFromDefaults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var cacheLabel: UITextView!
    
    @IBAction func nextCache() {
        print(listIdx)
        print(geoCacheList.count)
        print(geoCacheList.debugDescription)
        
        if geoCacheList.count == 0 {
                        
            titleField.text = ""
            detailsField.text = ""
            creatorField.text = ""
            rewardField.text = ""
            cacheLabel.text = ""
        }
        else {
            
            print("hello2")
            
            listIdx = (listIdx + 1) % geoCacheList.count
            titleField.text = geoCacheList[listIdx].title
            detailsField.text = geoCacheList[listIdx].details
            creatorField.text = geoCacheList[listIdx].creator
            rewardField.text = geoCacheList[listIdx].reward
            cacheLabel.text = geoCacheList[listIdx].description
        }
    }
    
    @IBAction func addGeoCache() {
        // gaurd passes if the titleField is both not nil, and not an empty string
        guard let newTitle: String = titleField.text, !newTitle.isEmpty else {
            cacheLabel.text = "Error: Missing title"
            return
        }
        guard let newDetails: String = detailsField.text, !newDetails.isEmpty else {
            cacheLabel.text = "Error: Missing details"
            return
            
        }
        guard let newCreator: String = creatorField.text, !newCreator.isEmpty else {
            cacheLabel.text = "Error: Missing creator"
            return
        }
        guard let newReward: String = rewardField.text, !newReward.isEmpty else {
            cacheLabel.text = "Error: Missing reward"
            return
        }
        
        if let newGeoCache = GeoCache(fromDictionary: [TitleKey: newTitle, DetailsKey: newDetails, CreatorKey: newCreator, RewardKey: newReward ]) {
            print(newGeoCache.description)
            
            print(geoCacheList.count)
            
            geoCacheList.append(newGeoCache)
            
            print(geoCacheList.count)
            
            saveCachesToDefaults(geoCacheList)
        }
    }
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var detailsField: UITextField!
    
    @IBOutlet weak var creatorField: UITextField!
    
    @IBOutlet weak var rewardField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var rewaredLabel: UILabel!
    
}

