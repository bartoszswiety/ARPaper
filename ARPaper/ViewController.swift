//
//  ViewController.swift
//  ARPaper
//
//  Created by Bartosz Swiety on 11/01/2022.
//

import ARKit
import SceneKit
import UIKit

class ViewController: UIViewController {
    @IBOutlet var sceneView: ARSCNView!
    public var vision = Vision()
    public var rectangle: Rectangle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAR()
    }

    /// Visualizes Rectangle in Scene View Layer
    public func drawRectangle(points: [CGPoint]) {
        if let rectangle = rectangle {
            rectangle.set(points: points)
            
            if let vector = analyze3DCorodinates(points: points) {
                rectangle.set(positions: vector)
            }
        } else {
            rectangle = Rectangle(points: points)
            sceneView.layer.addSublayer(rectangle!.rectangleView.shape)
            sceneView.layer.addSublayer(rectangle!.rectangleView.label.layer)
            sceneView.scene.rootNode.addChildNode(rectangle!.node)
        }
    }
     
    public func clearRectangle()
    {
        if let rectangle = rectangle {
            self.rectangle = nil;
            rectangle.removeFromSuperview()
        }
    }
}
