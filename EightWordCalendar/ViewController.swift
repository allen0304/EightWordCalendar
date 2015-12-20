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
    @IBOutlet var label節氣1: UILabel!
    @IBOutlet var label節氣2: UILabel!
    let theDate = NSDate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ewCalendar = EWCalendar(aDate: theDate)
        date1.text = ewCalendar.rocDateString
        date2.text = ewCalendar.lunarDateString
        userView.setDate(theDate)
        
        let fmt = NSDateFormatter()
        fmt.calendar = gregorianCalendar
        fmt.dateFormat = "M月d日 HH:mm"
        label節氣1.text = ewCalendar.solarTerms[0].termName + "：" + fmt.stringFromDate(ewCalendar.solarTerms[0].termDate)
        label節氣2.text = ewCalendar.solarTerms[1].termName + "：" + fmt.stringFromDate(ewCalendar.solarTerms[1].termDate)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

