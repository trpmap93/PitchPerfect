//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by RAP on 8/6/15.
//  Copyright © 2015 RAP. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl!, error: nil)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
       
    }
    

    @IBAction func playSlow(sender: UIButton) {
        audioPlayer.rate = (0.5)
        playMaster()
    }
    
    
    @IBAction func playFast(sender: UIButton) {
        audioPlayer.rate = (2.0)
        playMaster()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        pitchMaster(1000)
        
        //sets pitch to "chipmunk" level
        
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        pitchMaster(-1000)
        
        // Sets pitch to Darth Vader type level
        
    }
    
    func playMaster() {
        resetAudio()
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
        //stops the fast or slow playing audio and then restarts and plays on the selected choice
        
    }
    
    @IBAction func stopPlay(sender: UIButton) {
        resetAudio()
    }
    
    func pitchMaster(pitchVal: Float) {
        
        // function that accepts a pitch value and replays recording using the pitch chosen
        // when voice changing button is pressed, stops and resets the audioEngine
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        resetAudio()
        
        var changePitchEffect = AVAudioUnitTimePitch()
       changePitchEffect.pitch = pitchVal
       audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }
    
    func resetAudio(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
    }
 
}
