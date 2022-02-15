//
//  Model.swift
//  Job 3
//
//  Created by Владимир Рузавин on 2/3/22.
//

import Foundation

var Notes: [[String: Any]] = [["Name": "Call Mom", "isCompleted": true], ["Name": "Complete a list", "isCompleted": false], ["Name": "Go for a walk", "isCompleted": true], ["Name": "Find a job", "isCompleted": false]]

func addItem(nameItem: String, isCompleted: Bool) {
    Notes.append(["Name": nameItem, "isCompleted": false])
    saveData()
}

func removeItem (at index: Int) {//удалять и определять элементы массива по их индексу
    Notes.remove(at: index)
    saveData()
}

func moveItem(fromIndex: Int, toIndex: Int) {
    let from = Notes[fromIndex]//взяли наш массив элементов
    Notes.remove(at: fromIndex)//удаляем элемент по индексу
    Notes.insert(from, at: toIndex)//добавляем элемент по индексу в другом месте
}

func changeState(at item: Int) {
    Notes[item]["isCompleted"] = !(Notes[item]["isCompleted"] as! Bool)//убираем или ставим галочку
    saveData()
}

func saveData() {
    UserDefaults.standard.set(Notes, forKey: "NotesDataKey")
    UserDefaults.standard.synchronize()//сохраняем данные
}

func loadData() {
    if let array = UserDefaults.standard.array(forKey: "NotesDataKey") as? [[String: Any]] {
        Notes = array
    } else {
        Notes = []
    }
}
