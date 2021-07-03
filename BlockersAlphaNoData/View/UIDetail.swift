//
//  UIDetail.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import SwiftUI

struct UIDetail: View {
    
    var blocker: Blocker
    
    var body: some View {
        Text("\(blocker.name)")
    }
}

struct UIDetail_Previews: PreviewProvider {
    static var previews: some View {
        UIDetail(blocker: BlockerList.mainBlockerList.first!)
    }
}
