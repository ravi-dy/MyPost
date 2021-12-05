//
//  DetailVC.swift
//  MyPosts
//


import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var tblComment: UITableView!
    var postID : Int?



    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    func configureUI() {
        tblComment.dataSource = self
        tblComment.delegate = self
    }
}


// MARK: - 🆗 Table View 💢  Data source 💢
extension DetailVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 4
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: Const.commentCell, for: indexPath)
       
            postCell.textLabel?.text = "Detail comment"
            postCell.detailTextLabel?.text = "Detail comment body"
        return postCell
    }
}
// MARK: - 🆗 Table View 💢 Delegate 💢
extension DetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

