import Foundation
import UIKit

extension UINavigationBar {
    
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.isHidden = true
    }
    
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.isHidden = false
    }
    
    fileprivate func hairlineImageViewInNavigationBar(_ view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}

extension UIToolbar {
    
    func hideHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(self)
        navigationBarImageView!.isHidden = true
    }
    
    func showHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(self)
        navigationBarImageView!.isHidden = false
    }
    
    fileprivate func hairlineImageViewInToolbar(_ view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInToolbar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}
