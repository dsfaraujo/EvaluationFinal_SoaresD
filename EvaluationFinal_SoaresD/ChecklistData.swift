//
//  ChecklistData.swift
//  EvaluationFinal_SoaresD
//
//  Created by eleves on 2017-07-18.
//  Copyright © 2017 Diana. All rights reserved.
//
//-----------------------------------------
import UIKit
//Classe pour le user defaults
//-----------------------------------------
class ChecklistData {
    //------------------------------------------
    var lesNotes: [String : Bool] = ["a" : false]
    var keys: [String] = []
    var values: [Bool] = []
    var userDefaults = UserDefaults.standard
    //------------------------------------------
    //constructeur
    init() {
        manageUserDefaults()
        parseDict()
    }
    //------------------------------------------
    //function pour le managment des user defaults
    func manageUserDefaults() {
        
        if let savedData = userDefaults.object(forKey: "data"){
            lesNotes = savedData as! [String : Bool]
        }
        else{
            userDefaults.set(lesNotes, forKey: "data")
        }
    }
    //------------------------------------------
    //function pour sauvegarder user defaults
    func saveUserDefaults(){
        userDefaults.set(lesNotes, forKey: "data")
    }
    //------------------------------------------
    //function pour ajouter des notes dans le dictionnaire
    func ajouterUneNote(nom: String, val: Bool) {
        lesNotes[nom] = val
    }
    //------------------------------------------
    //function pour ajouter les valeurs dans le dictionnaire
    func parseDict() {
        keys = []
        values = []
        for (a, b) in lesNotes {
            keys.append(a)
            values.append(b)
        }
    }
    //------------------------------------------
    //function pour reseter les données
    func resetData() {
        parseDict()
        manageUserDefaults()
        saveUserDefaults()
        
    }
}
