//
//  ViewController.swift
//  Knot Visualizer
//
//  Created by Karthik Dharmarajan on 7/25/20.
//  Copyright © 2020 Karthik Dharmarajan. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, SideBarDelegate {

    //ARView Outlets
    @IBOutlet var sceneView: ARSCNView!
    
    let nameOfKnotXMLFile : String = "Knots"
    
    public var topDistance : CGFloat{
         get{
            let barHeight = navigationController?.navigationBar.frame.height ?? 0
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            return barHeight + statusBarHeight
         }
    }
    
    var sideBar : SideBar = SideBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/Rope1.dae")!
        
        // Set the scene to the view
        sceneView.scene = scene
        sceneView.isUserInteractionEnabled = true
        
        setupSideBar()
        setupTapGesture()
    }
    
    func setupSideBar() {
        let parser : KnotParser = KnotParser(nameOfKnotXMLFile)
        parser.parse()
        sideBar = SideBar(sourceView: self.view,
                          sideBarItems: parser.knots, topDistance)
        sideBar.delegate = self
    }
    
    func setupTapGesture() {
        let oneFingerTapGestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleARViewTap))
        oneFingerTapGestureRecognizer.numberOfTapsRequired = 1
        oneFingerTapGestureRecognizer.numberOfTouchesRequired = 1
        sceneView.addGestureRecognizer(oneFingerTapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        
    }
    
    @IBAction func didTapMenu(){
        sideBar.showSideBar(!sideBar.isSideBarOpen)
    }
    
    @objc func handleARViewTap(recognizer : UITapGestureRecognizer){
        if sideBar.isSideBarOpen {
            sideBar.showSideBar(false)
        }
    }
}
