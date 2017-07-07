//
//  ViewController.swift
//  CoreDataTutorais
//
//  Created by mac on 07/07/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var txt_firstname: UITextField!

    @IBOutlet weak var txt_lastname: UITextField!
    
    @IBOutlet weak var txt_Searchuser: UITextField!
    
    @IBOutlet weak var lbl_ShowSearchResult: UILabel!
    
    var userArray:[Users] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    @IBAction func btn_SaveUser(_ sender: Any) {
        if txt_firstname.text != "" && txt_lastname.text != ""{
            let newuser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            newuser.setValue(txt_firstname.text!, forKey: "firstname")
            newuser.setValue(txt_lastname.text, forKey: "lastname")
            
            //save data into CoreData
            do
            {
                try context.save()
            }
            catch
            {
                print(error)
            }
        }
        else
        {
            print("Please enter firstname and lastname firstly!")
        }
        self.txt_lastname.text = ""
        self.txt_firstname.text = ""
    }
    
    @IBAction func btn_SearchUser(_ sender: Any) {
    
    }
    
    @IBAction func btn_ShowSaveUsers(_ sender: Any) {
    }
    
    
}

