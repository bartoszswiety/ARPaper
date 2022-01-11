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
    private var rectangle: RectangleView?

    override func viewDidLoad() {
        super.viewDidLoad()
        initAR()
    }

    /// Visualizes Rectangle in Scene View Layer
    public func drawRectangle(points: [CGPoint]) {
        CATransaction.begin()
        print("Draw")
        if let rectangle = rectangle {
            rectangle.set(points: points)
        }
        else {
            self.rectangle = RectangleView(points: points)

            self.sceneView.layer.addSublayer(rectangle!)
        }
        CATransaction.commit()
    }
}
