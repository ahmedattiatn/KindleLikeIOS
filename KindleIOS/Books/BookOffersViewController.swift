//
//  ViewController.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 19/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import UIKit
import RealmSwift

class BookOffersViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var booksTable: UITableView!
    // MARK: - Proprities
    let favON = "fav-ON"
    let favOff = "fav"
    lazy var booksList: Results<Book>? = {
        Book.loadAllBooks()
    }()
    //Create Activity Indicator
    let loaderIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoader()
        updatelBooksFromRemote()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - Methods
    func updatelBooksFromRemote() {
        Book.fetchBooks { (success,error) in
            if success {
                print("Fetching Books Data With Success...")
                self.loaderIndicator.stopAnimating()
                self.booksTable.reloadData()
            }else{
                if let error = error {
                    print("Failure while Fetching Books Data ...",error)
                }
            }
        }
    }
    
    // MARK: - Methods
    func initLoader() {
        // Position Activity Indicator in the center of the main view
        loaderIndicator.center = self.view.center
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        loaderIndicator.hidesWhenStopped = true
        // Start Activity Indicator
        loaderIndicator.startAnimating()
        view.addSubview(loaderIndicator)
    }
    
}
