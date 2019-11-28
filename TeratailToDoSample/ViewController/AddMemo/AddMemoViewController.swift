//
//  AddMemoViewController.swift
//  TeratailToDoSample
//
//  Created by 山田隼也 on 2019/11/28.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import UIKit
import Photos

final class AddMemoViewController: UITableViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Properties
    
    private let model = UserDefaultsModel()
    
    // MARK: Lifecycle
    
    static func instance() -> AddMemoViewController {
        let vc = UIStoryboard(name: "AddMemoViewController", bundle: nil).instantiateInitialViewController() as! AddMemoViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - Configure

extension AddMemoViewController {
    
    private func configureUI() {
        tableView.delegate = self
        navigationItem.title = "メモを追加"
    }
}

// MARK: - Model

extension AddMemoViewController {
    
    private func saveMemo() {
        guard let title = titleTextField.text,
            let content = contentTextField.text else { return }
        
        // Save memo
        let memo = Memo(id: UUID().uuidString, title: title, content: content)
        if let storedMemos = model.loadMemos() {
            var newMemos = storedMemos
            newMemos.append(memo)
            model.saveMemos(newMemos)
        } else {
            model.saveMemos([memo])
        }
        
        // Save image
        if let image = imageView.image {
            model.saveImage(id: memo.id, image: image)
        }
        
        // Pop
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TableView delegate

extension AddMemoViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 2:
            presentImagePicker()
        case 3:
            saveMemo()
        default:
            break
        }
    }
}

// MARK: - ImagePicker delegate

extension AddMemoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        defer {
            picker.dismiss(animated: true, completion: nil)
        }
        guard let image = info[.originalImage] as? UIImage else { return }
        imageView.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
