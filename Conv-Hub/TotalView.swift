//
//  TotalView.swift
//  Conv-Hub
//
//  Created by fox on 2022/7/22.
//

import Foundation
import SwiftUI

struct TotalDataItemView: View {
    var title: String
    var number: Int
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .foregroundColor(.white)
                Text("\(number)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .padding()
        .background(.black)
        .cornerRadius(20)
        .padding(.leading)
        .padding(.trailing)
    }
}

struct TotalDataItemView_Previews: PreviewProvider {
    static var previews: some View {
        TotalDataItemView(title: "标题", number: 123)
    }
}


