//
//  OffersViewController+TableView.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 20/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import UIKit

extension OffersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellBook = tableView.dequeueReusableCell(withIdentifier: CellsID.cellBooksOffers, for: indexPath) as! OffersTableViewCell
        cellBook.updateGraphicElementsOfOffer(Book.offers[indexPath.row])
        return cellBook
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  Book.offers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let booksOffers = Book.offers[indexPath.row]
        reducedPriceLabel.text = getReducedPriceBy(offer: booksOffers) + Unit.euro
    }
}
