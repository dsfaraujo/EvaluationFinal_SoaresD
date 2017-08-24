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
//classe pour le viewController
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    //-----------------------------------------
    @IBOutlet weak var addTaskField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var obj = ChecklistData()
    //-----------------------------------------
    //load view principale
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.addTaskField.delegate = self
    }
    //-----------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //-----------------------------------------
    //button d'ajouter une note
    @IBAction func addTaskButton(_ sender: UIButton){
        obj.ajouterUneNote(nom: addTaskField.text!, val: false)
        
        obj.saveUserDefaults()
        obj.parseDict()
        tableView.reloadData()
        resetFields()
        hideKeyboard()
    }
    //-----------------------------------------
    //cacher clavier
    func hideKeyboard() {
        addTaskField.resignFirstResponder()
    }
    //-----------------------------------------
    //effacer texte dans textField
    func resetFields() {
        addTaskField.text = ""
    }
    
    //------------------------------------------
    //Function d'initialization de la tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = UIColor.clear
        return obj.keys.count
    }
    //------------------------------------------
    //Function d'initialization des celules dans la tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"proto")
        let a = obj.keys[indexPath.row]
        _ = obj.values[indexPath.row]
        let s = "\(a) "
        cell.textLabel!.text = s
        cell.textLabel?.textColor = UIColor.black
        cell.backgroundColor = UIColor.clear
        return cell
    }
    //------------------------------------------
    //Function pour permetre de selectionner une rangée dans la tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor.darkGray
        if obj.lesNotes[obj.keys[indexPath.row]]! == false{
            obj.lesNotes[obj.keys[indexPath.row]] = true
            //print(obj.lesNotes[obj.keys[indexPath.row]])
        } else {
            obj.lesNotes[obj.keys[indexPath.row]] = false
        }
        obj.parseDict()
        print(obj.values)
        obj.saveUserDefaults()
        tableView.reloadData()
    }
    //------------------------------------------
    //Function d'initialization de le style de la tableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            obj.lesNotes[obj.keys[indexPath.row]] = nil
            obj.parseDict()
            obj.saveUserDefaults()
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    //-----------------------------------------
    ////Function d'initialization des couleures pour las rangées selectionées dans la tableView
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if obj.values[indexPath.row]  {
            cell.backgroundColor = UIColor(red: 0.3, green: 1.0, blue: 0.4, alpha: 0.8)
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
    //Button pour sauvegarder le fishier php
    @IBAction func sabeButton(_ sender: UIButton) {
        print(obj.lesNotes)
        let dictionary = obj.lesNotes
        //var urlToSend = "http://localhost/dashboard/soares/json_php/add.php?json=["
        var urlToSend = "http://localhost/dashboard/geneau/poo2/add.php?json=["
        var counter = 0
        
        let total = dictionary.count
        for (a, b) in dictionary {
            let noSpaces = replaceChars(originalStr: a, what: " ", byWhat: "_")
            counter += 1
            if counter < total {
                urlToSend += "/\(noSpaces)/,/\(b)/!"
            } else {
                urlToSend += "/\(noSpaces)/,/\(b)/"
            }
        }
        urlToSend += "]"
        let session = URLSession.shared
        let urlString = urlToSend
        let url = NSURL(string: urlString)
        let request = NSURLRequest(url: url! as URL)
        let dataTask = session.dataTask(with: request as URLRequest) {
            (data:Data?, response:URLResponse?, error:Error?) -> Void in
        }
        dataTask.resume()
        obj.saveUserDefaults()
        obj.parseDict()
        // create the alert
        let alert = UIAlertController(title: "Saved", message: "Your tasks were successfully saved", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func replaceChars(originalStr: String, what: String, byWhat: String) -> String {
        return originalStr.replacingOccurrences(of: what, with: byWhat)
    }
    //------------------------------------------
    //load json dans l'application
    @IBAction func loadButton(_ sender: UIButton) {
        //let requestURL: NSURL = NSURL(string: "http://localhost/dashboard/soares/json_php/data.json")!
        let requestURL: NSURL = NSURL(string: "http://localhost/dashboard/geneau/poo2/data.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url:
            requestURL as URL)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Tout fonctionne correctement...")
                do{
                    var json: Any? = nil
                    json = try JSONSerialization.jsonObject(with:
                        data!, options:.allowFragments)
                   // print(json)
                    var dict : [String: Bool] = [ : ]
                    var keys: [String] = []
                    var values: [Bool] = []
                    for (k, v) in json as! [String : String] {
                        keys.append(k)
                        if v == "false"{
                            values.append(false)
                        }
                        else{
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
                    print(dict)
                    self.obj.lesNotes = dict
                    
                    self.obj.saveUserDefaults()
                    self.obj.parseDict()
                    self.tableView.reloadData()
                    self.resetFields()
                }
                    
                    
                catch {
                    print("Erreur Json: \(error)")
                }
            }
        }
        task.resume()
        //print(obj.lesNotes)
    }
    //-----------------------------------------
    //Reset button action
    @IBAction func resetButton(_ sender: UIButton) {
        
        let refreshAlert = UIAlertController(title: "Reset Data", message: "Are you sure you want to reset all selections?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            var dict : [String: Bool] = [ : ]
            var keys: [String] = []
            var values: [Bool] = []
            for (k, v) in self.obj.lesNotes {
                keys.append(k)
                if v == false{
                    values.append(false)
                }
                else{
                    values.append(false)
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
            print(dict)
            self.obj.lesNotes = dict
            
            self.obj.saveUserDefaults()
            self.obj.parseDict()
            self.tableView.reloadData()
            self.resetFields()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    //-----------------------------------------
}
