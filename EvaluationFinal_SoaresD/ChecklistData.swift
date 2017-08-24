//
//  ChecklistData.swift
//  EvaluationFinal_SoaresD
//
//  Created by eleves on 2017-07-18.
//  Copyright © 2017 Diana. All rights reserved.
//
//-----------------------------------------
import UIKit
//-----------------------------------------
class ChecklistData {
//------------------------------------------
var lesNotes: [String : Bool] = ["a" : false]
var keys: [String] = []
var values: [Bool] = []
var userDefaults = UserDefaults.standard
//------------------------------------------
init() {
    manageUserDefaults()
    parseDict()
}
//------------------------------------------
func manageUserDefaults() {
    
    if let savedData = userDefaults.object(forKey: "data"){
        lesNotes = savedData as! [String : Bool]
    }
    else{
        userDefaults.set(lesNotes, forKey: "data")
    }
}
//------------------------------------------
func saveUserDefaults(){
    userDefaults.set(lesNotes, forKey: "data")
}
//------------------------------------------
func ajouterUneNote(nom: String, val: Bool) {
    lesNotes[nom] = val
}
//------------------------------------------
func parseDict() {
    keys = []
    values = []
    for (a, b) in lesNotes {
        keys.append(a)
        values.append(b)
    }
}
//------------------------------------------
    
    func resetData() {
             
       
        parseDict()
        manageUserDefaults()
        saveUserDefaults()
        
    }
}
