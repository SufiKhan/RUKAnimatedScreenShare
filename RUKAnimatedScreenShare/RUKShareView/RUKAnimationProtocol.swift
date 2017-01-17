//
//  RUKAnimationProtocol.swift
//  RUKAnimatedScreenShare
//
//  Created by Sierra Solutions Mac User 5 on 16/1/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
typealias CompletionBlock = (Int?) -> Void
protocol RUKAnimationProtocol
{
    func show(_completion:@escaping CompletionBlock)
    func hide()
}
