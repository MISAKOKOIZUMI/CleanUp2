//
//  ViewController.swift
//  CleanUp2
//
//  Created by misako.k on 2017/02/26.
//  Copyright © 2017年 ffd. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    let weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let numOfDays = 7       //1週間の日数
    let cellMargin : CGFloat = 2.0  //セルのマージン。セルのアイテムのマージンも別にあって紛らわしい。アイテムのマージンはゼロに設定し直してる
    let dateManager = DateManager()
    

    @IBOutlet weak var calenderCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calenderCollectionView.delegate = self
        calenderCollectionView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //コレクションビューのセクション数　今回は2つに分ける
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //セルをクリックしたら呼ばれる
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Num：\(indexPath.row) Section:\(indexPath.section)")
    }
    
    //セルのレイアウト設定

    //セルサイズの指定（UICollectionViewDelegateFlowLayoutで必須）　横幅いっぱいにセルが広がるようにしたい
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin:CGFloat = 8.0
        let widths:CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin)/CGFloat(numOfDays)
        let heights:CGFloat = widths * 0.8
        
        return CGSize(width:widths,height:heights)
    }
    
    //セルのアイテムのマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0.0 , 0.0 , 0.0 , 0.0 )  //マージン(top , left , bottom , right)
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    //セルの垂直方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    //データの個数（DataSourceを設定した場合に必要な項目）
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){   //section:0は曜日を表示
            return numOfDays
        }else{
            return dateManager.daysAcquisition()
            //section:1は日付を表示 　※セルの数は始点から終点までの日数
        }
    }
    
    //データを返すメソッド（DataSourceを設定した場合に必要な項目）
    //動作確認の為セルの背景を変える。曜日については表示する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //コレクションビューから識別子「CalendarCell」のセルを取得する
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        if(indexPath.section == 0){             //曜日表示
            cell.backgroundColor = UIColor.green
            cell.textLabel.text = weekArray[indexPath.row]
            
        }else{                                  //日付表示
            cell.backgroundColor = UIColor.white
            cell.textLabel.text = dateManager.conversionDateFormat(index: indexPath.row) //Index番号から表示する日を求める
            
        }
        return cell
    }

}
