//
//  SceneView.swift
//  ARPaper
//
//  Created by Bartosz Swiety on 11/01/2022.
//

import ARKit

extension ARSCNView
{
    /**
     Returns a display transform layer provided viewport size and Screen orientation.
     
     @discussion The display transform can be used to convert normalized points in the image-space coordinate system
     of the captured image to normalized points in the view’s coordinate space. The transform provides the correct rotation
     and aspect-fill for presenting the captured image in the given orientation and size.
     */
    func displayTransform() -> CGAffineTransform
    {
        let orientation = UIApplication.shared.statusBarOrientation
        return self.session.currentFrame!.displayTransform(for: orientation, viewportSize: self.bounds.size)
    }
    
    func scaleTransform() -> CGAffineTransform
    {
        return CGAffineTransform(scaleX: self.bounds.width, y: self.bounds.height)
    }
}
