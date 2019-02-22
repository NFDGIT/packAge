//
//  PHCalendarView.swift
//  package
//
//  Created by Admin on 2019/2/20.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class PHCalendarView: PHLayoutView {
    override init() {
        super.init()
    
        let layout = PHLayout.init()
        layout.type = .collection
        layout.column = 7
        self.layout = layout
        
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

    
    }
    
    func initUI() {
        let components = PHCalendarView.getComponents(date: PHCalendarView.getDate(year: self.currentYear, month: self.currentMonth, day: 1))
        let daysOfMonth =  PHCalendarView.getDaysOfTheMonthWithDate(date: PHCalendarView.getDate(year: self.currentYear, month: self.currentMonth, day: 1))
        
        self.numberOfCell = {
            let count = daysOfMonth + (components.weekday!-1)
            
            return count
        }
        self.cellForIndex = {index in
      
            let btn  : UIButton =   UIButton.init(normalTitle: "\(index - (components.weekday! - 1)+1)", normalTextColor: UIColor.phBlackText, font: UIFont.phBig)
            if index < (components.weekday! - 1){btn.isHidden = true}
            
            btn.phLayer(cornerRadius: 10, borderWidth:0.5 ,borderColor:UIColor.phBlackText )
            
            return btn
        }
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
    
}
