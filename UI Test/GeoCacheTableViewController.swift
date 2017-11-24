//
//  GeoCacheTableViewController.swift
//  UI Test
//
//  Created by Ethan Lo on 11/13/17.
//  Copyright © 2017 EthanLo. All rights reserved.
//

import UIKit

class GeoCacheTableViewController: UITableViewController {

    var geoCacheList: [GeoCache] = []
//    var listIdx: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        geoCacheList = loadCachesFromDefaults()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return geoCacheList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GeoCacheTableViewCell", for: indexPath) as? GeoCacheTableViewCell else {
            fatalError("Dequed cell not an instance of GeoCacheTableViewCell")
        }

        let geoCache = geoCacheList[indexPath.row]
        cell.Title.text = geoCache.title
        
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("clicked \(indexPath.row)")
        
        performSegue(withIdentifier: "ToDetail", sender: indexPath)
        
        
        print("after performSeg \(indexPath.row)")
    }


    
    @IBAction func unwindToTable(sender: UIStoryboardSegue) {
        if let controllerSource = sender.source as? NewCacheViewController {
            if controllerSource.cache != nil {
                // TODO: is the row 1 indexed instead of 0? 
                let indexPath = IndexPath(row: geoCacheList.count, section: 0)
            geoCacheList.append(controllerSource.cache!)
                
                tableView.insertRows(at: [indexPath], with: .automatic)
             
                saveCachesToDefaults(geoCacheList)
            }
        }

    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("begin prepare")
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ToDetail" {
            guard let cur_row = (sender as? IndexPath)?.row else {
                print("no row")
                return
            }
            
            print("fuck1")
            
            guard let dest = segue.destination as? DetailViewController else {
                print("no details")
                return
            }
            
            print("fuck2")
            
            dest.cacheDescription = geoCacheList[cur_row].details
            
            print("fuck3")

        }
    }
}
