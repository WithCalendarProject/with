//
//  CalendarViewController.swift
//  With
//
//  Created by 川村周也 on 2018/05/24.
//  Copyright © 2018年 川村周也. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let dateManager = DateManager()
    let weeks = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    let cellMargin : CGFloat = 2.0  //セルのマージン。セルのアイテムのマージンも別にあって紛らわしい。アイテムのマージンはゼロに設定し直してる
    var cellVerticalMargin : CGFloat = 0.0
    var cellRect = CGRect(x: 0,y: 0,width: 0,height: 0)
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // section数は2つ
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){   //section:0は曜日を表示
            return 7
        }else{
            return dateManager.daysAcquisition()        //section:1は日付を表示 　※セルの数は始点から終点までの日数
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // "Cell" はストーリーボードで設定したセルのID
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",for: indexPath) //as! CalendarCell
        
        //cell.ovalShapeLayer.delegate = self as? CALayerDelegate
        cell.ovalShapeLayer.removeFromSuperlayer()
        //cell.textLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        if (indexPath.item % 7 == 0) {
            cell.textLabel.textColor = UIColor.red
        } else if (indexPath.item % 7 == 6) {
            cell.textLabel.textColor = UIColor.blue
        } else {
            cell.textLabel.textColor = UIColor.black
        }
        
        if(indexPath.section == 0){             //曜日表示
            cell.backgroundColor = UIColor.clear
            cell.textLabel.font = UIFont.systemFont(ofSize: 12)
            cell.textLabel.text = weeks[indexPath.row]
            
        }else{                                  //日付表示
            cell.backgroundColor = UIColor.clear
            
            cell.textLabel.text = dateManager.conversionDateFormat(index: indexPath.row) //Index番号から表示する日を求める
            cell.tag = Int(dateManager.conversionDateFormat(index: indexPath.row))!//セルのタグに日付を追加
            
            /*
             if judgePlanIsEnpty(year: dateManager.selectYear(), month: dateManager.selectMonth(), day: cell.tag, dates: dates) == false{
             //cell.textLabel.text = cell.textLabel.text! + "."
             }*/
            /*
            if indexPath.item - dateManager.firstdayOfWeek() + 2  == dateManager.selectDate(){
                //cell.textLabel.textColor = selectedColor
                cell.textLabel.textColor = UIColor.white
                cell.textLabel.font = UIFont.boldSystemFont(ofSize: 12)
                cellRect = cell.frame
                print(cellRect)
                datePlanTable.frame = CGRect(x: 0,y: cellRect.minY + CGFloat(cellRect.height),width: self.view.frame.width,height: 150)
                cell.ovalShapeLayer.strokeColor = UIColor.cyan.cgColor  // 輪郭は青
                cell.ovalShapeLayer.fillColor = UIColor.cyan.cgColor  // 塗りはクリア
                cell.layer.insertSublayer(cell.ovalShapeLayer, at: 0)
            }else{
                cell.textLabel.font = UIFont.systemFont(ofSize: 12)
            }*/
            
            if indexPath.item < dateManager.firstdayOfWeek()-1{
                cell.textLabel.text = ""
            }
            if indexPath.item > dateManager.daysAcquisition()-(8-dateManager.lastdayOfWeek()){
                cell.textLabel.text = ""
            }
            
            
        }
        
        return cell
    }
    

    @IBOutlet weak var CalendarCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
