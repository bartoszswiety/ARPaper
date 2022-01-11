//
//  ViewController+AR.swift
//  ARPaper
//
//  Created by Bartosz Swiety on 11/01/2022.
//

import ARKit

extension ViewController
{
    func initAR()
    {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        sceneView.session.run(configuration)
    }
}

extension ViewController:VisionDelegate
{
    func onDetected(rectangle: VNRectangleObservation) {
      
    }
    
    func scene() -> ARSCNView {
        return self.sceneView
    }
}
