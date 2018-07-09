//
//  CalendarManager.swift
//  With
//
//  Created by 川村周也 on 2018/07/09.
//  Copyright © 2018年 川村周也. All rights reserved.
//

import UIKit

protocol CalendarMethod {
    func reloadComponents(date:Date) //引数の日付でcurrentDate,year,monthを読み直し
    func getFirstDayOfWeek() -> Int //１日の曜日を返す
    func getLastDayOfWeek() -> Int //月末の曜日を返す
    func FirstDateOfCalendar() -> Date //月初の日にちを返す
    func LastDateOfCalendar() -> Date //月末の日にちを返す
    func BeginDateOfCalendar() ->Date //カレンダーの始点（左上）になる日を返す
    func EndDateOfCalendar() ->Date //月カレンダーの終点（右下）になる日を返す
    func getItems() -> [Int] //カレンダーに表示する日にちの配列を返す
    func getCalendarInfo(date:Date) -> CalendarInfo //引数の日付でデータをリロードしてカレンダーに必要な情報を返す
}

class CalendarManager: CalendarMethod {
    var currentDate:Date
    var year:Int
    var month:Int
    
    let weeks = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    var days:[Int] = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    init(currentDate:Date){
        self.currentDate = currentDate
        self.year = Calendar.current.component(.year, from: currentDate)
        self.month = Calendar.current.component(.month, from: currentDate)
    }
    
    func reloadComponents(date:Date){
        self.currentDate = date
        self.year = Calendar.current.component(.year, from: self.currentDate)
        self.month = Calendar.current.component(.month, from: self.currentDate)
    }
    
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
    
    func FirstDateOfCalendar() -> Date{
        //DateComponent -> Date
        let FirstDateOfCalendar: Date = Calendar.current.date(from: DateComponents(year: self.year, month: self.month, day: 1))!
        return FirstDateOfCalendar
    }
    
    func LastDateOfCalendar() -> Date {
        //
        let LastDateOfCalendar: Date = Calendar.current.date(from: DateComponents(year: self.year, month: self.month, day: days[month]))!
        return LastDateOfCalendar
    }
    
    func BeginDateOfCalendar() ->Date{
        //曜日を調べて、その要素数だけ戻ったものがカレンダーの左上(日曜日=1 土曜日=7　なので1足した状態で戻る)
        let dayOfWeek = Calendar.current.component(.weekday,from:FirstDateOfCalendar())
        var beginDate = Calendar.current.date(byAdding: .day, value: 1-dayOfWeek, to: FirstDateOfCalendar())!
        if (dayOfWeek == 1){
            beginDate = FirstDateOfCalendar()
        }
        return beginDate
    }
    
    func EndDateOfCalendar() ->Date {
        let lastDate = LastDateOfCalendar()
        //曜日を調べて、その要素数だけ進んだものが右下(次の月の初めで計算している事に注意)
        let dayOfWeek = Calendar.current.component(.weekday,from: lastDate)
        let endDate = Calendar.current.date(byAdding: .day, value: 7-dayOfWeek, to: lastDate)!
        return endDate
    }
    
    func getItems() -> [Int] {
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
    
    func getCalendarInfo(date:Date) -> CalendarInfo{
        reloadComponents(date: date)
        let Info:CalendarInfo = CalendarInfo(BeginDayOfWeek: getFirstDayOfWeek(), dayOfMonth: days[month], BeginDate: BeginDateOfCalendar(), EndDate: EndDateOfCalendar(), dayItems: getItems())
        return Info
    }
    
}
