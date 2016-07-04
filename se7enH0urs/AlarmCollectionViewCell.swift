//
//  AlarmCollectionViewCell.swift
//  lessthanten
//
//  Created by Joshua Newkirk on 7/3/16.
//  Copyright © 2016 Deca Interactive LLC. All rights reserved.
//

import UIKit

protocol AlarmCollectionViewCellDelegate
{
    func timerStartedForTime(time: String)
}

class AlarmCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var hoursLabel: UILabel!
    
    private var delegate: AlarmCollectionViewCellDelegate?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.hoursLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configureCellWithHour(let time : String)
    {
        self.hoursLabel.text = time
    }
    
    func startTimer()
    {
        
    }
    
    func endTimer()
    {
        
    }
}
