//
//  PlanetsTableViewController.swift
//  Solar System iOS
//
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class PlanetsTableViewController: UITableViewController {
    
    let astronomicalObjects = AstronomicalObject.allKnownObjects
    var presentsFavorites = false

    override func viewDidLoad() {
        super.viewDidLoad()

        if presentsFavorites {
            title = "Favorites"
            
            // Clear favorites button
            self.navigationItem.rightBarButtonItem = nil
        }
    }

    @IBAction func favoritesButtonPressed() {
        if !presentsFavorites {
            if let listNavigationController = storyboard?.instantiateViewController(withIdentifier: "PlanetsNavigationController") as? UINavigationController {
                if let listController = listNavigationController.viewControllers.first as? PlanetsTableViewController {
                    listController.presentsFavorites = true
                }
                listNavigationController.modalTransitionStyle = .flipHorizontal
                present(listNavigationController, animated: true, completion: nil)
                
            }
        }
    }
    
    var presentedAstronomicalObjects: [AstronomicalObject] {
        if presentsFavorites {
            return AstronomicalObject.favoriteObjects
        }
        else {
            return AstronomicalObject.allKnownObjects
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentedAstronomicalObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath)
        guard let planetCell = cell as? PlanetTableViewCell else {
            return cell
        }
        
        planetCell.configure(withObject: presentedAstronomicalObjects[indexPath.row])
        return planetCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? PlanetDetailsViewController, let cell = sender as? UITableViewCell else {
            return
        }
        
        if let row = tableView.indexPath(for: cell)?.row {
            destination.presentedObject = presentedAstronomicalObjects[row]
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
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
