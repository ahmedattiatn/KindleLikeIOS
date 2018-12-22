//
//  Books+DataAcces.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 19/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

extension Book  {
    static func loadAllBooks() -> Results<Book> {
        let realm = try! Realm()
        let list = realm.objects(Book.self)
        return list
    }
    
    static func loadSelectedBooks() -> Results<Book> {
        let realm = try! Realm()
        let books = realm.objects(Book.self).filter("selected == true")
        return books
    }
    
    static func loadBookBy(id: String) -> Book? {
        let realm = try! Realm()
        let books = realm.objects(Book.self).filter("id = %@", id)
        return books.first
    }
    
    func update(_ book: (Book) -> Void) {
        let bok = Book.init(value: self)
        book(bok)
        let realm = try! Realm()
        try! realm.write {
            realm.create(Book.self, value: bok, update: true)
        }
    }
    
    static func updateBooksFrom(_ results: JSON, completion: @escaping (SaveCompletion) -> Void) {
        // Insert from Data containing JSON
        if results.count > 0 {
            if let books = results.array {
                let realm = try! Realm()
                try! realm.write {
                    for bookJSON in books {
                        let book = Book.parseAndUpdateBookObject(bookJSON)
                        if let _ = book {
                            realm.add(book!, update: true)
                        }
                    }
                    completion(SaveCompletion(true, error: nil))
                }
            }
        }
    }
    
    static func updateOffersFrom(_ results: JSON, completion: @escaping (SaveCompletion) -> Void) {
        guard  let responseJSON = JSON(results)["offers"].arrayObject else {
            completion(SaveCompletion(false, ErrorStatus.none))
            return
        }
        Book.offers.removeAll()
        for offer in responseJSON {
            Book.offers.append(Offer(offer as! [String : Any]))
        }
        completion(SaveCompletion(true, error: nil))
    }
}


