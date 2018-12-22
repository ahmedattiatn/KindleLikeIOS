//
//  Books.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 19/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import Foundation
import RealmSwift

class Book: Object {
    @objc dynamic var id: String!
    @objc dynamic var title: String?
    @objc dynamic var price: Float = 0.0
    @objc dynamic var selected: Bool = false
    @objc dynamic var cover: String?
    var synopsis = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    static var offers = [Offer]()
}


struct Offer {
    var type: String
    var value: Int
    var subType: Int
    init(_ dictionary: [String: Any]) {
        self.type = dictionary["type"] as? String ?? ""
        self.value = dictionary["value"] as? Int ?? 0
        self.subType = dictionary["sliceValue"] as? Int ?? 0
    }
}

