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
class ViewController: UIViewController {
    //-----------------------------------------
    @IBOutlet weak var addTaskField: UITextField!
    @IBOutlet weak var tableTask: UITableView!
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
    @IBAction func addTaskButton(_ sender: UIButton) {
        obj.addList(toDo: addTaskField.text!)
        obj.saveUserDefaults()
        tableTask.reloadData()
        resetFields()
        
        
    }
    //-----------------------------------------
    func resetFields() {
        addTaskField.text = ""
    }
    

}

