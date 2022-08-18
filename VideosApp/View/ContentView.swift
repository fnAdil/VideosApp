//
//  ContentView.swift
//  VideosApp
//
//  Created by Adil Özdemir on 17.08.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var videoVM = VideoViewModel()
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ForEach(Query.allCases, id: \.self) { query in
                        QueryTag(query: query, isSelected: query == videoVM.selectedCategory)
                            .onTapGesture {
                                videoVM.selectedCategory = query
                            }
                    }
                }

                if videoVM.videos.isEmpty {
                    ProgressView().frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)

                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(videoVM.videos, id: \.id) { video in

                                NavigationLink {
                                    VideoView(video: video)
                                } label: {
                                    VideoCard(video: video)
                                }
                            }.padding()
                        }

                    }.frame(maxWidth: .infinity)
                }
            }.background(Color("AccentColor"))
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
