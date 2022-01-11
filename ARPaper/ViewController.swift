//
//  ViewController.swift
//  ARPaper
//
//  Created by Bartosz Swiety on 11/01/2022.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    private var vision:Vision = Vision();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAR()
        vision.delegate = self;
    }
}


