//
//  CollectionViewOutputProtocol.swift
//  RUKAnimatedScreenShare
//
//  Created by Sierra Solutions Mac User 5 on 16/1/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

protocol CollectionViewOutputProtocol {
    func cellForRow(collectionView:UICollectionView,indexPath:IndexPath)->UICollectionViewCell
    func didSelectedRow(collectionView:UICollectionView,indexPath:IndexPath)
    func numberOfRows() -> Int
    func itemSize(collectionView:UICollectionView)-> CGSize
}

protocol RUKShareViewSliding {
    func didSlideOut()
    func didSlideIn()
}
