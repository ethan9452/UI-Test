//
//  GeoCache.swift
//  UI Test
//
//  Created by Ethan Lo on 10/28/17.
//  Copyright © 2017 EthanLo. All rights reserved.
//

import Foundation

let GeoCacheKey = "caches"

let TitleKey = "title"
let DetailsKey = "details"
let CreatorKey = "creator"
let RewardKey = "reward"

// Saves an array of GeoCache [String: String] to the UserDefault key GeoCacheKey
func saveCachesToDefaults(_ caches: [GeoCache]) {
    let defaults = UserDefaults.standard
    
    var dictArr: [[String: String]] = []
    for c in caches {
        dictArr.append(c.dictionary)
    }
    
    defaults.set(dictArr, forKey: GeoCacheKey)
    defaults.synchronize()
}

// Loads array corresponding to the UserDefault key GeoCacheKey,
func loadCachesFromDefaults() -> [GeoCache] {
    let defaults = UserDefaults.standard
    if let loadedCaches = defaults.array(forKey: GeoCacheKey) {
        // Return value
        var geoCacheArray: [GeoCache] = []
        
        for item in loadedCaches {
            let geoCacheDict = item as? [String: String]
            if geoCacheDict != nil {
                let checkedGeoCache = GeoCache(fromDictionary: geoCacheDict!)
                geoCacheArray.append(checkedGeoCache!)
            }
            else {
                // If item from array is not GeoCache type, need some way to throw error?
                return [GeoCache(fromDictionary: ["bogus": "bogus"])!]
            }
        }
        return geoCacheArray
    }
    else {
        return []
    }    
}

struct GeoCache {
    var title: String
    var details: String
    var creator: String
    var reward: String
    
    // Question, what is the reason that the internal and external variable names are different?
    init?(fromDictionary dict: [String : String]) {
        guard let title: String = dict[TitleKey] else {
            return nil
        }
        guard let details: String = dict[DetailsKey] else {
            return nil
        }
        guard let creator: String = dict[CreatorKey] else {
            return nil
        }
        guard let reward: String = dict[RewardKey] else {
            return nil
        }
        
        self.title = title
        self.details = details
        self.creator = creator
        self.reward = reward
    }
    
    var dictionary: [String: String] {
        get {
            return [TitleKey: self.title, DetailsKey: self.details, CreatorKey: self.creator, RewardKey:self.reward ]
        }
    }
    
    var description: String {
        return "\(title) GeoCache. Location: \(details). Reward is \(reward) and creator is \(creator)"
    }
    
}
