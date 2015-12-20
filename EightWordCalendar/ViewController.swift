//
//  ViewController.swift
//  EightWordCalendar
//
//  Created by Allen on 2015/12/20.
//  Copyright © 2015年 Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var userView: UserView!
    @IBOutlet var date1: UILabel!
    @IBOutlet var date2: UILabel!
    let theDate = NSDate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ewCalendar = EWCalendar(aDate: theDate)
        date1.text = ewCalendar.rocDateString
        date2.text = ewCalendar.lunarDateString
        userView.setDate(theDate)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

