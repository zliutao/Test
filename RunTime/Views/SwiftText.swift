//
//  SwiftText.swift
//  RunTime
//
//  Created by wujh on 17/7/31.
//  Copyright © 2017年 南京. All rights reserved.
//

import Foundation

import UIKit


func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score }
        sum += score }
    return (min, max, sum)
}

func change(gg:String) -> (Int) {
    //var tab = ?UITableView
    let labe = UITableView(frame: CGRectMake(20, 30, 100, 20))
   // labe.registerNib(nib:"MainTableViewCell", forCellReuseIdentifier: "cell")
   // labe .registerNib(UINib "MainTableViewCell", forCellReuseIdentifier: "cell")
    let statistics = calculateStatistics([5, 3, 100, 3, 9])
    print(statistics.sum)
    print(statistics.2)
    
    
    
    return statistics.max
}
let statistics = calculateStatistics([5, 3, 100, 3, 9])


