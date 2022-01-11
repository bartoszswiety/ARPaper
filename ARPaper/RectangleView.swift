//
//  RectangleView.swift
//  ARPaper
//
//  Created by Bartosz Swiety on 11/01/2022.
//

import Foundation
import UIKit

//
class RectangleView: CAShapeLayer
{
    init(points:[CGPoint])
    {
        super.init()
        self.set(points: points)
        
        self.lineWidth = 2
        self.strokeColor = UIColor.red.cgColor
        self.fillColor = UIColor.red.cgColor
        self.opacity = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Updates Curve points.
    public func set(points:[CGPoint])
    {
        if let positon = points.last
        {
            let bezierPath = UIBezierPath()
            bezierPath.move(to: positon)
            points.forEach({bezierPath.addLine(to: $0)})
            bezierPath.close()
            self.path = bezierPath.cgPath
        }
    }
}
