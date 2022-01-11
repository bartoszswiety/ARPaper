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
            sceneView.layer.addSublayer(rectangle!.rectangleView)
            sceneView.scene.rootNode.addChildNode(rectangle!.node)
        }
        
//        drawSphere(points: points)
    }
    
    public func drawSphere(points: [CGPoint]) {
        print("Raycast Hit")
        let x = sceneView.raycastQuery(from: points[0], allowing: .existingPlaneGeometry, alignment: .any)
        
        if let nonOptQuery: ARRaycastQuery = x {
            let result: [ARRaycastResult] = sceneView.session.raycast(nonOptQuery)
            
            print("Jest coś?")
            guard let rayCast: ARRaycastResult = result.first
            else { return }

            print("Mamy Podłoże.")
            
//            let anchor = hit.anchor
//            let pos = hit.worldVector
            
            let world = SCNNode()
            
            let sphere = SCNSphere(radius: 0.01)
            sphere.firstMaterial!.diffuse.contents = UIColor.green
            
            let node = SCNNode(geometry: sphere)
            node.position = SCNVector3(rayCast.worldTransform.columns.3.x,
                                       rayCast.worldTransform.columns.3.y,
                                       rayCast.worldTransform.columns.3.z)
            
            world.addChildNode(node)
            
            sceneView.scene.rootNode.addChildNode(world)
            
            print("Surface baby")
        } else {
            print("No surface?")
        }
    }
}
