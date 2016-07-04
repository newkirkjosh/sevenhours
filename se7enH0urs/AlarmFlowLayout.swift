//
//  AlarmFlowLayout.swift
//  lessthanten
//
//  Created by Joshua Newkirk on 7/3/16.
//  Copyright © 2016 Deca Interactive LLC. All rights reserved.
//

import UIKit

class AlarmFlowLayout: UICollectionViewFlowLayout
{
    init(itemSize : CGSize)
    {
        super.init()
        self.itemSize = itemSize
        self.scrollDirection = .Vertical
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.minimumLineSpacing = 0.0
        self.minimumInteritemSpacing = 0.0
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}
