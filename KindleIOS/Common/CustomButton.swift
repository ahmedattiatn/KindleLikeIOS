//
//  CustomButton.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 20/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//
import Foundation
import UIKit

/* Re-design the UIbutton*/
// MARK: - @IBDesignable
@IBDesignable
public class CustomButton: UIButton {
    
    var originalHeight = CGFloat()
    var originalWidth = CGFloat()
    
    @IBInspectable var animationOn: Bool = true
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
        if animationOn {
            self.addTarget(self,action:#selector(animateDCButton), for:.touchDown)
        }
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    /*****  Animation when Click on the Button  *****/
    
    @objc func animateDCButton() {
        // save the original values for the animation lader
        originalHeight = bounds.size.height
        originalWidth = bounds.size.width
        // Animate
        UIView.animate(withDuration: 0.3, animations: {
            self.animateTodarkerStyle()
        }, completion: { finished in
            self.animateToOriginStyle()
        })
    }
    
    func animateTodarkerStyle() {
        self.bounds.size.height = self.originalHeight * 0.95
        self.bounds.size.width  = self.originalWidth * 0.95
    }
    
    func animateToOriginStyle() {
        bounds.size.height = originalHeight
        bounds.size.width  = originalWidth
    }
    
    /*****  Animation when Click on the Button  *****/
    
    func setUpView() {
        layer.cornerRadius = 0.5 * bounds.size.height
        setTitle(titleLabel?.text?.localizedCapitalized, for: .normal)
        layer.borderWidth = borderWidth
        clipsToBounds = true
    }
    
    public override var isEnabled: Bool {
        didSet {
            self.alpha = isEnabled ? 1 : 0.5
        }
    }
}
