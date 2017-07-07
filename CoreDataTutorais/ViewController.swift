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
    
    @IBOutlet weak var lbl_dataSaveMessage: UILabel!
   
    
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
                self.txt_lastname.text = ""
                self.txt_firstname.text = ""
                self.lbl_dataSaveMessage.textColor = UIColor.green
                self.lbl_dataSaveMessage.text = "Data Save Successfully!"
            }
            catch
            {
                print(error)
            }
        }
        else
        {
            self.lbl_dataSaveMessage.textColor = UIColor.red
            self.lbl_dataSaveMessage.text = "Please Enter first and last NAME !"
        }

    }
    
    @IBAction func btn_SearchUser(_ sender: Any) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let request :NSFetchRequest<Users> = Users.fetchRequest()
        request.entity = entityDescription
        let searchName =  NSPredicate(format: "(firstname = %@)", txt_Searchuser.text!)
        request.predicate = searchName
        do
        {
            var results = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            if results.count > 0 {
                let matchingName = results[0] as! NSManagedObject
                let fn = matchingName.value(forKey: "firstname") as! String?
                let ln = matchingName.value(forKey: "lastname") as! String?
                lbl_ShowSearchResult.text = "Welcome \(fn!) \(ln!)!"
            }
            else{
                lbl_ShowSearchResult.text = "Not found"
            }
        }
        catch
        {
            print("notfound")
        }
    
    }
    
    @IBAction func btn_ShowSaveUsers(_ sender: Any) {
    }
    
    
}

