//
//  PostVM.swift
//  MyPosts
//

import Foundation

protocol PostVMDelegate: AnyObject {
    func postVMDidUpdate(_ viewModel: PostVM)
}

final class PostVM {

    init() {
        requestPostWebService()
    }

    var delegate: PostVMDelegate?

    private var posts: [PostModel] = [] {
        didSet {
            delegate?.postVMDidUpdate(self)
        }
    }

    var postCount: Int {
        return posts.count
    }

    func post(at index: Int) -> PostModel {
        return posts[index]
    }

    /// Variables property
    func requestPostWebService() {
        WSManager.shared.getPosts { res in
            switch(res){
                case .success(let response):
                    self.posts = response
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func searchText(_ searchText : String) ->[PostModel]{
        let predicate = NSPredicate(format: "SELF contains %@", searchText.lowercased())
        let searchDataSource = posts.filter { predicate.evaluate(with: $0.title.lowercased()) }
        return searchDataSource
    }

}
