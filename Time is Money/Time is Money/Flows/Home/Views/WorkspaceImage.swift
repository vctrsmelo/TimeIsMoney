//
//  WorkspaceImage.swift
//  Time is Money
//
//  Created by Victor Melo on 10/06/21.
//  Copyright © 2021 Victor S Melo. All rights reserved.
//

import SwiftUI

struct WorkspaceImage: View {
    
    @Binding var avatarId: String
    @Binding var currentPrice: Money
    @Binding var user: User
    
    var body: some View {
        let avatar = AvatarFactory.getById(id: avatarId)
        let scenarios = ScenarioFactory.getAllScenarios(for: .office, avatar: avatar)
        
        
        return ScenarioFactory.getScenario(from: scenarios, price: currentPrice, user: user)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width-120, alignment: .center)
            .frame(minHeight: 50, alignment: .center)
            .animation(.none)
    }
}

struct WorkspaceImage_Previews: PreviewProvider {
    
    @State static var avatarId = "male2"
    @State static var currentPrice: Money = 100
    @State static var user = User()
    
    static var previews: some View {
        WorkspaceImage(avatarId: $avatarId, currentPrice: $currentPrice, user: $user)
    }
}
