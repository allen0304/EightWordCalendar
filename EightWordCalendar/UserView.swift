//
//  UserView.swift
//  PocketMaster
//
//  Created by Allen on 2015/9/21.
//  Copyright © 2015年 Allen. All rights reserved.
//

import UIKit

//class UserView: UIView {
@IBDesignable class UserView: UIView {
    @IBOutlet var label年柱: UILabel!
    @IBOutlet var label年干: UILabel!
    @IBOutlet var label年支: UILabel!
    @IBOutlet var hiddenYearView: UIStackView!
    @IBOutlet var tenGodYearView: UIStackView!
    
    @IBOutlet var label月柱: UILabel!
    @IBOutlet var label月干: UILabel!
    @IBOutlet var label月支: UILabel!
    @IBOutlet var hiddenMonthView: UIStackView!
    @IBOutlet var tenGodMonthView: UIStackView!
    
    @IBOutlet var label日干: UILabel!
    @IBOutlet var label日支: UILabel!
    @IBOutlet var hiddenDayView: UIStackView!
    @IBOutlet var tenGodDayView: UIStackView!
    
    @IBOutlet var label時柱: UILabel!
    @IBOutlet var label時干: UILabel!
    @IBOutlet var label時支: UILabel!
    @IBOutlet var hiddenHourView: UIStackView!
    @IBOutlet var tenGodHourView: UIStackView!

    @IBInspectable var hiddenFontSize: CGFloat = 16.0
    
    var view: UIView!
    var nibName: String = "UserView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView

        return view
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func setDate(aDate: NSDate) {
        let ewCalendar = EWCalendar(aDate: aDate)
        label年柱.text = ewCalendar.getTenGod(ewCalendar.年干)
        label年干.text = String(ewCalendar.年干)
        label年干.textColor = ewCalendar.年干.element.color
        label年支.text = String(ewCalendar.年支)
        label年支.textColor = ewCalendar.年支.element.color
        // 刪除原藏干
        for aView in self.hiddenYearView.arrangedSubviews {
            self.hiddenYearView.removeArrangedSubview(aView)
        }
        // 刪除原藏神
        for aView in self.tenGodYearView.arrangedSubviews {
            self.tenGodYearView.removeArrangedSubview(aView)
        }
        // 新增藏干＆藏神
        for item in ewCalendar.年支.藏干 {
            let label = UILabel()
            label.textAlignment = .Center
            label.font = UIFont.systemFontOfSize(hiddenFontSize)
            // 藏干
            label.text = String(item)
            label.textColor = item.element.color
            self.hiddenYearView.insertArrangedSubview(label, atIndex: 0)
            
            // 藏神
            let label2 = UILabel()
            label2.font = UIFont.systemFontOfSize(hiddenFontSize)
            label2.numberOfLines = 2
            label2.textAlignment = .Center
            label2.text = ewCalendar.getTenGodForVerticalName(item)
            label2.textColor = UIColor.blackColor()
            self.tenGodYearView.insertArrangedSubview(label2, atIndex: 0)
        }
        
        label月柱.text = ewCalendar.getTenGod(ewCalendar.月干)
        label月干.text = String(ewCalendar.月干)
        label月干.textColor = ewCalendar.月干.element.color
        label月支.text = String(ewCalendar.月支)
        label月支.textColor = ewCalendar.月支.element.color
        // 刪除原藏干
        for aView in self.hiddenMonthView.arrangedSubviews {
            self.hiddenMonthView.removeArrangedSubview(aView)
        }
        // 刪除原藏神
        for aView in self.tenGodMonthView.arrangedSubviews {
            self.tenGodMonthView.removeArrangedSubview(aView)
        }
        // 新增藏干＆藏神
        for item in ewCalendar.月支.藏干 {
            let label = UILabel()
            label.font = UIFont.systemFontOfSize(hiddenFontSize)
            label.textAlignment = .Center
            label.text = String(item)
            label.textColor = item.element.color
            self.hiddenMonthView.insertArrangedSubview(label, atIndex: 0)
            // 藏神
            let label2 = UILabel()
            label2.font = UIFont.systemFontOfSize(hiddenFontSize)
            label2.numberOfLines = 2
            label2.textAlignment = .Center
            label2.text = ewCalendar.getTenGodForVerticalName(item)
            label2.textColor = UIColor.blackColor()
            self.tenGodMonthView.insertArrangedSubview(label2, atIndex: 0)
        }
        
        label日干.text = String(ewCalendar.日干)
        label日干.textColor = ewCalendar.日干.element.color
        label日支.text = String(ewCalendar.日支)
        label日支.textColor = ewCalendar.日支.element.color
        // 刪除原藏干
        for aView in self.hiddenDayView.arrangedSubviews {
            self.hiddenDayView.removeArrangedSubview(aView)
        }
        // 刪除原藏神
        for aView in self.tenGodDayView.arrangedSubviews {
            self.tenGodDayView.removeArrangedSubview(aView)
        }
        // 新增藏干＆藏神
        for item in ewCalendar.日支.藏干 {
            let label = UILabel()
            label.font = UIFont.systemFontOfSize(hiddenFontSize)
            label.textAlignment = .Center
            label.text = String(item)
            label.textColor = item.element.color
            self.hiddenDayView.insertArrangedSubview(label, atIndex: 0)
            // 藏神
            let label2 = UILabel()
            label2.font = UIFont.systemFontOfSize(hiddenFontSize)
            label2.numberOfLines = 2
            label2.textAlignment = .Center
            label2.text = ewCalendar.getTenGodForVerticalName(item)
            label2.textColor = UIColor.blackColor()
            self.tenGodDayView.insertArrangedSubview(label2, atIndex: 0)
        }
        
        label時柱.text = ewCalendar.getTenGod(ewCalendar.時干)
        label時干.text = String(ewCalendar.時干)
        label時干.textColor = ewCalendar.時干.element.color
        label時支.text = String(ewCalendar.時支)
        label時支.textColor = ewCalendar.時支.element.color
        // 刪除原藏干
        for aView in self.hiddenHourView.arrangedSubviews {
            self.hiddenHourView.removeArrangedSubview(aView)
        }
        // 刪除原藏神
        for aView in self.tenGodHourView.arrangedSubviews {
            self.tenGodHourView.removeArrangedSubview(aView)
        }
        // 新增藏干＆藏神
        for item in ewCalendar.時支.藏干 {
            let label = UILabel()
            label.font = UIFont.systemFontOfSize(hiddenFontSize)
            label.layer.backgroundColor = UIColor.clearColor().CGColor
            
            label.textAlignment = .Center
            label.text = String(item)
            label.textColor = item.element.color
            self.hiddenHourView.insertArrangedSubview(label, atIndex: 0)
            // 藏神
            let label2 = UILabel()
            label2.font = UIFont.systemFontOfSize(hiddenFontSize)
            label2.numberOfLines = 2
            label2.textAlignment = .Center
            label2.text = ewCalendar.getTenGodForVerticalName(item)
            label2.textColor = UIColor.blackColor()
            self.tenGodHourView.insertArrangedSubview(label2, atIndex: 0)
        }
        
    }
}
