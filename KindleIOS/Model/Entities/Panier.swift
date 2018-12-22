//
//  Panier.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 19/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import Foundation
import RealmSwift

class Panier: Object {
    @objc dynamic var byedBookId: string!
    // in Case will buy more than a book
    @objc dynamic var quantite: Int = 0
}
