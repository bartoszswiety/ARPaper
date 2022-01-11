//
//  Rectangle.swift
//  ARPaper
//
//  Created by Bartosz Swiety on 11/01/2022.
//

import ARKit
import Foundation
import UIKit

/// AR Rectangle with 2D Layer and 3D Pin Nodes.
class Rectangle
{
    private var points: [CGPoint]
    private var positions: [SCNVector3]?
    private var pointNodes: [SCNNode] = []

    public var rectangleView: RectangleView
    public var node = SCNNode()

    /// Real Size of the Rectangle in Centimeters.
    public var realSize = CGSize(width: 0, height: 0)
    {
        didSet
        {
            self.updateRealSizeText()
        }
    }

    init(points: [CGPoint])
    {
        self.rectangleView = RectangleView(points: points)
        self.points = points
        self.set(points: points)
    }

    func removeFromSuperview()
    {
        self.rectangleView.removeFromSuperview()
        self.node.removeFromParentNode()
    }

    /// Visualisation for Corner.
    func pointNode(position: SCNVector3) -> SCNNode
    {
        let sphere = SCNSphere(radius: 0.005)
        sphere.firstMaterial!.diffuse.contents = UIColor.red
        let newNode = SCNNode(geometry: sphere)

        self.node.addChildNode(newNode)
        return newNode
    }

    func updateRealSizeText()
    {
        // Not supposed to be here. - let's use Combine in the future.
        self.rectangleView.label.text = "\(self.realSize.width) CM x \(self.realSize.height) CM"
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

        calculateRealSize()
    }
}

extension Rectangle
{
    /// Calculates real size.
    func calculateRealSize()
    {
        /*
         [3] D--------A [0]
             |        |
             |        |
         [2] C--------B [1]
             */

        if let positions = self.positions
        {
            let A = positions[0]
            let B = positions[1]
            let C = positions[2]

            let width = round(A.distance(to: B) * 10000) / 100
            let height = round(B.distance(to: C) * 10000) / 100

            self.realSize = CGSize(width: width, height: height)
        }
    }
}
