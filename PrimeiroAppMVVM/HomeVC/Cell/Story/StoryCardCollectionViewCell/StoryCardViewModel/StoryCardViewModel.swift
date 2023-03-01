//
//  StoryCardHomeViewCellViewModel.swift
//  PrimeiroAppMVVM
//
//  Created by Igor Fortti on 16/02/23.
//

import UIKit

class StoryCardViewModel {
    
    private var listStory: [Stories]
    
    init(listStory: [Stories]) {
        self.listStory = listStory
    }
    
    public var numberOfItems: Int {
        listStory.count
    }
    
    func loudCurrentStory (indexPath: IndexPath) -> Stories {
        listStory[indexPath.row]
    }
    
}
