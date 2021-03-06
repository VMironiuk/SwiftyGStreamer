//
//  ViewController.swift
//  SwiftyGStreamer
//
//  Created by Vladimir Mironiuk on 06.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var playButton: UIBarButtonItem!
    @IBOutlet private weak var pauseButton: UIBarButtonItem!
    @IBOutlet private weak var videoView: UIView!
    @IBOutlet private weak var videoContainerView: UIView!
    @IBOutlet private weak var videoWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var videoHeightConstraint: NSLayoutConstraint!
    
    private var gstreamerBackend: GStreamerBackend!
    
    private let mediaWidth: CGFloat = 320
    private let mediaHeight: CGFloat = 240
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let viewWidth = videoContainerView.bounds.size.width
        let viewHeight = videoContainerView.bounds.size.height

        let correctWidth = viewHeight * mediaWidth / mediaHeight
        let correctHeight = viewWidth * mediaHeight / mediaWidth

        if (correctHeight < viewHeight) {
            videoHeightConstraint.constant = correctHeight;
            videoWidthConstraint.constant = viewWidth;
        } else {
            videoWidthConstraint.constant = correctWidth;
            videoHeightConstraint.constant = viewHeight;
        }
    }
    
    // MARK: - Actions
    
    @IBAction func playAction(_ sender: UIBarButtonItem) {
        gstreamerBackend.play()
    }
    
    @IBAction func pauseAction(_ sender: UIBarButtonItem) {
        gstreamerBackend.pause()
    }
    
    // MARK: - Private
    
    private func setup() {
        playButton.isEnabled = false
        pauseButton.isEnabled = false
        
        gstreamerBackend = GStreamerBackend(self, videoView: videoView)
    }
}

// MARK: - GstreamerBackendDelegate

extension ViewController: GStreamerBackendDelegate {
    
    func gstreamerInitialized() {
        DispatchQueue.main.async {
            self.playButton.isEnabled = true
            self.pauseButton.isEnabled = true
            self.messageLabel.text = "Ready"
        }
    }
    
    func gstreamerSetUIMessage(_ message: String!) {
        DispatchQueue.main.async {
            self.messageLabel.text = message
        }
    }
}

