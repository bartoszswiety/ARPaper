//
//  Rectangle.swift
//  ARPaper
//
//  Created by Bartosz Swiety on 11/01/2022.
//

import ARKit
import Foundation
import UIKit

class Rectangle
{
    private var points: [CGPoint]
    private var positions: [SCNVector3]?
    
    private var pointNodes: [SCNNode] = []
    
    public var rectangleView: RectangleView
    public var node = SCNNode()
    
    init(points: [CGPoint])
    {
        self.rectangleView = RectangleView(points: points)
        self.points = points
        self.set(points: points)
    }
    
    func pointNode(position: SCNVector3) -> SCNNode
    {
        let sphere = SCNSphere(radius: 0.005)
        sphere.firstMaterial!.diffuse.contents = UIColor.green
        let newNode = SCNNode(geometry: sphere)
        
        self.node.addChildNode(newNode)
        return newNode
    }
}

extension Rectangle
{
    /// Set Points of rectangle to visualisation
    public func set(points: [CGPoint])
    {
        self.points = points
        self.rectangleView.set(points: points)
    }
    
    /// Set 3d Points of the rectangle to visualization
    public func set(positions: [SCNVector3])
    {
        self.positions = positions
        
        if self.pointNodes.count == 0
        {
            // Let's generate all pins points.
            self.pointNodes = positions.map
            {
                self.pointNode(position: $0)
            }
        }
        else
        {
            // Update pins positons;
            for (index, position) in positions.enumerated()
            {
                self.pointNodes[index].position = position
            }
        }
    }
}
