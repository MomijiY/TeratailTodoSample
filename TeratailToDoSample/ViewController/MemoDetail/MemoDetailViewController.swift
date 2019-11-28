//
//  MemoDetailViewController.swift
//  TeratailToDoSample
//
//  Created by 山田隼也 on 2019/11/28.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import UIKit

final class MemoDetailViewController: UITableViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Properties
    
    private let model = UserDefaultsModel()
    private var memo: Memo!
    
    // MARK: Lifecycle
    
    static func instance(_ memo: Memo) -> MemoDetailViewController {
        let vc = UIStoryboard(name: "MemoDetailViewController", bundle: nil).instantiateInitialViewController() as! MemoDetailViewController
        vc.memo = memo
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - Configure

extension MemoDetailViewController {
    
    private func configureUI() {
        // - Navigation
        navigationItem.title = "メモ詳細"
        // - Label
        titleLabel.text = memo.title
        contentLabel.text = memo.content
        // - ImageView
        if let image = model.loadImage(id: memo.id) {
            imageView.image = image
        }
    }
}
