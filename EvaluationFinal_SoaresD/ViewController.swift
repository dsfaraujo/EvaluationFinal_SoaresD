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
    @IBOutlet weak var tableView: UITableView!
    var obj = ChecklistData()
   
    //-----------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        print(obj.lesNotes)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    //-----------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //-----------------------------------------
    @IBAction func addTaskButton(_ sender: UIButton){
        obj.ajouterUneNote(nom: addTaskField.text!, val: false)
        
        obj.saveUserDefaults()
        obj.parseDict()
        tableView.reloadData()
        resetFields()
        hideKeyboard()
    }
    //-----------------------------------------
    func hideKeyboard() {
        addTaskField.resignFirstResponder()
    }
    //-----------------------------------------
    func resetFields() {
        addTaskField.text = ""
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
        let s = "\(a) "
        cell.textLabel!.text = s
        cell.textLabel?.textColor = UIColor.black
        cell.backgroundColor = UIColor.clear
        return cell
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor.darkGray
        if obj.lesNotes[obj.values[indexPath.row]]!{
             obj.lesNotes[obj.keys[indexPath.row]] = true
        } else {
             obj.lesNotes[obj.keys[indexPath.row]] = false
        }
        tableView.reloadData()
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
    @IBAction func sabeButton(_ sender: UIButton) {
        let dictionary = ["a Key" : "aValue", "other Key" : "otherValue"]
        var urlToSend = "http://localhost/dashboard/geneau/json_php/add.php?json=["
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
    }
  
    
    func replaceChars(originalStr: String, what: String, byWhat: String) -> String {
        return originalStr.replacingOccurrences(of: what, with: byWhat)
    }
    
    //------------------------------------------
    @IBAction func loadButton(_ sender: UIButton) {
        let requestURL: NSURL = NSURL(string: "http://localhost/dashboard/soares/json_php/data.json")!
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
                    let json = try JSONSerialization.jsonObject(with:
                        data!, options:.allowFragments)
                    print(json)
                                      
                    
                }catch {
                    print("Erreur Json: \(error)")
                }
            }
        }
        task.resume()
    }
  
    
    
    
}
