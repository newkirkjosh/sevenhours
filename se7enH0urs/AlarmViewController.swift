//
//  ViewController.swift
//  lessthanten
//
//  Created by Joshua Newkirk on 7/3/16.
//  Copyright © 2016 Deca Interactive LLC. All rights reserved.
//

import UIKit

private extension Selector {
    static let updateTimer = #selector(AlarmViewController.updateTimer)
}

class AlarmViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    // IBOutlets
    // UICollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    // UILabel
    @IBOutlet weak var alarmTimerView: UIView!
    @IBOutlet weak var alarmTimerLabel: UILabel!
    
    // UIButton
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var spotifyButton: UIButton!
    
    // MARK - Data Properties
    private var dataSource: [String] = []
    private let CellIdentifier: String = "AlarmCollectionViewCell"
    private var alarmTimer: NSTimer = NSTimer()
    private var secondsLeft: Int = 0
    private var seconds = 0, minutes = 0, hours = 0
    
    // MARK - Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupCollectionView()
        self.populateDataSource()
        self.alarmTimerLabel.adjustsFontSizeToFitWidth = true
    }
    
    // MARK - Private Functions
    
    private func populateDataSource()
    {
        self.dataSource = Array()
        for i in 1..<24 {
            self.dataSource.append("\(i)")
        }
    }
    
    private func setupCollectionView()
    {
        let flowLayout: AlarmFlowLayout = AlarmFlowLayout(itemSize: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.collectionView.collectionViewLayout = flowLayout
    }
    
    private func transitionTimerView(hidden hidden: Bool, animated: Bool, completion: (() -> Void)?)
    {
        let alpha: CGFloat = hidden ? 0.0 : 1.0
        
        if animated {
            UIView.animateWithDuration(0.3, animations: {
                self.alarmTimerView.alpha = alpha
                }, completion: { (finished) in
                    if finished {
                        if let c = completion { c() }
                    }
            })
        } else {
            self.alarmTimerView.alpha = alpha
            if let c = completion { c() }
        }
    }
    
    private func populateTimer(hours hours: Int, completion: (() -> Void)?)
    {
        guard hours > 0 else {
            NSLog("%@", "Enter a valid number of hours to start a timer")
            return
        }
        
        clearTimer()
        self.secondsLeft = hours * 3600
        updateTimerText()
        self.alarmTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector.updateTimer, userInfo: nil, repeats: true)
        
        if let c = completion {
            c()
        }
    }
    
    @objc(updateTimer)
    private func updateTimer()
    {
        self.secondsLeft -= 1;
        updateTimerText()
    }
    
    private func updateTimerText()
    {
        if self.secondsLeft > 0 {
            self.hours = self.secondsLeft / 3600;
            self.minutes = (self.secondsLeft % 3600) / 60;
            self.seconds = (self.secondsLeft % 3600) % 60;
            self.alarmTimerLabel.text = String(format: "%02d:%02d:%02d", self.hours, self.minutes, self.seconds)
        } else {
            clearTimer()
        }
    }
    
    private func clearTimer()
    {
        self.alarmTimer.invalidate()
        self.alarmTimerLabel.text = "--:--:--"
    }
    
    // MARK - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell : AlarmCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifier, forIndexPath: indexPath) as! AlarmCollectionViewCell
        let time : String = self.dataSource[indexPath.row]
        cell.configureCellWithHour(time)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.dataSource.count
    }
    
    // MARK - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        let hours : Int = Int(self.dataSource[indexPath.row])!
        populateTimer(hours: hours, completion: {
            self.transitionTimerView(hidden: false, animated: true, completion: nil)
        })
    }
    
    // MARK - IBActions
    
    @IBAction func doneButtonTapped(sender: AnyObject)
    {
        transitionTimerView(hidden: true, animated: true, completion: {
            self.clearTimer()
        })
    }
    
    @IBAction func spotifyButtonTapped(sender: AnyObject)
    {
        
    }
}

