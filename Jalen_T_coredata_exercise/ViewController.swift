//
//  ViewController.swift
//  Jalen_T_coredata_exercise
//
//  Created by Jalen Taylor on 8/12/20.
//  Copyright © 2020 Jalen Taylor. All rights reserved.
//

import UIKit
import Foundation
import CoreData



class ViewController: UIViewController {
    var DataManager : NSManagedObjectContext!
    var listArrary = [NSManagedObject]()
    
    
    
    @IBAction func savebutton(_ sender: UIButton) {
        let newEntity = NSEntityDescription.insertNewObject(forEntityName:"Item", into:DataManager)
        newEntity.setValue(descriptions.text!, forKey: "about")
        do{
            try self.DataManager.save()
            listArrary.append(newEntity)
        }catch {
            print("Error saving data")
        }
        display.text?.removeAll()
        descriptions.text?.removeAll()
        fetchData()
  
    }
    
    
    @IBAction func deletebutton(_ sender: UIButton) {
        let delete = descriptions.text!
        for item in listArrary {
            if item.value(forKey:"about") as! String == delete{
            DataManager.delete(item)
        }
        do {
            try self.DataManager.save()
        } catch {
            print ( "Error deleting data")
        }
        display.text?.removeAll()
        descriptions.text?.removeAll()
        fetchData()
    
    }
    
}
    
    @IBOutlet var descriptions: UITextField!
    
   
    
    
    
    @IBOutlet var display: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let AppDelegate = UIApplication.shared.delegate as! AppDelegate
        DataManager = AppDelegate.persistentContainer.viewContext
        display.text?.removeAll()
        fetchData()
    }
    func fetchData() {
        let fetchrequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        do {
            let result = try DataManager.fetch(fetchrequest)
            listArrary = result as! [NSManagedObject]
            for item in listArrary {
                
                let product = item.value(forKey: "about") as! String
                display.text! += product
            }
        } catch {
            print("Error retrieving data")
        }

}
}
