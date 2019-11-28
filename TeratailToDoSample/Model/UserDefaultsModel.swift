//
//  UserDefaultsModel.swift
//  TeratailToDoSample
//
//  Created by 山田隼也 on 2019/11/28.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import UIKit

struct UserDefaultsModel {
    
    // MARK: UserDefaults Key
    
    private let kStoredMemosKey: String = "kStoredMemosKey"
    
    // MARK: Memo
    
    func saveMemos(_ memo: [Memo]) {
        guard let data = try? JSONEncoder().encode(memo) else { return }
        UserDefaults.standard.set(data, forKey: kStoredMemosKey)
    }
    
    func loadMemos() -> [Memo]? {
        guard let data = UserDefaults.standard.data(forKey: kStoredMemosKey),
            let storedMemos = try? JSONDecoder().decode([Memo].self, from: data) else { return nil }
        return storedMemos
    }
    
    // MARK: Image
    
    func saveImage(id: String, image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        UserDefaults.standard.set(imageData, forKey: id)
    }
    
    func loadImage(id: String) -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: id) else { return nil }
        return UIImage(data: data)
    }
}
