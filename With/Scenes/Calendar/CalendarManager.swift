//
//  CalendarManager.swift
//  With
//
//  Created by 川村周也 on 2018/07/09.
//  Copyright © 2018年 川村周也. All rights reserved.
//

import UIKit

class CalendarManager: NSObject {
    var currentDate:Date
    let year:Int
    let month:Int
    
    let weeks = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    var days:[Int] = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    init(currentDate:Date){
        self.currentDate = currentDate
        self.year = Calendar.current.component(.year, from: currentDate)
        self.month = Calendar.current.component(.month, from: currentDate)
    }
    
    //１日の曜日を返す
    func getFirstDayOfWeek() -> Int {
        //曜日を調べて、その要素数だけ戻ったものがカレンダーの左上(日曜日=1 土曜日=7　なので1足した状態で戻る)
        let dayOfWeek = Calendar.current.component(.weekday,from: BeginDateOfCalendar())
        return dayOfWeek
    }
    
    func getLastDayOfWeek() -> Int {
        //曜日を調べて、その要素数だけ戻ったものがカレンダーの左上(日曜日=1 土曜日=7　なので1足した状態で戻る)
        let dayOfWeek = Calendar.current.component(.weekday,from: LastDateOfCalendar())
        return dayOfWeek
    }
    
    //月初の日にちを返す
    func FirstDateOfCalendar() -> Date{
        //DateComponent -> Date
        let FirstDateOfCalendar: Date = Calendar.current.date(from: DateComponents(year: self.year, month: self.month, day: 1))!
        return FirstDateOfCalendar
    }
    
    //月末の日にちを返す
    func LastDateOfCalendar() -> Date {
        //
        let LastDateOfCalendar: Date = Calendar.current.date(from: DateComponents(year: self.year, month: self.month, day: days[month]))!
        return LastDateOfCalendar
    }
    
    //カレンダーの始点（左上）になる日を返す
    func BeginDateOfCalendar() ->Date{
        //曜日を調べて、その要素数だけ戻ったものがカレンダーの左上(日曜日=1 土曜日=7　なので1足した状態で戻る)
        let dayOfWeek = Calendar.current.component(.weekday,from:FirstDateOfCalendar())
        var beginDate = Calendar.current.date(byAdding: .day, value: 1-dayOfWeek, to: FirstDateOfCalendar())!
        if (dayOfWeek == 1){
            beginDate = FirstDateOfCalendar()
        }
        return beginDate
    }
    
    //月カレンダーの終点（右下）になる日を返す
    func EndDateOfCalendar() ->Date{
        let lastDate = LastDateOfCalendar()
        //曜日を調べて、その要素数だけ進んだものが右下(次の月の初めで計算している事に注意)
        let dayOfWeek = Calendar.current.component(.weekday,from: lastDate)
        let endDate = Calendar.current.date(byAdding: .day, value: 7-dayOfWeek, to: lastDate)!
        return endDate
    }
    
    func getItems() -> [Int]{
        var dayItems:[Int] = []
        let beginDay = Calendar.current.component(.day, from: BeginDateOfCalendar())
        let endDay = Calendar.current.component(.day, from: EndDateOfCalendar())
        
        if (getFirstDayOfWeek() != 1){
        for i in beginDay...beginDay + getFirstDayOfWeek() - 1{ //カレンダーの左上から１日の曜日−１まで
            if(i < days[month-1]){
                dayItems.append(i)
            }
        }
        }
            
        for i in 1...days[month]{
            dayItems.append(i)
        }
        
        for i in 1...endDay{
            dayItems.append(i)
        }
        return dayItems
    }
    
    func getCalendarInfo() -> CalendarInfo{
        let Info:CalendarInfo = CalendarInfo(BeginDayOfWeek: getFirstDayOfWeek(), dayOfMonth: days[month], BeginDate: BeginDateOfCalendar(), EndDate: EndDateOfCalendar(), dayItems: getItems())
        return Info
    }
    
}
