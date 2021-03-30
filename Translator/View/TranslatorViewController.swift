//
//  TranslatorViewController.swift
//  Translator
//
//  Created by Dastan Mambetaliev on 28/3/21.
//
import Network
import SwiftGoogleTranslate
import UIKit

class TranslatorViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var inputImageView: UIImageView!
    @IBOutlet weak var translatedImageView: UIImageView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var translatedView: UIView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var enterTextView: UITextView!
    @IBOutlet weak var translatedTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
//        Need a Google Cloud API key
        SwiftGoogleTranslate.shared.start(with: "API_KEY_HERE")
    }
    
    func configureUI() {
        configureNavBar(bar: self.navigationController!)
        overView.layer.cornerRadius = 5
        overView.layer.masksToBounds = true
        translatedView.layer.cornerRadius = 5
        translatedView.layer.masksToBounds = true
        
        translateButton.layer.cornerRadius = 5
        translateButton.layer.masksToBounds = true
    }
    
    func configureNavBar(bar: UINavigationController) {
        bar.navigationBar.barTintColor = #colorLiteral(red: 0.4509803922, green: 0.8823529412, blue: 0.8823529412, alpha: 1)
        bar.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    var countingTap = 1
    @IBAction func translateButtonDidTap(_ sender: UIButton) {
        let itemsToTranslate = enterTextView.text
        SwiftGoogleTranslate.shared.translate("\(itemsToTranslate)", "en", "ru") { (text, error) in
          if let t = text {
            print(t)
            DispatchQueue.main.async {
                self.setTranslatedItems(translate: t)
            }
          }
        }
        
        countingTap += 1
        
        if countingTap % 2 == 0 {
            inputImageView.image = UIImage(named: "unitedKingdom")
            translatedImageView.image = UIImage(named: "russia")
        } else {
            inputImageView.image = UIImage(named: "russia")
            translatedImageView.image = UIImage(named: "unitedKingdom")
        }
    }
    
    @IBAction func speechButtonDidTap(_ sender: UIButton) {
        translatedTextView.resignFirstResponder()
        SpeechService.shared.startSpeech(translatedTextView.text)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        textView.text = nil
//    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == enterTextView {
            translateItems(inputItem: textView)
        }
    }
    
    func translateItems(inputItem: UITextView) {
        let itemToTranslate = inputItem
        SwiftGoogleTranslate.shared.translate("\(itemToTranslate)", "ru", "en") { (text, error) in
          if let t = text {
            print(t)
            DispatchQueue.main.async {
                self.setTranslatedItems(translate: t)
            }
          }
        }
    }
    
    func setTranslatedItems(translate: String) {
        translatedTextView.text = translate
        addItemToData()
    }
     
    func addItemToData() {
        let translatedItem = TranslatedItems()
        translatedItem.russianText = enterTextView.text
        translatedItem.englishText = translatedTextView.text
        HistoryManager.sharedInstance.addData(object: translatedItem)
    }
}
