//
//  FixtureNotesViewController.swift
//  artnet-app
//
//  Created by Maegan Wilson on 7/22/18.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

// protocol for sending calculation back

protocol NotesEnteredDelegate: class {
    func addNotes(calc: Calc, index: Int)
}

class FixtureNotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var fixtureNoteTableView: UITableView!
    @IBOutlet weak var fixtureUni: UILabel!
    
    var calc = Calc(universe: "1", artsub: "0", artuni: "1", note: [])
    var index = 0
    
    var delegate: NotesEnteredDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fixtureUni.text = "\(calc.universe)"
        
        fixtureNoteTableView.delegate = self
        fixtureNoteTableView.dataSource = self
        
        fixtureNoteTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @IBAction func addNote(_ sender: Any) {
        let alertController = UIAlertController(title: "Add new note", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!)-> Void in
            textField.placeholder = "Enter note here"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let text = firstTextField.text
            
            self.calc.note.insert("\(text ?? "")", at: 0)
            self.delegate?.addNotes(calc: self.calc, index: self.index)
            self.fixtureNoteTableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(action : UIAlertAction!)-> Void in})
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calc.note.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        let row = indexPath.row
        
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = calc.note[row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.calc.note.remove(at: indexPath.row)
            self.delegate?.addNotes(calc: calc, index: index)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
