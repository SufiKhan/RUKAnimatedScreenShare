//
//  RUKShareView.swift
//  RUKAnimatedScreenShare
//
//  Created by Sierra Solutions Mac User 5 on 13/1/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import UIKit
enum NETWORKS : Int {
    case FACEBOOK = 0
    case WHATSAPP
    case TWITTER
    case EMAIL
}
class RUKShareView: UIView {
    typealias CompletionBlock = (Int?) -> Void
    var completion : CompletionBlock?
    var shareSubMenu : UICollectionView?
    var input: RUKAnimationProtocol?
    var slidingDelegate : RUKShareViewSliding?
    var networksIcons: [String]?
    var networksNames: [String]?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        input = self
    }
}

//MARK: Animations
extension RUKShareView{
    func showShareOptions(networkIcons:[String],networkNames:[String],_completion:@escaping CompletionBlock){
        self.networksIcons = networkIcons
        self.networksNames = networkNames
        input?.show(_completion: _completion)
    }
    
    func hideShareOptions(){
        input?.hide()
    }

    func getShareSubMenu(){
        shareSubMenu = RUKShareSubMenu.instance.getSubMenu(view: self.superview!)
        self.superview?.addSubview(shareSubMenu!)
        RUKShareSubMenu.instance.output  = self
    }
    
    func removeShareSubMenu(){
        self.shareSubMenu?.removeFromSuperview()

    }
    func addBlur(){
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.alpha = 0.5
            blurEffectView.frame = (self.superview?.bounds)!
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.superview?.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
            blurEffectView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideShareOptions))
            blurEffectView.addGestureRecognizer(tap)
        }
    }
    func removeBlur(){
        for subView in (self.superview?.subviews)!{
            if subView is UIVisualEffectView{
                subView.removeFromSuperview()
            }
        }
    }
}
extension RUKShareView: RUKAnimationProtocol{
    func show(_completion: @escaping CompletionBlock) {
        self.addBlur()
        getShareSubMenu()
        UIView.animate(withDuration: 0.3, animations: {
            //Transform y i.e sharing view
            self.transform = CGAffineTransform(scaleX:0.7, y: 0.7)
            //Translate y i.e Height of collectionView
            self.shareSubMenu?.transform = CGAffineTransform(translationX: 0, y: -120)
            self.completion = _completion
        }, completion: {
            (value: Bool) in
            self.slidingDelegate?.didSlideOut()
        })

    }
    
    func hide(){
        UIView.animate(withDuration: 0.3, animations: {
            //Transform y i.e sharing view
            self.transform = CGAffineTransform(scaleX:1, y: 1)
            //Translate y i.e Height of collectionView
            self.shareSubMenu?.transform = CGAffineTransform(translationX: 0, y: 120)
            self.removeBlur()
        }, completion: {
            (value: Bool) in
            self.removeShareSubMenu()
            self.slidingDelegate?.didSlideIn()
        })
    }
}
//MARK: Row Selection
extension RUKShareView:CollectionViewOutputProtocol{
    func numberOfRows() -> Int {
        return (networksIcons?.count)!
    }
    func cellForRow(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: RUKShareSubMenu.CELLID, for: indexPath) as! SharingViewCell
        if let image = UIImage(named: (networksIcons?[indexPath.row])!){
            cell.imageSharingNetworks.image = image
        }
        if let title = networksNames?[indexPath.row]{
            cell.labelNetworkName.text = title
        }
        return cell
    }

    func didSelectedRow(collectionView: UICollectionView, indexPath: IndexPath) {
        completion!(indexPath.row)
    }
    func itemSize(collectionView: UICollectionView) -> CGSize {
        return CGSize(width: (collectionView.frame.maxX / CGFloat((networksIcons?.count)!)), height: 120)//4 is number of cells
    }
}
