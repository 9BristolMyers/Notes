//
//  NotesTableViewController.swift
//  Job 3
//
//  Created by Владимир Рузавин on 2/3/22.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }//создали Outlet от кнопки Edit, чтобы могли редактировать ячейки: удалить либо поменять местами
    
    @IBAction func pushAddAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in//после фигурной скобки идёт блок кода, который будет выполняться по нажатию кнопки;в круглых скобках – новая переменная с любым названием
            textField.placeholder = "New item name"
        }
        
        let alertAction1 = UIAlertAction(title: "Cansel", style: .default) { (alert) in//кнопка отмены действия
            
        }
        
        let alertAction2 = UIAlertAction(title: "Create", style: .cancel) { (alert) in//кнопка создания новой ячейки
            //добавляем новую запись
            let newItem = alertController.textFields![0].text
            addItem(nameItem: newItem!, isCompleted: false)
            
            self.tableView.reloadData()
        }
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Notes.count//количество строк равно количеству записей в массиве
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let currentItem = Notes[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String//значению "text" присвоили значения из словаря
        
        if (currentItem["isCompleted"] as? Bool) == true {//установили возможность отметить галочкой заметку программным путём 
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true//можем редактировать ячейку по этому методу
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {//если удалили ячейку, товызывается этот метод
        if editingStyle == .delete {//стиль удаления, когда смахиваешь влево и появляется красная полоса
            removeItem(at: indexPath.row)//удалили элемент, который удалил пользователь, чтобы избежать программной ошибки
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)//ячейка плавно погаснет
        
        changeState(at: indexPath.row)//вызываем метод нашей модели
        
        tableView.reloadData()//обновляем таблицу, чтобы всё заработало в симуляторе
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {//позволяет менять местами ячейки
        
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        
        tableView.reloadData()//обновляем данные
    }
    

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
