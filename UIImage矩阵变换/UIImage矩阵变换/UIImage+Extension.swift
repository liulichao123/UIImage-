//
//  Some.swift
//  test
//
//  Created by 天明 on 2018/10/19.
//  Copyright © 2018 天明. All rights reserved.
//

import UIKit

extension UIImage {
    /// 水平翻转
    // 处理9mb图片耗时250ms左右 效率高，推荐使用
    func flHpHorizontal() -> UIImage? {

        //需要 width*self.scale，因为创建上下文时没有scale选项
        let rect = CGRect(x: 0, y: 0, width: self.size.width*self.scale, height: self.size.height*self.scale)
 
        guard let bitsPerComponent = self.cgImage?.bitsPerComponent, let colorSpace = self.cgImage?.colorSpace, let bytesPerRow = self.cgImage?.bytesPerRow, let bitmapInfo = self.cgImage?.bitmapInfo else {
            return nil
        }
        //这种方式得到的位图context，图片绘制上去会自动转换坐标系，不需要再修复复位
        guard let context = CGContext(data: nil, width: Int(rect.width), height: Int(rect.height), bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
        //水平翻转（将坐标系右移，再翻转到矩形框内）
        context.translateBy(x: rect.width, y: 0)
        context.scaleBy(x: -1, y: 1)
        
        //需要在变换之后draw
        context.draw(self.cgImage!, in: rect)
        //这里不能使用UIGraphicsGetImageFromCurrentImageContext，因为没有开启当前上下文，而是创建的新的，需要从新的里面获取
        guard let cgImage = context.makeImage() else { return nil }
        return UIImage(cgImage: cgImage, scale: self.scale, orientation: UIImage.Orientation.up)
    }
    
    //处理9mb图片 耗时515ms左右 效率低(相对上面的方法)，得到的图片的体积变大(比上面还大) 不建议使用
//    func flHpHorizontal1() -> UIImage? {
//        //不需要 width*self.scale，因为开启上下文时设置了scale
//        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
//        UIGraphicsBeginImageContextWithOptions(rect.size, true, self.scale)
//        let context = UIGraphicsGetCurrentContext()!
//        //纠正复位
//        context.translateBy(x: 0, y: rect.height)
//        context.scaleBy(x: 1, y: -1)
//
//        //水平翻转（先左移，再翻转到矩形框内）
//        context.translateBy(x: rect.width, y: 0)
//        context.scaleBy(x: -1, y: 1)
//
//        //必须在变换之后绘制
//        context.draw(self.cgImage!, in: rect)
//
//        //方法1得到图片
//        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return resultImage
//        //方法2得到图片
////        guard let cgImage = context.makeImage() else { return nil }
////        return UIImage(cgImage: cgImage, scale: self.scale, orientation: UIImage.Orientation.up)
//    }
    
    
    /// 垂直翻转
    func FlipVertical() -> UIImage? {
        //需要 width*self.scale，因为创建上下文时没有scale选项
        let rect = CGRect(x: 0, y: 0, width: self.size.width*self.scale, height: self.size.height*self.scale)
        
        guard let bitsPerComponent = self.cgImage?.bitsPerComponent, let colorSpace = self.cgImage?.colorSpace, let bytesPerRow = self.cgImage?.bytesPerRow, let bitmapInfo = self.cgImage?.bitmapInfo else {
            return nil
        }
        //这种方式得到的位图context，图片绘制上去会自动转换坐标系，不需要再修复复位
        guard let context = CGContext(data: nil, width: Int(rect.width), height: Int(rect.height), bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
        //垂直翻转
        context.translateBy(x: 0, y: rect.height)
        context.scaleBy(x: 1, y: -1)
        
        //需要在变换之后draw
        context.draw(self.cgImage!, in: rect)
        //这里不能使用UIGraphicsGetImageFromCurrentImageContext，因为没有开启当前上下文，而是创建的新的，需要从新的里面获取
        guard let cgImage = context.makeImage() else { return nil }
        return UIImage(cgImage: cgImage, scale: self.scale, orientation: UIImage.Orientation.up)
    }
    
    func test() -> UIImage? {

        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        //纠正复位（使用绘制方法2时需要纠正）不纠正会发生倒立图
        context.translateBy(x: 0, y: rect.height)
        context.scaleBy(x: 1, y: -1) //会使坐标系轴方向发生变化

        //要执行的动作
        context.translateBy(x: 30, y: 30)

        //必须在变换之后绘制draw
        
        //绘制方法1.自动适配坐标系，无需纠正复位
//        self.draw(in: rect)
        
        //绘制方法2.需手动纠正复位
        //UIKit中Image的左上角 -> context中的原点位置
        //       Image的左下角 -> context中的原点y的正方向
       context.draw(self.cgImage!, in: rect)

        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage

    }
}
