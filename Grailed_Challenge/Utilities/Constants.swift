//
//  Constants.swift
//  Grailed_Challenge
//
//  Created by Antonio Chan on 2018/11/5.
//  Copyright © 2018 Antonio Chan. All rights reserved.
//

import Foundation
import UIKit
import Lottie

typealias CompletionHandler = (_ Success: Bool) -> ()

struct font {
    static let DidotBold = "Didot-Bold"
}

extension UIViewController {
    //displays loading spinner over the UIViewController
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.35)
        
        let animationView = LOTAnimationView(name: "Loader")
        animationView.frame = CGRect(x:0, y: 0, width:60, height:60)
        animationView.center = spinnerView.center
        animationView.loopAnimation = true
        animationView.contentMode = .scaleAspectFill
        
        animationView.play()
        
        DispatchQueue.main.async {
            spinnerView.addSubview(animationView)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    //removes the spinnerView from the superview 
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
