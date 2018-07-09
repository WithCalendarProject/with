//
//  CalendarViewController.swift
//  With
//
//  Created by 川村周也 on 2018/05/24.
//  Copyright © 2018年 川村周也. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    let calendarManager = CalendarManager(currentDate: Date())
    var calendarData: CalendarDataSourse?

    @IBOutlet weak var CalendarCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let items:Array<Int> = calendarManager.getItems()

        self.calendarData = CalendarDataSourse(items: items)
        self.CalendarCollectionView.dataSource = self.calendarData
        self.CalendarCollectionView.delegate = self.calendarData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
