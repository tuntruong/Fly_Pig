//
//  ViewController.swift
//  FlyPig
//
//  Created by Cuong15tr on 1/9/18.
//  Copyright © 2018 Cuong15tr. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var imgBackGroundLeft: NSLayoutConstraint!
    @IBOutlet weak var imgBackGroundWith: NSLayoutConstraint!
    @IBOutlet weak var playerCenterY: NSLayoutConstraint!
    @IBOutlet weak var player: UIImageView!
    @IBOutlet weak var planImg: UIImageView!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        firstSetup()
    }

    func firstSetup(){
        imgBackGroundWith.constant = view.frame.width * 8
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(gamePlay), userInfo: nil, repeats: true)
        //Plan Position
        planImg.frame = CGRect(x: self.view.frame.width + planImg.frame.width , y: planImg.bounds.origin.y, width: planImg.frame.width, height: planImg.frame.height)
    }
    
    @objc func gamePlay(){
        moveBackGround()
        pigDown()
        planMove()
    }
    
     func moveBackGround(){
        // moveBackGround
        imgBackGroundLeft.constant -= 0.5
        if imgBackGroundLeft.constant <= -7*view.frame.width {
            imgBackGroundLeft.constant = 10
        }
    }
    @IBAction func movePig(_ sender: Any) {
        playerCenterY.constant -= 110
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutSubviews()
        }) { (true) in
            self.playerCenterY.constant += 10
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutSubviews()
            })
        }
    }
    //MARK: Move pig up down
    func pigDown(){
        playerCenterY.constant += 0.6
        
        // Check die
        if playerCenterY.constant > self.view.frame.size.height/2 - player.frame.size.height/2 || playerCenterY.constant < -(self.view.frame.size.height/2 - player.frame.size.height/2) {
           pigIsDied()
        }
    }
    //MARK: Plan move
    func planMove(){
        planImg.frame = CGRect(x: planImg.frame.origin.x-1, y: planImg.frame.origin.y, width: planImg.frame.width, height: planImg.frame.height)
        if planImg.frame.origin.x == -planImg.frame.width {
            let randomY: CGFloat = CGFloat(arc4random_uniform(UInt32(self.view.frame.height)))
            planImg.frame.origin.x = self.view.frame.width + 50
            planImg.frame.origin.y = randomY
        }
        if planImg.frame.intersects(player.frame) {
            pigIsDied()
        }
    }
    //MARK: Animate when pig is died
    func pigIsDied(){
        timer?.invalidate()
        tapGesture.isEnabled = false
        //Animate when died
        player.backgroundColor = UIColor.black
        playerCenterY.constant = 1000
        UIView.animate(withDuration: 2, animations: {
            self.view.layoutSubviews()
        })
    }
}

