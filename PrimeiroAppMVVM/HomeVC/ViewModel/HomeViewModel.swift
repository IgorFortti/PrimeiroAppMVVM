//
//  HomeViewModel.swift
//  PrimeiroAppMVVM
//
//  Created by Igor Fortti on 16/02/23.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject {
    func success()
    func error()
}

class HomeViewModel {
    
    private var service: HomeService = HomeService()
    private var posts = [Posts]()
    private var story = [Stories]()
    private weak var delegate: HomeViewModelProtocol?
    
    public var getListPosts: [Posts] {
        posts
    }
    
    public var getListStory: [Stories] {
        story
    }
    
    public var numberOfItens: Int {
        2
    }
    
    public func delegate(delegate: HomeViewModelProtocol?) {
        self.delegate = delegate
    }
    
    public func sizeForItem(indexPath: IndexPath, frame: CGRect) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 120, height: frame.height)
        } else {
            return CGSize(width: frame.width - 120, height: frame.height)
        }
    }
    
    public func fetchAllRequest() {
        service.getHomeDataURLSession { homedata, error in
            if error == nil {
                self.posts = homedata?.posts ?? []
                self.story = homedata?.stories ?? []
                self.delegate?.success()
            } else {
                self.delegate?.error()
            }
        }
    }
}
