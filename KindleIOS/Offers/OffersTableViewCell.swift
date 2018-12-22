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
    
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Methods
    func updateGraphicElementsOfOffer(_ offer: Offer) {
        let CustomOffer = offer.type + " with value : " + String(offer.subType)
        offerTypeLabel.text = (offer.subType > 0) ? CustomOffer : offer.type
        offerValueLabel.text = String(offer.value)
    }
}
