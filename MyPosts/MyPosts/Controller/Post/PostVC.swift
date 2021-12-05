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

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblPost: UITableView!
    var searchActive : Bool = false

    private lazy var postVM: PostVM = {
        return .init()
    }()

    private var filterPost: [PostModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    func configureUI() {
        self.postVM.delegate = self
        tblPost.dataSource = self
        tblPost.delegate = self
        searchBar.delegate = self
    }
}

extension PostVC: PostVMDelegate {
    func postVMDidUpdate(_ viewModel: PostVM) {
        DispatchQueue.main.async {
            self.tblPost.reloadData()
        }
    }
}

// MARK: - 🆗 Table View 💢  Data source 💢
extension PostVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filterPost.count
        }
        return postVM.postCount
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: Const.prototypeCell, for: indexPath)
        if(searchActive) {
            let model = filterPost[indexPath.row]
            postCell.textLabel?.text = model.title
            postCell.detailTextLabel?.text = model.body

        } else {
            let model = postVM.post(at: indexPath.row)
            postCell.textLabel?.text = model.title
            postCell.detailTextLabel?.text = model.body
        }
        return postCell
    }
}

// MARK: - 🆗 Table View 💢 Delegate 💢
extension PostVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailController = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC{
            let model = postVM.post(at: indexPath.row)
            detailController.postID = model.identifier
            self.navigationController?.pushViewController(detailController, animated: true)
        }
    }
}
extension PostVC: UISearchBarDelegate{
    
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
            filterPost.removeAll()
            searchActive = false;
        } else {
            searchActive = true;
            filterPost = postVM.searchText(searchText)
        }
        DispatchQueue.main.async {
            self.tblPost.reloadData()
        }
    }
}
