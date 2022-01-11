//
//  ScreenShot.swift
//  ARPaper
//
//  Created by Bartosz Swiety on 11/01/2022.
//

import Foundation
func takeScreenshot(of view: UIView) {
     UIGraphicsBeginImageContextWithOptions(
         CGSize(width: view.bounds.width, height: view.bounds.height),
         false,
         2
     )

     view.layer.render(in: UIGraphicsGetCurrentContext()!)
     let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
     UIGraphicsEndImageContext()

     UIImageWriteToSavedPhotosAlbum(screenshot, self, #selector(imageWasSaved), nil)
 }
