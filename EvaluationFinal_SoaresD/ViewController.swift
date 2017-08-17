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
        //print(obj.lesNotes)
        
         //print(obj.lesNotes[obj.keys[0]]!)
        
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            obj.lesNotes[obj.keys[indexPath.row]] = nil
            obj.parseDict()
            obj.saveUserDefaults()
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if obj.values[indexPath.row]  {
            cell.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
        print(obj.lesNotes)
        let dictionary = obj.lesNotes
        var urlToSend = "http://localhost/dashboard/soares/json_php/add.php?json=["
        //var urlToSend = "http://localhost/dashboard/geneau/poo2/add.php?json=["
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

    }

    
    func replaceChars(originalStr: String, what: String, byWhat: String) -> String {
        return originalStr.replacingOccurrences(of: what, with: byWhat)
    }
    
    //------------------------------------------
    @IBAction func loadButton(_ sender: UIButton) {
        let requestURL: NSURL = NSURL(string: "http://localhost/dashboard/soares/json_php/data.json")!
        //let requestURL: NSURL = NSURL(string: "http://localhost/dashboard/geneau/poo2/data.json")!
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
                    //self.tableView.reloadData()
                    
                }
                    catch {
                    print("Erreur Json: \(error)")
                }
            }
        }
        task.resume()
        obj.saveUserDefaults()
        obj.parseDict()
        
        self.viewDidLoad()
        tableView.reloadData()
        print(obj.lesNotes)
       

    }
  
    
    
    
}
