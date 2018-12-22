//
//  OffersTableViewCell.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 20/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import UIKit

class OffersTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var offerTypeLabel: UILabel!
    @IBOutlet weak var offerValueLabel: UILabel!
    // MARK: - Proprities
    let animatedY :CGFloat = 30
    
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        animateOffersCellElementWith(yVal: animatedY)
        // Initialization code
    }
    
    override func prepareForReuse() {
        animateOffersCellElementWith(yVal: animatedY)
    }
    
    // MARK: - Methods
    func updateGraphicElementsOfOffer(_ offer: Offer) {
        let CustomOffer = offer.type + " with value : " + String(offer.subType)
        offerTypeLabel.text = (offer.subType > 0) ? CustomOffer : offer.type
        offerValueLabel.text = String(offer.value)
    }
    
    func animateOffersCellElementWith(yVal:CGFloat) {
        offerTypeLabel.frame.origin.y -= yVal
        offerValueLabel.frame.origin.y -= yVal
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
            self.offerTypeLabel.frame.origin.y += yVal
            self.offerValueLabel.frame.origin.y += yVal
            
        })
    }
}
