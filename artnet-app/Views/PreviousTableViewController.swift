//
//  PreviousTableViewController.swift
//  artnet-app
//
//  Created by Maegan Wilson on 7/4/18.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import CoreData
//protocol CalculationReplaceDelegate: class {
//    func replaceCalc(calcs: Array<Calc>)
//}

class PreviousTableViewController: UITableViewController {
    
    var calcs = Calculations()
    var indexForSelectedRow: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calcs.count()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Calculations"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        let row = indexPath.row
        
        // Retrieve values from calculation
        let calc = calcs.getCalc(index: row)
        let fixtureUniverse: String = "\(calc.value(forKeyPath: "fixtureUniverse") ?? 1)"
        let subnet: String = "\(calc.value(forKeyPath: "subnet") ?? 0)"
        let universe: String = "\(calc.value(forKeyPath: "universe") ?? 0)"
        
        // Cell setup
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "Fixture Universe: " + fixtureUniverse + "\nArtnet Subnet: " + subnet + " Artnet Universe: " + universe
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            calcs.deleteCalc(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier {
//        case "FixtureUniNote":
//            let destination = segue.destination as! FixtureNoteViewController
//            let indexPath = tableView.indexPathForSelectedRow?.row
//            let selectedObject = calcs.getCalc(index: indexPath ?? 0)
//            destination.calc = selectedObject as NSManagedObject
//        default:
//            print("UNKNOWN SEGUE \(segue.identifier ?? "not_sure")")
//        }
//    }

}
