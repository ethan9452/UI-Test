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
let IdKey = "id"

let ServerUrl = "http://localhost:5000/"
let CreateCachePath = "createCache"
let GetCachesPath = "getCaches"

// Saves an array of GeoCache [String: String] to the UserDefault key GeoCacheKey
func saveCachesToDefaults(_ caches: [GeoCache]) {
    let defaults = UserDefaults.standard
    
    var dictArr: [[String: Any]] = []
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
            let geoCacheDict = item as? [String: Any]
            if geoCacheDict != nil {
                if let checkedGeoCache = GeoCache(fromDictionary: geoCacheDict!) {
                    geoCacheArray.append(checkedGeoCache)
                }
                else {
                    print("Bad dict entry")
                }
            }
            else {
                // If item from array is not GeoCache type, need some way to throw error?
                print("Bad dict entry")
            }
        }
        return geoCacheArray
    }
    else {
        return []
    }    
}

func randomCacheId() -> Int {
    return Int(arc4random())
}

func sendCacheToServer(_ cache: GeoCache) {
    guard let url = URL(string: ServerUrl + CreateCachePath) else {
        print("bad url")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let data = try? JSONSerialization.data(withJSONObject: cache.dictionary, options: [])
    request.httpBody = data
    
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request) {
        data, response, error in
        if let error = error {
            print(error.localizedDescription ?? "Some kind of error")
            return
        }
        print(response)
        print(data)
    }
    
    task.resume()

}

func loadCachesFromServer(onComplete: @escaping ([GeoCache]) -> ()) {
    guard let url = URL(string: ServerUrl + GetCachesPath) else {
        print("bad url")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) {
        data, response, error in
        if let error = error {
            print(error.localizedDescription ?? "Some kind of error")
            return
        }
        print(response)
        print(data)
        
        guard let cacheData = try? JSONSerialization.jsonObject(with: data!, options: []) else {
            return
        }

        guard let cacheDict = cacheData as? [[String: Any]] else {
            return
        }
    
        var loadedCaches: [GeoCache] = []
        for c in cacheDict {
            if let checkedGeoCache = GeoCache(fromDictionary: c) {
                loadedCaches.append(checkedGeoCache)
            }
        }
        
        onComplete(loadedCaches)
    }

    task.resume()
    
    
}

struct GeoCache {
    var id: Int
    var title: String
    var details: String
    var creator: String
    var reward: String
    
    // Question, what is the reason that the internal and external variable names are different?
    init?(fromDictionary dict: [String : Any]) {
        guard let title: String = dict[TitleKey] as? String else {
            return nil
        }
        guard let details: String = dict[DetailsKey] as? String else {
            return nil
        }
        guard let creator: String = dict[CreatorKey] as? String else {
            return nil
        }
        guard let reward: String = dict[RewardKey] as? String else {
            return nil
        }
        guard let id: Int = dict[IdKey] as? Int else {
            return nil
        }
        
        self.title = title
        self.details = details
        self.creator = creator
        self.reward = reward
        self.id = id
    }
    
    var dictionary: [String: Any] {
        get {
            return [IdKey: self.id, TitleKey: self.title, DetailsKey: self.details, CreatorKey: self.creator, RewardKey:self.reward ]
        }
    }
    
    var description: String {
        return "\(title) GeoCache. Location: \(details). Reward is \(reward) and creator is \(creator)"
    }
    
}
