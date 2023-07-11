//
//  ViewController.swift
//  Store App
//
//  Created by nassermac on 6/1/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import UIKit
import CoreData

class ListVC: UIViewController {
var listOfItems = [Items]()
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        reloadlistOfItems()
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        // Do any additional setup after loading the view.
    }

    @IBAction func addItemBtnTapped(_ sender: UIBarButtonItem) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let itemvc = main.instantiateViewController(withIdentifier: "AddItemVC") as! AddItemVC
        self.navigationController?.pushViewController(itemvc, animated: true)
    }
    func reloadlistOfItems(){
        if let appd = UIApplication.shared.delegate as?AppDelegate{
            let fetchReq:NSFetchRequest<Items> = Items.fetchRequest()
            do{
                listOfItems = try appd.persistentContainer.viewContext.fetch(fetchReq)
                listTableView.reloadData()
            }catch{
                print("error")
            }
        }
    }
    
}

extension ListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ListCell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
      cell.storenameLabel.text = listOfItems[indexPath.row].toStore?.name
        let dateformate = DateFormatter()
        dateformate.dateFormat = "dd/MM/YY h:mm a"
       cell.dateLabel.text = dateformate.string(from: listOfItems[indexPath.row].date!)
        cell.itemNameLabel.text = listOfItems[indexPath.row].name
     cell.imgItem.image = listOfItems[indexPath.row].image as? UIImage
   

        return cell
    }
    
}

