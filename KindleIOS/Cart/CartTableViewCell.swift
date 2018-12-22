//
//  BasketTableViewCell.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 19/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var selectedBookCoverImageView: UIImageView!
    @IBOutlet weak var selectedBookTitleLabel: UILabel!
    @IBOutlet weak var selectedBookPrice: UILabel!
    // MARK: - Proprities
    var book : Book?
    
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Methods
    func updateGraphicElements(_ book: Book) {
        if (!book.isInvalidated) {
            self.book = book
            selectedBookTitleLabel.text = book.title
            selectedBookPrice.text = String(book.price) + " €"
            if let urlImage = book.cover, let url = URL(string: urlImage) {
                selectedBookCoverImageView.af_setImage(
                    withURL: url,
                    placeholderImage: UIImage(named: defaultPlaceholder),
                    imageTransition: .crossDissolve(0.2)
                )
            }
        }
    }
}
