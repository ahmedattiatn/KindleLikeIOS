//
//  BookTableViewCell.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 20/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import UIKit
import AlamofireImage

var defaultPlaceholder = "info-example"

class BookTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var bookPrice: UILabel!
    @IBOutlet weak var favImageView: UIImageView!
    // MARK: - Proprities
    let animatedX :CGFloat = 30
    
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        animateBookCellElementWith(xVal: animatedX)
        // Initialization code
    }
    
    override func prepareForReuse() {
        animateBookCellElementWith(xVal: animatedX)
    }
    
    // MARK: - Methods
    func updateGraphicElements(_ book: Book) {
        if (!book.isInvalidated) {
            bookTitleLabel.text = book.title
            bookDescriptionLabel.text = book.synopsis.first
            bookPrice.text = String(book.price) + Unit.euro
            if let urlImage = book.cover, let url = URL(string: urlImage) {
                bookCoverImageView.af_setImage(
                    withURL: url,
                    placeholderImage: UIImage(named: defaultPlaceholder),
                    imageTransition: .crossDissolve(0.2)
                )
            }
        }
    }
    
    func animateBookCellElementWith(xVal:CGFloat) {
        bookPrice.center.x += xVal
        favImageView.center.x += xVal
        bookTitleLabel.center.x -= xVal
        bookDescriptionLabel.center.x -= xVal
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
            self.bookPrice.frame.origin.x -= xVal
            self.favImageView.frame.origin.x -= xVal
            self.bookTitleLabel.frame.origin.x += xVal
            self.bookDescriptionLabel.frame.origin.x += xVal
            
        })
    }
}
