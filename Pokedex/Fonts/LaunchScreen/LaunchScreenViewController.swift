//
//  LaunchScreenViewController.swift
//  Gotcha
//
//  Created by Majka on 01/01/2023.
//

import UIKit
import AVFoundation
import AVKit

protocol LaunchScreenViewControllerDelegate: AnyObject {
    func onAnimationFinished()
}

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    weak var delegate: LaunchScreenViewControllerDelegate?
    let playerController = AVPlayerViewController()
    var player: AVPlayer?

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("Launch screen dead")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sleep(1)
        playVideo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preparePlayer()
    }
    
    func preparePlayer() {
        guard let path = Bundle.main.path(forResource: "LaunchVideo", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        playerController.view.backgroundColor = UIColor(named: Constants.Colors.customRed)
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        self.player = player
        addChild(playerController)
        containerView.addSubview(playerController.view)
        playerController.view.frame = containerView.bounds
        playerController.entersFullScreenWhenPlaybackBegins = false
        playerController.showsPlaybackControls = false
        playerController.player = player
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerController.player?.currentItem)
    }
    
    private func playVideo() {
        
        player?.play()
      
    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
        NotificationCenter.default.removeObserver(self)
        delegate?.onAnimationFinished()
        
    }

}
