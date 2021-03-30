//
//  SpeechService.swift
//  Translator
//
//  Created by Dastan Mambetaliev on 30/3/21.
//

import Foundation
import AVKit

class SpeechService: NSObject {
    
    static let shared = SpeechService()
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    func startSpeech(_ text: String) {
        self.stopSpeech()
        
//      определение языка преобладающего текста
        if let language = NSLinguisticTagger.dominantLanguage(for: text) {
            
            let utterance = AVSpeechUtterance()
            utterance.voice = AVSpeechSynthesisVoice(language: language)
            
            speechSynthesizer.speak(utterance)
        }
    }
    
    func stopSpeech() {
        speechSynthesizer.stopSpeaking(at: .immediate)
    }
}
