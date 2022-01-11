//
//  ViewController+AR.swift
//  ARPaper
//
//  Created by Bartosz Swiety on 11/01/2022.
//

import ARKit

extension ViewController {
    func initAR() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        sceneView.session.run(configuration)
        sceneView.scene = SCNScene()
        self.vision.delegate = self
    }
    
    func analyze3DCorodinates(points: [CGPoint]) -> [SCNVector3]? {
        var positions: [SCNVector3] = []
        
        for point in points {
            // Make raycast query for 2D CGPoint
            let query = sceneView.raycastQuery(from: point, allowing: .existingPlaneGeometry, alignment: .any)
            
            if let validQuery: ARRaycastQuery = query {
                let result: [ARRaycastResult] = sceneView.session.raycast(validQuery)
                
                // Check if we have any hits.
                guard let rayCast: ARRaycastResult = result.first
                else {
                    // Nothig?
                    return nil
                }

                // Transponse Raycast worldMatrix to Vector3.
                positions.append(SCNVector3(rayCast.worldTransform.columns.3.x,
                                            rayCast.worldTransform.columns.3.y,
                                            rayCast.worldTransform.columns.3.z))
            }
        }
        
        print("Positions Calculated")
        // We analyzed all positions - let's put it back.
        return positions
    }
}

extension ViewController: VisionDelegate {
    func onDetected(rectangle: VNRectangleObservation) {
        print("Rectangle Detected")
        
        DispatchQueue.main.async {
            /// Vector Transfromations from Camera buffer to view.
            let displayTransformation = self.sceneView.displayTransform()
            let scaleTransformation = self.sceneView.scaleTransform()
        
            var bounds = [rectangle.topRight, rectangle.bottomRight, rectangle.bottomLeft, rectangle.topLeft]
            bounds = bounds.map { $0.applying(displayTransformation).applying(scaleTransformation) }
            
            self.drawRectangle(points: bounds)
        }
    }

    func onLost() {
        DispatchQueue.main.async {
            self.clearRectangle()
        }
    }
    
    func scene() -> ARSCNView {
        return self.sceneView
    }
}
