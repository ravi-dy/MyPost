//
//  DetailVM.swift
//  MyPosts
//

import Foundation

protocol DetailVMDelegate: AnyObject {
    func detailVMDidUpdate(_ viewModel: DetailVM)
}

final class DetailVM {

    init(_ id : Int) {
        requestDetailWebService(id)
    }

    var delegate: DetailVMDelegate?

    private var comments: [CommentModel] = [] {
        didSet {
            delegate?.detailVMDidUpdate(self)
        }
    }

    var detailCount: Int {
        return comments.count
    }

    func detail(at index: Int) -> CommentModel {
        return comments[index]
    }

    /// Variables property
    func requestDetailWebService(_ id : Int) {
        WSManager.shared.getComments(id){ res in
            switch(res){
                case .success(let response):
                    self.comments = response
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func searchText(_ searchText : String) ->[CommentModel]{
        let predicate = NSPredicate(format: "SELF contains %@", searchText.lowercased())
        let searchDataSource = comments.filter { predicate.evaluate(with: $0.name.lowercased()) }
        return searchDataSource
    }

}
