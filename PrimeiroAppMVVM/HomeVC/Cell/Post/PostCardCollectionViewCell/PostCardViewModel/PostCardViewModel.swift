//
//  PostCardCollectionViewModel.swift
//  PrimeiroAppMVVM
//
//  Created by Igor Fortti on 16/02/23.
//

import UIKit

class PostCardViewModel {

    private var listPosts: [Posts]
    
    init(listPosts: [Posts]) {
        self.listPosts = listPosts
    }
    
    public var numberOfItems: Int {
        listPosts.count
    }
    
    public func loudCurrentStory (indexPath: IndexPath) -> Posts {
        listPosts[indexPath.row]
    }
}
