//
//  PostVC.swift
//  MyPosts
//

import UIKit

enum Const {
    static let prototypeCell = "postcell"
    static let commentCell = "commentCell"
}

class PostVC: UIViewController {
    
    @IBOutlet weak var tblPost: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {
        tblPost.dataSource = self
        tblPost.delegate = self
    }

}

// MARK: - 🆗 Table View 💢  Data source 💢
extension PostVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: Const.prototypeCell, for: indexPath)
        postCell.textLabel?.text = "Title"
        postCell.detailTextLabel?.text = "Detail"
        return postCell
    }
}

// MARK: - 🆗 Table View 💢 Delegate 💢
extension PostVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
