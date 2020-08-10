//
//  UIVIew.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 04.08.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit
extension UIView {
    
    var loadingIndicator: UIActivityIndicatorView? {
        get {
            return self.viewWithTag(9999) as? UIActivityIndicatorView
        }
    }
    
    func loadingIndicator(_ show: Bool, style: UIActivityIndicatorView.Style = .large) {
        
        if show {
            
            let viewHeight = self.bounds.size.height
            let viewWidth = self.bounds.size.width
            let indicator = (self.viewWithTag(9999) as? UIActivityIndicatorView) ?? UIActivityIndicatorView(style: style)
            indicator.center = CGPoint(x: viewWidth/2, y: viewHeight/2)
            indicator.tag = 9999
            
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            if let indicator = self.loadingIndicator {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
    func addShadow(_ color: UIColor, radius: CGFloat = 0.0, offset: CGSize = .zero) {
         self.layer.shadowOpacity = 1
         self.layer.shadowColor = color.cgColor
         self.layer.shadowOffset = offset
         self.layer.shadowRadius = radius
            self.clipsToBounds = false
         self.layer.masksToBounds = false
     }
}
