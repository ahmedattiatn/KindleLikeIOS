//
//  PaymentByOfferViewController.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 21/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import UIKit

class PaymentByOfferViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var offerTypeLabel: UILabel!
    // MARK: - Proprities
    var selectedOffer : Offer?
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        offerTypeLabel.text = selectedOffer?.type
    }
}
