//
//  BookOffersViewController+TableView.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 19/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import UIKit

extension BookOffersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellBook = tableView.dequeueReusableCell(withIdentifier: CellsID.cellBooksToBuy, for: indexPath) as! BookTableViewCell
        if let list = booksList {
            cellBook.updateGraphicElements(list[indexPath.row])
        }
        
        return cellBook
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  let cell = tableView.cellForRow(at: indexPath) as? BookTableViewCell, let list = booksList {
            let book = list[indexPath.row]
            cell.favImageView.image = (cell.favImageView.image == UIImage(named: favON)) ? UIImage(named: favOff) : UIImage(named: favON)
            showAlertForCurrent(book)
        }
    }
    
    // MARK: - Methods
    func showAlertForCurrent(_ book : Book) {
        // create the alert
        let alert = UIAlertController(title: "Cart", message: book.title, preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Add to Cart", style: .default, handler: { (action) in
            self.updateSelected(book,true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel or Remove", style: .cancel, handler: { (action) in
            self.updateSelected(book,false)
            self.dismiss(animated: true, completion: nil)
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Methods
    func updateSelected(_ book: Book, _ isSelected : Bool) {
        book.update { (bok) in
            bok.selected = isSelected
        }
    }
}

