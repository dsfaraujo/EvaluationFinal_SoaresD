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
var lesNotes: [String : [String]] = ["zzz": ["aaa", "bbbb"]]
var keys: [String] = []
var values: [String] = []
var userDefaults = UserDefaults.standard
//------------------------------------------
init() {
    manageUserDefaults()
    parseDict()
}
//------------------------------------------
func manageUserDefaults() {
    if let savedData = userDefaults.object(forKey: "data"){
        lesNotes = savedData as! [String : [String]]
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
func ajouterUneNote(nom: String, date: String) {
    lesNotes["data"] = [nom, date]
}
//------------------------------------------
func parseDict() {
    keys = []
    values = []
    for (a, b) in lesNotes {
        keys.append(a)
        values.append(b[0])
    }
}
//------------------------------------------
}
