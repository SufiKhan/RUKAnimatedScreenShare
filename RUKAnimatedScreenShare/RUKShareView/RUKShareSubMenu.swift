//
//  RUKShareSubMenu.swift
//  RUKAnimatedScreenShare
//
//  Created by Sierra Solutions Mac User 5 on 16/1/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit


class RUKShareSubMenu: UIView{
    
    
    static let CELLID = "cell"
    static let NIBNAME = "SharingViewCell"
    static let instance = RUKShareSubMenu()
    var _collectionView : UICollectionView?
    var output : CollectionViewOutputProtocol?
    
    
    func getSubMenu(view:UIView)->UICollectionView{
        //To avoid creation of instance again
        if  _collectionView == nil{
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            let frame = CGRect(x: 0, y: (view.frame.maxY), width: view.bounds.maxX, height: 120)
            _collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
            _collectionView?.dataSource = self
            _collectionView?.delegate = self
            _collectionView?.register(UINib.init(nibName: RUKShareSubMenu.NIBNAME, bundle: nil), forCellWithReuseIdentifier: RUKShareSubMenu.CELLID)
            _collectionView?.backgroundColor = UIColor.white
            print(_collectionView ?? "")
            return _collectionView!
        }else{
            _collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
            return _collectionView!
        }
    }
}

extension RUKShareSubMenu:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.collectionViewLayout.invalidateLayout()
        return (output?.numberOfRows())!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (output?.cellForRow(collectionView: collectionView, indexPath: indexPath))!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.didSelectedRow(collectionView: collectionView, indexPath: indexPath)
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (output?.itemSize(collectionView: collectionView))!
    }
}

