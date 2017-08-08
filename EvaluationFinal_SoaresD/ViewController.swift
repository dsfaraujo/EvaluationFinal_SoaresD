//
//  ViewController.swift
//  EvaluationFinal_SoaresD
//
//  Created by eleves on 2017-07-17.
//  Copyright © 2017 Diana. All rights reserved.
//
//-----------------------------------------
import UIKit
//-----------------------------------------
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //-----------------------------------------
    @IBOutlet weak var addTaskField: UITextField!

    @IBOutlet weak var addDate: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var obj = ChecklistData()
    //-----------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //-----------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //-----------------------------------------
    @IBAction func addTaskButton(_ sender: UIButton){
        obj.ajouterUneNote(nom: addTaskField.text!, date: addDate.text!)
        
        obj.saveUserDefaults()
        obj.parseDict()
        tableView.reloadData()
        resetFields()
        hideKeyboard()
    }
    //-----------------------------------------
    func hideKeyboard() {
        addTaskField.resignFirstResponder()
        addDate.resignFirstResponder()
    }
    //-----------------------------------------
    func resetFields() {
        addTaskField.text = ""
        addDate.text = ""
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = UIColor.clear
        return obj.keys.count
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"proto")
        let a = obj.keys[indexPath.row]
        let b = obj.values[indexPath.row]
        let s = "\(a) : \(b) "
        cell.textLabel!.text = s
        cell.textLabel?.textColor = UIColor.black
        cell.backgroundColor = UIColor.clear
        return cell
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor.darkGray
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            obj.lesNotes[obj.keys[indexPath.row]] = nil
            obj.saveUserDefaults()
            obj.parseDict()
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    //------------------------------------------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //------------------------------------------
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 10 {
            // let theOfset = 900 - UIScreen.main.bounds.size.height
            //scrollView.
        }
    }
    //------------------------------------------
}
