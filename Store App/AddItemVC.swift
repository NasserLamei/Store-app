//
//  AddItemVC.swift
//  Store App
//
//  Created by nassermac on 6/1/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import UIKit
import CoreData

class AddItemVC: UIViewController {
    var listOfStoreies = [StoreType]()
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var storePickerView: UIPickerView!
    var imagePicker = UIImagePickerController()
    
    let storeBtn = UIBarButtonItem(title: "Add store", style: .done, target:self, action:#selector(addStoreBtn))
    let saveBtn = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveItem))
    override func viewDidLoad() {
        loadStore()
        storePickerView.delegate = self
        storePickerView.dataSource = self
        super.viewDidLoad()
        self.navigationItem.title = "Add Item"
        self.navigationItem.rightBarButtonItems = [saveBtn,storeBtn]
        storeBtn.action = #selector(addStoreBtn)
        storeBtn.target = self
        saveBtn.action = #selector(saveItem)
        saveBtn.target = self
        saveBtn.tintColor = UIColor.red
          imagePicker.delegate = self
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            itemImage.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
 // buttons
    @IBAction func imageBtn(_ sender: UIButton) {
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func addStoreBtn(){
    let main = UIStoryboard(name: "Main", bundle: nil)
    let store = main.instantiateViewController(withIdentifier: "AddStoreVC") as! AddStoreVC
    self.navigationController?.pushViewController(store, animated: true)
    }
    @objc func saveItem(){
        if let appd = UIApplication.shared.delegate as? AppDelegate{
            let item = Items(context: appd.persistentContainer.viewContext)
            item.name = itemNameTextField.text ?? ""
            item.image = itemImage.image
            item.date = Date()
            item.toStore = listOfStoreies[storePickerView.selectedRow(inComponent: 0)]
            do{
                appd.saveContext()
                print("Saved Item")
                itemNameTextField.text = ""
            } catch {
                print("error")}
        
        }
        
    }
//    func appd()-> NSManagedObjectContext?{
//        guard let appd = UIApplication.shared.delegate as? AppDelegate else { return nil}
//        return appd.persistentContainer.viewContext
//    }
////
//
//    func save (entityName:String){
//        let context = appd()!
//        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
//        let managed = NSManagedObject(entity: entity!, insertInto: context)
//    }


}
extension AddItemVC:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfStoreies.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = listOfStoreies[row]
        return store.name
        
    }
    
}
extension AddItemVC{
    func loadStore(){
        if let appd = UIApplication.shared.delegate as? AppDelegate{
            let fetch:NSFetchRequest<StoreType> = StoreType.fetchRequest()
            do{
                listOfStoreies = try appd.persistentContainer.viewContext.fetch(fetch)
               // storePickerView.reloadAllComponents()
                
            }catch{
                print("error")
            }
        }
    }
    
}
    extension AddItemVC:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
     
}


extension AddItemVC{
 
    
    }


