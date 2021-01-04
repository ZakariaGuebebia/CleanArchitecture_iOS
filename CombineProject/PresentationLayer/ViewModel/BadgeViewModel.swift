//
//  BadgeViewModel.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 19/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation
import Combine

//actions & requests (View -> ViewModel)
protocol BadgeViewModelInput {
    func loadBadges()
}
//infos & datas (ViewModel -> View)
protocol BadgeViewModelOutput {
    var state : PassthroughSubject<ViewModelLoadingState,Never>? { get }
    var badges: PassthroughSubject<[Badge],Never>? { get }
}
protocol BadgesViewModel : ObservableObject,BadgeViewModelInput,BadgeViewModelOutput {}

final class DefaultBadgesViewModel: BadgesViewModel {

    // MARK: - OUTPUT
    var state: PassthroughSubject<ViewModelLoadingState,Never>?
    var badges: PassthroughSubject<[Badge],Never>?
    // MARK: - USECASE
    var fetchBadgesUseCase: FetchBadgesUseCase
    
    // MARK: - Init
    internal init(state: PassthroughSubject<ViewModelLoadingState,Never> = PassthroughSubject(), badges: PassthroughSubject<[Badge],Never>? = PassthroughSubject(), fetchBadgesUseCase: FetchBadgesUseCase) {
        self.state = state
        self.badges = badges
        self.fetchBadgesUseCase = fetchBadgesUseCase
    }
    // MARK: - INPUT
    func loadBadges() {
        
        let stateHandler : StateHandler = { (result) in
            switch result {
            case .finished:
                self.state?.send(.finishedLoading)
            case .failure(let error):
                self.state?.send(.error(error as! CPError))
            }
        }
        let receiveValue: ([BadgeDTO], [Badge]) -> Void = { (_,badges) in
            self.badges?.send(badges)
        }
        
        fetchBadgesUseCase.execute().sink(receiveCompletion: stateHandler, receiveValue: receiveValue).store(in: &cancellable)
    }
}
