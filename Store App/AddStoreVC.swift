//
//  AddStoreVC.swift
//  Store App
//
//  Created by nassermac on 6/1/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import UIKit

class AddStoreVC: UIViewController {
    
    @IBOutlet weak var storeNameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add Store"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        if let appd = UIApplication.shared.delegate as? AppDelegate{
            let store = StoreType(context: appd.persistentContainer.viewContext)
            store.name = storeNameTextfield.text ?? ""
            do{
                appd.saveContext()
                print("Saved store")
               storeNameTextfield.text = " "
            }catch{
                print("error  ")
                
            }
          
        }
        
    }
    


}
