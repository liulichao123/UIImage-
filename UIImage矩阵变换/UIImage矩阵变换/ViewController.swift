//
//  ViewController.swift
//  UIImage矩阵变换
//
//  Created by 天明 on 2018/10/20.
//  Copyright © 2018 天明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageVIew: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "test")!
        
        imageVIew.image = image.test()
//        imageVIew.image = image.FlipVertical() //垂直翻转
//        imageVIew.image = image.flHpHorizontal() //水平翻转
    }


}

/// 检测代码执行时间 (单位毫秒)
func executeTime(_ action: (() -> Void)) -> CFAbsoluteTime {
    let start = CFAbsoluteTimeGetCurrent()
    action()
    let end = CFAbsoluteTimeGetCurrent()
    let result = (end - start) * 1000 //-> ms
    return result
}

