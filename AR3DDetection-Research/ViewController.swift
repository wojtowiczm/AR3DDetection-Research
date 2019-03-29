//
//  ViewController.swift
//  AR3DDetection-Research
//
//  Created by KISS digital on 29/03/2019.
//  Copyright © 2019 Michał Wójtowicz. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
    }
    
    private func setupScene() {
        sceneView.delegate = self
        sceneView.showsStatistics = true
        let scene = SCNScene(named: "art.scnassets/GameScene.scn")!
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        configuration.detectionObjects = ARReferenceObject.referenceObjects(inGroupNamed: "ObjectModels", bundle: Bundle.main)!
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        guard let objectAnchor = anchor as? ARObjectAnchor else { return node }
        let plane = SCNPlane(width: CGFloat(objectAnchor.referenceObject.extent.x * 0.5), height: CGFloat(objectAnchor.referenceObject.extent.y * 0.5))
        
        plane.firstMaterial?.diffuse.contents = infoScene(for: objectAnchor.referenceObject)
        plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(0, -1, 0), 0, 1, 0)
        plane.cornerRadius = plane.width / 8
        let planeNode = SCNNode(geometry: plane)
        let objectCenter = objectAnchor.referenceObject.center
        planeNode.position = SCNVector3Make(objectCenter.x, objectCenter.y + 0.2, objectCenter.z)
        node.addChildNode(planeNode)
        return node
    }
    
    func infoScene(for arObject: ARReferenceObject) -> SKScene {
        let scene = SKScene(fileNamed: "HelloScene.sks")!
     
        return scene
    }

    
}
