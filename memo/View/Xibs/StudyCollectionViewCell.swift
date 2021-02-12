//
//  StudyCollectionViewCell.swift
//  memo
//
//  Created by Elias Ferreira on 09/02/21.
//  Copyright © 2021 Academy IFCE. All rights reserved.
//

import UIKit

class StudyCollectionViewCell: UICollectionViewCell {

    // Items
    @IBOutlet weak var mainFrame: UIView!
    @IBOutlet weak var card: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Style.
        mainFrame.backgroundColor = .clear
        card.layer.cornerRadius = 22
        mainFrame.layer.shadowColor = UIColor.black.cgColor
        mainFrame.layer.shadowOpacity = 0.20
        mainFrame.layer.shadowRadius = 4
        mainFrame.layer.shadowOffset = .init(width: 1, height: 3)
    }

    // Prepare the cell for reuse at the table.
    override func prepareForReuse() {
        titleLabel.text = nil
        bodyLabel.text = nil
    }

    func configure(collection: Collection) {
        var study: Int = 0

        for card in collection.cards?.allObjects as! [Card] {
            if DateHelper.isToday(dateString: card.nextStudyDay!) {
                study += 1
            }
        }

        self.titleLabel.text = collection.name
        self.bodyLabel.text = String("\(study) para estudar")
    }

}
