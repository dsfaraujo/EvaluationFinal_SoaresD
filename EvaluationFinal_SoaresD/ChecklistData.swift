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
    //-----------------------------------------
    var list: [String] = []
    var userDefaults = UserDefaults.standard
    //-----------------------------------------
    init() {
       manageUserDefaults()
    }
    //-----------------------------------------
    func manageUserDefaults(){
        if let savedData = userDefaults.object(forKey: "data"){
            list = [savedData as! String]
        }
        else{
            userDefaults.set(list, forKey: "data")
        }
    }
    //------------------------------------------
    func saveUserDefaults(){
        userDefaults.set(list, forKey: "data")
    }
    //------------------------------------------
    func addList(toDo: String){
        list += [toDo]
    }
}
