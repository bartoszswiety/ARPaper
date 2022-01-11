//
//  RectangleView.swift
//  ARPaper
//
//  Created by Bartosz Swiety on 11/01/2022.
//

import Foundation
import UIKit

//
class RectangleShape: CAShapeLayer
{
    init(points: [CGPoint])
    {
        super.init()
        self.set(points: points)
        
        self.lineWidth = 2
        self.strokeColor = UIColor.red.cgColor
        self.fillColor = UIColor.red.cgColor
        self.opacity = 0.5
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
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
        }
    }
}

/// 2D Visulasization of Points with Label
class RectangleView
{
    let shape: RectangleShape
    let label: UILabel
    
    init(points: [CGPoint])
    {
        self.shape = RectangleShape(points: points)
        
        self.label = UILabel(frame: CGRect())
        self.label.textColor = .blue
        self.label.text = ""
    }

    public func removeFromSuperview()
    {
        self.shape.removeFromSuperlayer()
        self.label.removeFromSuperview()
    }
    
    // Updates Curve points.
    public func set(points: [CGPoint])
    {
        // Curve
        self.shape.set(points: points)
        
        // Label
        self.label.frame = CGRect(x: points[3].x, y: points[2].y, width: 200, height: 100)
        self.label.textAlignment = .center
    }
}
