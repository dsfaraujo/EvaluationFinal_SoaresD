//
//  ViewControllerList.swift
//  EvaluationFinal_SoaresD
//
//  Created by eleves on 2017-08-10.
//  Copyright © 2017 Diana. All rights reserved.
//

import UIKit

class ViewControllerList: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var dict : [String: Bool] = [ : ]
    var keys: [String] = []
    var values: [Bool] = []
    
    @IBOutlet weak var tableView: UITableView!
    var obj = ChecklistData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (k, v) in self.obj.lesNotes {
            //keys.append(k)
            if v == true{
                keys.append(k)
                values.append(true)
            }
            
            
        }
        var index = 0
        for key in keys {
            for _ in values{
                dict[key] = values[index]
            }
            self.obj.ajouterUneNote(nom: key, val: false)
            index+=1
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    //-----------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = UIColor.clear
        return dict.count
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"proto")
        //let a = obj.keys[indexPath.row]
        //let b = obj.values[indexPath.row]
        cell.textLabel?.text = Array(dict.keys)[indexPath.row]
        
        return cell
    }
    //---------------------
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor.darkGray
        if obj.lesNotes[obj.keys[indexPath.row]]! == true {
            print(obj.values)
        }
     
        tableView.reloadData()
    }*/
    //------------------------------------------
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            obj.lesNotes[obj.keys[indexPath.row]] = nil
            obj.saveUserDefaults()
            obj.parseDict()
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
            
        }
    }
    
}
