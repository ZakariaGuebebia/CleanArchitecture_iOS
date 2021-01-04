//
//  PresentationHelper.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 23/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation
import Combine

typealias StateHandler = ((Subscribers.Completion<Error>) -> Void)
//Sink now returns an AnyCancellable, which automatically
//cancels the subscription on when cancel is called or
//when the cancellable deinits.
var cancellable = Set<AnyCancellable>()
enum ViewModelLoadingState {
    case loading
    case finishedLoading
    case error(CPError)
}
