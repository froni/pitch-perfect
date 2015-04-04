//
//  PlaySoundsViewController.swift
//  pitchPerfect
//
//  Created by Nikos Fronimakis on 4/1/15.
//  Copyright (c) 2015 Nikos Fronimakis. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer!
    var receivedAudio : RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile : AVAudioFile!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var stopPlayingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
// Do any additional setup after loading the view.
        
        stopPlayingButton.enabled=false
        
// Gets the files path and creates an audio player with that file
        audioPlayer = AVAudioPlayer(contentsOfURL:receivedAudio.filePathURL, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
        
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // Starts audio player with the common parameters for snail and kangaroo
    func newPlayerInstance(){
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime=0
        stopPlayingButton.enabled=true
        audioPlayer.play()
    }
    
    
    @IBAction func snailButton(sender: UIButton) {
        
        newPlayerInstance()
        audioPlayer.rate = 0.5
    }
    
    @IBAction func kangarooButton(sender: UIButton) {
        
        newPlayerInstance()
        audioPlayer.rate = 2
    }
    
    @IBAction func chipmankButton(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }

        
    @IBAction func darthVaderButton(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    //Function to add pitch on the recordings
    func playAudioWithVariablePitch(pitch:Float){
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
            stopPlayingButton.enabled=true
            audioPlayerNode.play()
        }
    
    
    @IBAction func stopPlayingButton(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        stopPlayingButton.enabled=false
    }
}
