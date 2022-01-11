//
//  ViewController+Screenshot.swift
//  ARPaper
//
//  Created by Bartosz Swiety on 11/01/2022.
//

import Foundation
import SceneKit

extension ViewController
{
    /// Takes Screenshot of whole Scene
    /// It's a little bit problematic becasue layer.render doesn't work with SceneKit, we need to make some hacks here.
    func takeShot()
    {
        let size = CGSize(width: sceneView.bounds.width, height: sceneView.bounds.height)
        UIGraphicsBeginImageContextWithOptions(
            size, false, 2)
        
        if let contex = UIGraphicsGetCurrentContext()
        {
            // Draw Camera
            sceneView.snapshot().draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .normal, alpha: 1)
            
            // Draw Shape
            rectangle?.rectangleView.render(in: contex)
            
            if let image = UIGraphicsGetImageFromCurrentImageContext()
            {
                // Save Buffer
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
            
            UIGraphicsEndImageContext()
        }
    }
}
