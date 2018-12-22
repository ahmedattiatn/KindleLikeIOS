//
//  OffersViewController.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 20/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import UIKit

class OffersViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var offersTableView: UITableView!
    @IBOutlet weak var reducedPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    // MARK: - Proprities
    var totalPrice : Float = 0
    //Create Activity Indicator
    let loaderIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    // MARK: - View life cycle
    override func viewWillAppear(_ animated: Bool) {
        initOffersLoader()
        updatelBooksOffersFromRemote()
    }
    
    // MARK: - Methods
    func initOffersLoader() {
        // Position Activity Indicator in the center of the main view
        loaderIndicator.center = self.view.center
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        loaderIndicator.hidesWhenStopped = true
        // Start Activity Indicator
        loaderIndicator.startAnimating()
        view.addSubview(loaderIndicator)
    }
    
    func refreshData() {
        loaderIndicator.stopAnimating()
        offersTableView.reloadData()
        oldPriceLabel.text = String(self.totalPrice) + Unit.euro
    }
    
    func getReducedPriceBy(offer: Offer) -> String {
        var newPrice = Float()
        switch offer.type {
        case "minus":
            newPrice = totalPrice - Float(offer.value)
        default:
            newPrice = totalPrice - (Float(Book.offers[0].value) * totalPrice) / 100
        }
        return String(newPrice)
    }
    
    func updatelBooksOffersFromRemote() {
        Book.fetchOffers { (success,error) in
            if success {
                self.refreshData()
                print("Fetching Offers Data With Success...")
            }else{
                if let error = error {
                    print("Failure while Fetching Offers Data ...",error)
                }
            }
            self.loaderIndicator.stopAnimating()
        }
    }
    
    func goToPaymentOrAnimate() {
        if (reducedPriceLabel.text?.contains(Unit.euro))! {
            self.performSegue(withIdentifier: "goToPaymentSegue", sender: Offer.self)
        }
        else {
            reducedPriceLabel.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.9)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.reducedPriceLabel.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.reducedPriceLabel.transform = .identity
            })
        }
        
    }
    
    // MARK: - User Action
    @IBAction func goToPayment(_ sender: Any) {
        goToPaymentOrAnimate()
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToPaymentSegue" {
            if let indexPath = self.offersTableView.indexPathForSelectedRow {
                let controller = segue.destination as! PaymentByOfferViewController
                controller.selectedOffer = Book.offers[indexPath.row]
            }
        }
    }
}
