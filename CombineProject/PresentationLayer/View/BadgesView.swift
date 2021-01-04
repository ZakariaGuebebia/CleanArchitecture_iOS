//
//  BadgesView.swift
//  CombineProject
//
//  Created by zakaria.guebebia on 23/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct BadgesView: View {
      
      var viewModel: DefaultBadgesViewModel
    
      @State private var badges: [Badge]?
    
      var body: some View {
          VStack(alignment: .center, spacing: 20) {
              Text("Which badge do you have ?")
                Button(action: {
                  self.viewModel.loadBadges()
                  }) {
                      Text("load Badges")
                }
            
            ScrollView(.horizontal,showsIndicators:false) {

                HStack {
                    ForEach(badges ?? [], id: \.self) { badge in
                        
                        VStack {
                            WebImage(url: URL(string: badge.photo ?? ""))
                                .resizable()
                                .frame(width: getFormattedSize(100), height: getFormattedSize(100))
                                .aspectRatio(1, contentMode: .fit)
                            Text(badge.name ?? "")
                        }.padding()
                        
                    }
                }
            }
          }
          .onAppear {
              self.bind(to: self.viewModel)
          }
      }
      
      func bind(to viewModel: DefaultBadgesViewModel?) {
          viewModel?.badges?.sink { (badges) in
              self.badges = badges
          }.store(in: &cancellable)
          
          viewModel?.state?.sink { (state) in
              switch state {
              case .loading:
                  break
              case .finishedLoading:
                  break
              case .error:
                  break
              }
          }.store(in: &cancellable)
      }
}


struct BadgesView_Previews: PreviewProvider {
     static var previews: some View {
           BadgesView(viewModel: DefaultBadgesViewModel(fetchBadgesUseCase: DefaultFetchBadgesUseCase(badgeRepository: DefaultBadgeRepository())))
       }
}
