//
//  MemoListCell.swift
//  TeratailToDoSample
//
//  Created by 山田隼也 on 2019/11/28.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import UIKit

class MemoListCell: UITableViewCell {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    
    // MARK: Static properties
    
    static let reuseIdentifier = "MemoListCell"
    static let rowHeight: CGFloat = 60
    static var nib: UINib {
        return UINib(nibName: "MemoListCell", bundle: nil)
    }

    // MARK: Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Setup
    
    func setupCell(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
}
