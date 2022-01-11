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
    
    func scene() -> ARSCNView {
        return self.sceneView
    }
}
