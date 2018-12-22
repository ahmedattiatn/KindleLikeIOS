//
//  BasketViewController.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 19/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import UIKit
import RealmSwift

class CartViewController: UIViewController {
    // MARK: - Proprities
    lazy var selectedBooksList: Array = {
        Array(Book.loadSelectedBooks())
    }()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        // Do any additional setup after loading the view.
    }
    
    // MARK: - User Action
    @IBAction func goToOfffers(_ sender: Any) {
        if selectedBooksList.count > 0 {
            self.performSegue(withIdentifier: "goToOffersSegue", sender: Int.self)
        }
    }
    
    // MARK: - Methods
    func getTotalPrice() -> Float {
        var total : Float = 0
        for selBook in selectedBooksList {
            total += selBook.price
        }
        return total
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToOffersSegue" {
            let controller = segue.destination as! OffersViewController
            controller.totalPrice = getTotalPrice()
        }
    }
}

