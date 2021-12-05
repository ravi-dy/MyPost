//
//  DetailVC.swift
//  MyPosts
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblComment: UITableView!
    var postID : Int?
    var searchActive : Bool = false

    private lazy var detailVM: DetailVM = {
        return .init(postID ?? 0)
    }()
    
    private var filterComments: [CommentModel] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    func configureUI() {
        self.detailVM.delegate = self
        tblComment.dataSource = self
        tblComment.delegate = self
        searchBar.delegate = self
    }
}

extension DetailVC: DetailVMDelegate {
    func detailVMDidUpdate(_ viewModel: DetailVM) {
        DispatchQueue.main.async {
            self.tblComment.reloadData()
        }
    }
}
// MARK: - 🆗 Table View 💢  Data source 💢
extension DetailVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filterComments.count
        }
        return detailVM.detailCount
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: Const.commentCell, for: indexPath)
        if(searchActive) {
            let model = filterComments[indexPath.row]
            postCell.textLabel?.text = "\(model.name)" + "(\(model.email))"
            postCell.detailTextLabel?.text = model.body
        } else {
            let model = detailVM.detail(at: indexPath.row)
            postCell.textLabel?.text = "\(model.name)" + "(\(model.email))"
            postCell.detailTextLabel?.text = model.body
        }
        return postCell
    }
}
// MARK: - 🆗 Table View 💢 Delegate 💢
extension DetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DetailVC: UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty)
        {
            filterComments.removeAll()
            searchActive = false;
        } else {
            searchActive = true;
            filterComments = detailVM.searchText(searchText)
        }
        DispatchQueue.main.async {
            self.tblComment.reloadData()
        }
    }
}
