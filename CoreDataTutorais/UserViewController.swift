//
//  UserViewController.swift
//  CoreDataTutorais
//
//  Created by mac on 07/07/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import CoreData

class UserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblview_TableView: UITableView!
    
    var userArray:[Users] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tblview_TableView.delegate = self
        tblview_TableView.dataSource = self
        self.tblview_TableView.reloadData()
    }
    
    //MARK:- Table view Datat Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let name = userArray[indexPath.row]
        cell.textLabel?.text = name.firstname! + " " + name.lastname!
        return cell
    }

    public func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    //MARK:- Delegate method (Delete cell to swip right to left)

     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     
        if editingStyle == .delete {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let name = userArray[indexPath.row]
            context.delete(name)
            fetchData()
        }
        tblview_TableView.reloadData()
     }
    
    
    //MARK:- Creat fucntion for fetching data from CoreData
    func fetchData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            userArray = try context.fetch(Users.fetchRequest())            
        }
        catch
        {
            print(error)
        }
    }
}
