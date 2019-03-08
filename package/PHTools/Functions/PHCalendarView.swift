//
//  PHCalendarView.swift
//  package
//
//  Created by Admin on 2019/2/20.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
class PHCalendarDay: NSObject {
    var date : Date?
    var components  : DateComponents?

    override init() {
        super.init()
        date = Date.init()
    }
    init(date:Date) {
        var newDate = date
        let timeZone = TimeZone.current
        newDate = newDate.addingTimeInterval(TimeInterval(timeZone.secondsFromGMT()))
        
        
        self.components = PHCalendarView.getComponents(date: date)
        self.date = newDate
    }
    init(year:Int,month:Int,day:Int) {
        
        var date = DateComponents.init(calendar: Calendar.current, timeZone: nil, era: nil, year: year, month: month, day: day, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil).date
        
        let timeZone = TimeZone.current
        date = date?.addingTimeInterval(TimeInterval(timeZone.secondsFromGMT()))
        self.date = date!
    }
}
class PHCalendarView: UIView {
    /// 选择每个单元的回调
    var selectedCell:((Int)->())?
    var cellForDate:((PHCalendarDay)->(UIView))?
    
    
    init() {
        super.init(frame: CGRect.zero)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var _currentYear : Int = 2019
    var currentYear : Int{
        set{
            _currentYear = newValue
        }
        get{
            return _currentYear
        }
    }
    
    private var _currentMonth : Int = 2
    var currentMonth : Int{
        set{
            _currentMonth = newValue<1 ? 12 : newValue
            _currentMonth = newValue>12 ? 1 : newValue
        }
        get{
            return _currentMonth
        }
    }
    func initData(year:Int,month:Int)  {
        _currentYear = year
        _currentMonth = month
    }
    
    func reload() {
//        var iterator = self.subviews.makeIterator()
//        while let ele = iterator.next(){
//            ele.removeFromSuperview()
//        }
        
        
        let layoutview : PHLayoutView = PHLayoutView.init()
        self.addSubview(layoutview)
        layoutview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        let layout = PHLayout.init()
        layout.type = .collection
        layout.column = 7
        layoutview.layout = layout
        
        
        
        let components = PHCalendarView.getComponents(date: PHCalendarView.getDate(year: self.currentYear, month: self.currentMonth, day: 1))
        let daysOfMonth =  PHCalendarView.getDaysOfTheMonthWithDate(date: PHCalendarView.getDate(year: self.currentYear, month: self.currentMonth, day: 1))
        
        layoutview.numberOfCell = {
            let count = daysOfMonth + (components.weekday!-1)
            
            return count
        }
        layoutview.cellForIndex = {index in
             let  firstDayDate = PHCalendarView.getDate(year: self.currentYear, month: self.currentMonth, day: 1)
            
            
             let gapDay = index - (components.weekday! - 1)
    
             let  resultDayDate = PHCalendarView.dateAdding(date: firstDayDate, gapDay: gapDay)
    
//            let btn  : UIButton =   UIButton.init(normalTitle: "\(index - (components.weekday! - 1)+1)", normalTextColor: UIColor.phBlackText, font: UIFont.phBig)
//            if index < (components.weekday! - 1){btn.isHidden = true}
//
//            btn.phLayer(cornerRadius: UIScreen.main.bounds.width/14, borderWidth:0 )
//            btn.setBackgroundImage(UIImage.phInit(color: UIColor.appTheme), for: .highlighted)
            
    
            let daydate =  PHCalendarDay.init(date: resultDayDate)

            let view = self.cellForDate!(daydate)
            return view
        }
        layoutview.selectedCell = {index in
            if (self.selectedCell != nil){
                self.selectedCell!(index - (components.weekday! - 1)+1)
            }
        }
        layoutview.reload()
        
    }

}
extension PHCalendarView{
    static func getDate(year:Int,month:Int,day:Int) -> Date
    {
        var date = DateComponents.init(calendar: Calendar.current, timeZone: nil, era: nil, year: year, month: month, day: day, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil).date
        
        let timeZone = TimeZone.current
        date = date?.addingTimeInterval(TimeInterval(timeZone.secondsFromGMT()))
        return date!

    }
    static func getComponents(date:Date) -> DateComponents {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([Calendar.Component.year,.month,.day,.weekday], from: date)
        return components
    }
    static func getDaysOfTheMonthWithDate(date:Date) -> Int {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let range = calendar?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date)
        return (range?.length)!
    }
    static func dateAdding(date:Date,gapYear:Int?=0,gapMonth:Int?=0,gapDay:Int) -> Date{
        
        let calendar = Calendar(identifier: .gregorian)
        var lastMonthComps = DateComponents()
        // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
        lastMonthComps.year = gapYear
        lastMonthComps.month = gapMonth
        lastMonthComps.day = gapDay
        
        let newDate = calendar.date(byAdding: lastMonthComps, to: date)
        return newDate!
    }
}
