//
//  MemoListViewController.swift
//  TeratailToDoSample
//
//  Created by 山田隼也 on 2019/11/28.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import UIKit

final class MemoListViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    private let model = UserDefaultsModel()
    private var dataSource: [Memo] = [Memo]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: Lifecycle
    
    static func instance() -> MemoListViewController {
        let vc = UIStoryboard(name: "MemoListViewController", bundle: nil).instantiateInitialViewController() as! MemoListViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMemos()
    }
    
    // MARK: IBAction
    
    @objc
    private func onTapAddButton(_ sender: UIBarButtonItem) {
        let vc = AddMemoViewController.instance()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Configure

extension MemoListViewController {
    
    private func configureUI() {
        navigationItem.title = "メモ一覧"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onTapAddButton(_:)))
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = MemoListCell.rowHeight
        tableView.register(MemoListCell.nib, forCellReuseIdentifier: MemoListCell.reuseIdentifier)
    }
}

// MARK: - Model

extension MemoListViewController {
    
    private func loadMemos() {
        guard let memos = model.loadMemos() else { return }
        self.dataSource = memos
    }
}

// MARK: - TableView dataSource, delegate

extension MemoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoListCell.reuseIdentifier, for: indexPath) as! MemoListCell
        let memo = dataSource[indexPath.row]
        cell.setupCell(title: memo.title, content: memo.content)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let memo = dataSource[indexPath.row]
        let vc = MemoDetailViewController.instance(memo)
        navigationController?.pushViewController(vc, animated: true)
    }
}
