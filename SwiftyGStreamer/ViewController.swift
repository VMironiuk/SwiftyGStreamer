//
//  ViewController.swift
//  SwiftyGStreamer
//
//  Created by Vladimir Mironiuk on 06.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var label: UILabel!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gstBackend = GStreamerBackend()
        label.text = "Welcome to \(gstBackend.getGStreamerVersion() ?? "")!"
    }
}

