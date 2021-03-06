//
//  CalendarCollectionViewLayout.swift
//  With
//
//  Created by 川村周也 on 2018/05/24.
//  Copyright © 2018年 川村周也. All rights reserved.
//

import UIKit

class CalendarCollectionViewLayout: UICollectionViewLayout {
    /// 1列当たりのセル数を定義する。
    let numberOfColumns:CGFloat = 7.0
    let cellMargin:CGFloat = 2.0
    var allHeight: CGFloat = 0
    
    
    //レイアウト配列
    var layoutData = [UICollectionViewLayoutAttributes]()
    
    //ここでのインスタンスはViewControllerのとは別物なので値が連動しない
    let dateManager = DateManager()
    
    override func prepare() {
        super.prepare()
        makeLayout()
    }
    
    func makeLayout() {
        
        // TODO: ここにサイズを計算する処理を書く
        // TODO: numberOfColumns を使って横向きにいくつ配置するか計算する
        
        //全体の幅
        let width = (collectionView!.frame.size.width - cellMargin * numberOfColumns)/CGFloat(7)
        let height = width
        allHeight = height + 100
        
        
        
        //座標
        var y:CGFloat = 0
        var x:CGFloat = 0
        
        layoutData.removeAll()
        
        for i in 0 ..< collectionView!.numberOfSections {
            //要素数ぶんループ
            for count in 0 ..< collectionView!.numberOfItems(inSection: i) {
                
                let indexPath = IndexPath(item:count, section:i)
                var cellVerticalMargin:CGFloat = 0.0
                let dayOfWeek = count % 7
                
                if i == 1{
                    /*if count > selected - dayOfWeek, count <= selected + (7 - dayOfWeek), selectedColor == UIColor.white{
                        cellVerticalMargin = 150.0
                    }else{
                        cellVerticalMargin = 0.0
                    }*/
                }
                
                //X座標を更新
                if(count % 7 == 0) {
                    x = 0
                    if(i == 1) {
                        //Y座標を更新
                        y = y + height + cellVerticalMargin
                        allHeight = allHeight + height
                    }
                }
                
                
                
                //レイアウトの配列に位置とサイズを登録する。
                let frame = CGRect(x:x, y:y, width:width, height: height)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                layoutData.append(attributes)
                
                x = x + width
                
            }
        }
    }
    
    //レイアウトを返すメソッド
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutData
    }
    
    //全体サイズを返すメソッド
    override var collectionViewContentSize: CGSize {
        //全体の幅
        let width = collectionView!.frame.size.width
        
        return CGSize(width:width, height:allHeight)
    }
    
    
    override func invalidateLayout() {
        // TODO: makeLayout()で計算したサイズがあれば削除
        makeLayout()
        super.invalidateLayout()
    }
}
