//
//  AudioPlayer.swift
//  Restart
//
//  Created by Ravi Kiran HR on 28/06/25.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playAudio(sound: String, type: String = "mp3") {
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
          audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
          audioPlayer?.play()
      } catch {
          print("Error playing audio file")
      }
    }
}
