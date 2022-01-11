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
    let label: UILabel
    
    init(points: [CGPoint])
    {
        self.label = UILabel()
        self.label.textColor = .blue
        
        super.init()
        self.set(points: points)
        
        self.lineWidth = 2
        self.strokeColor = UIColor.red.cgColor
        self.fillColor = UIColor.red.cgColor
        self.opacity = 0.5
        addSublayer(label.layer)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func removeFromSuperview()
    {
        self.removeFromSuperlayer()
        self.label.removeFromSuperview()
    }
    
    /// Calculates Bezier Curve with points.
    public func set(points: [CGPoint])
    {
        if let positon = points.last
        {
            let bezierPath = UIBezierPath()
            bezierPath.move(to: positon)
            points.forEach { bezierPath.addLine(to: $0) }
            bezierPath.close()
            
            self.path = bezierPath.cgPath
            
            self.label.frame = CGRect(x: points[3].x, y: points[2].y, width: 200, height: 100)
            self.label.textAlignment = .center
        }
    }
}
