//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by McLean Anderson on 3/2/15.
//  Copyright (c) 2015 McLean Anderson. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
   // var audioPlayer2:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
            audioPlayer.enableRate = true
//        audioPlayer2 = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
//        audioPlayer2.enableRate = true

        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    @IBAction func playAudioWithReverb(sender: UIButton) {
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        playAudioWithVariableReverb(25)
    }
    func playAudioWithVariableReverb(reverb: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changeDelayEffect = AVAudioUnitDelay()
        changeDelayEffect.wetDryMix = reverb
        audioEngine.attachNode(changeDelayEffect)
        
        audioEngine.connect(audioPlayerNode, to: changeDelayEffect, format: nil)
        audioEngine.connect(changeDelayEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    @IBAction func playAudioWithEcho(sender: UIButton) {
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        playAudioWithVariableDelay(0.3)
    }
    func playAudioWithVariableDelay(delay: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changeDelayEffect = AVAudioUnitDelay()
        changeDelayEffect.delayTime = NSTimeInterval(delay)
        audioEngine.attachNode(changeDelayEffect)
        
        audioEngine.connect(audioPlayerNode, to: changeDelayEffect, format: nil)
        audioEngine.connect(changeDelayEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    @IBAction func playChipmunkAudio(sender: UIButton) {
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        playAudioWithVariablePitch(1000)
    }
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    @IBAction func stopAudio(sender: UIButton) {
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
       @IBAction func playDarthvaderAudio(sender: UIButton) {
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        playAudioWithVariablePitch(-1000)
    }
    @IBAction func playFastAudio(sender: UIButton) {
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 2.0
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    @IBAction func playSlowAudio(sender: UIButton) {
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
