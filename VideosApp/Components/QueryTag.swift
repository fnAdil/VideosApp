//
//  QueryTag.swift
//  VideosApp
//
//  Created by Adil Özdemir on 17.08.2022.
//

import SwiftUI

struct QueryTag: View {
    var query: Query
    var isSelected: Bool
    var body: some View {
        Text(query.rawValue)
            .font(.caption)
            .foregroundColor(isSelected ? .black: .gray)
            .padding(10)
            .background(.thinMaterial)
            .cornerRadius(10)
    }
}

struct QueryTag_Previews: PreviewProvider {
    static var previews: some View {
        QueryTag(query: Query.nature, isSelected: true)
    }
}
