//
//  HistoryCell.swift
//  Translator
//
//  Created by Dastan Mambetaliev on 26/3/21.
//

import UIKit

class HistoryCell: UICollectionViewCell {

    @IBOutlet weak var russianTextView: UITextView!
    @IBOutlet weak var englishTextView: UITextView!
    @IBOutlet weak var voiceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func addText(item: TranslatedItems) {
        russianTextView.text = item.russianText
        englishTextView.text = item.englishText
    }

    @IBAction func voiceButtonDidTap(_ sender: UIButton) {
        
    }
}
