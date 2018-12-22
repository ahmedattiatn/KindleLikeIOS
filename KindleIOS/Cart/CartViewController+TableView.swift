//
//  BasketViewController+TableView.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 19/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import UIKit

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellBook = tableView.dequeueReusableCell(withIdentifier: CellsID.cellSelectedBooks, for: indexPath) as! CartTableViewCell
        cellBook.updateGraphicElements(selectedBooksList[indexPath.row])
        return cellBook
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  selectedBooksList.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            selectedBooksList[indexPath.row].update { (bo) in
                bo.selected = false
            }
            selectedBooksList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
        }
    }
}
