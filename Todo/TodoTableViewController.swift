//
//  TodoTableViewController.swift
//  Todo
//
//  Created by zhuosi777 on 2019/10/30.
//  Copyright © 2019 zhuosi777. All rights reserved.
//

import UIKit
import RealmSwift

class TodoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    @IBAction func didTapAddButton(_ sender: Any) {
        // +ボタンをタップした時に呼ばれます
        let alertController = UIAlertController(title: "Todoを追加しますか？", message: nil, preferredStyle: .alert)
        let action:UIAlertAction = UIAlertAction(title: "追加", style: .default){(void) in
            let textField = alertController.textFields![0] as UITextField
            if let text = textField.text{

                
                let todo = Todo()
                todo.text = text

                let realm = try! Realm()
                try! realm.write {
                    realm.add(todo)
                }
                self.tableView.reloadData()
            }
    }
    let cancel:UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        alertController.addTextField {(TextField)in TextField.placeholder = "Todoの名前を入れてください"}
        alertController.addAction(action)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let realm = try! Realm()
        let todos = realm.objects(Todo.self)
        return todos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let realm = try! Realm()
        let todos = realm.objects(Todo.self)
        
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.text
        // Configure the cell...
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let realm = try! Realm()
            let todos = realm.objects(Todo.self)
            let todo = todos[indexPath.row]
            
            try! realm.write {
                realm.delete(todo)
            }
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
