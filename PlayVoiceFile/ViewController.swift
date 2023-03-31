//
//  ViewController.swift
//  PlayVoiceFile
//
//  Created by 김재훈 on 2023/03/15.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    var player: AVAudioPlayer?
    
    var btn: UIButton = {
        let b = UIButton(frame: CGRect(x: 50, y: 100, width: 200, height: 70))
        b.backgroundColor = .black
        b.setTitle("stop/play", for: .normal)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        
    }
    
    @objc func btnAction() {
        print("touched.")
        if player == nil {
            playSound()
        } else {
            player?.stop()
            player = nil
        }
    }
    
    func playSound() {
        // "voice.m4a" -> Check "Target Membership", so url below is not nil.
        guard let url = Bundle.main.url(forResource: "voice", withExtension: "m4a") else {
            print("no file.")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            
            guard let player = player else {
                return
            }
            
            player.prepareToPlay()
            player.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("audio ended.")
    }

}

