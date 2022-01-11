//
//  Vision.swift
//  ARPaper
//
//  Created by Bartosz Swiety on 11/01/2022.
//

import ARKit
import CoreImage
import Foundation
import SceneKit
import Vision

class Vision
{
    private var timer: Timer?
    private var processing = false
    
    public var delegate: VisionDelegate?
    
    init()
    {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
                self?.update()
        })
    }
    
    /// Updates every 0.1 Seconds and looks for rectangles.
    func update()
    {
        guard !processing
        else
        {
            // Let's not overload with requests.
            return
        }
        
        guard let delegate = delegate
        else
        {
            return
        }
        
        if let image = delegate.scene().session.currentFrame?.capturedImage
        {
            processing = true
            
            let handler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .downMirrored)
            
            let request = VNDetectRectanglesRequest
            { request, error in

                guard error == nil
                else
                {
                    print("Error: \(error)")
                    self.processing = false;
                    return
                }
                self.onVision(request: request)
            }
            
            request.maximumObservations = 1
            request.minimumSize = 0.2
            request.minimumConfidence = 0.90
            request.usesCPUOnly = false
            
            DispatchQueue.global().async {
                do {
                    try handler.perform([request])
                } catch {
                    print("Error: request failed.")
                    self.processing = false;
                }
            }
        }
    }
    
    func onVision(request: VNRequest)
    {
        if let rectangle = request.results?.first as? VNRectangleObservation
        {
            print("On Rectangle Detected")
            delegate?.onDetected(rectangle: rectangle)
        }
        self.processing = false
    }
}

protocol VisionDelegate
{
    func onDetected(rectangle:VNRectangleObservation)
    func scene() -> ARSCNView
}
