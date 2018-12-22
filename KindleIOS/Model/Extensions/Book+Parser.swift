//
//  Books+Parser.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 19/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Book {
    static func parseAndUpdateBookObject(_ inObject : JSON?) -> Book? {
        if inObject == nil || inObject?.count == 0 {
            return nil
        }
        let book = Book()
        book.id = inObject!["isbn"].stringValue
        book.title = inObject!["title"].stringValue
        book.price = inObject!["price"].floatValue
        for syn in inObject!["synopsis"].arrayValue {
            book.synopsis.append(syn.stringValue)
        }
        book.cover = inObject!["cover"].stringValue
        if let existingBook = loadBookBy(id: book.id) {
            book.selected = (existingBook.selected)
        }
        return book
    }
}
