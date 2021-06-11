//
//  AvatarView.swift
//  Time is Money
//
//  Created by Victor Melo on 08/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct AvatarView: View {
    
    let avatar: Avatar
    
    init(avatar: Avatar) {
        self.avatar = avatar
    }
    
    var body: some View {
        avatar.happy
            .resizable()
            .scaledToFit()
    }
}

struct AvatarView_Previews: PreviewProvider {
    
    static let stubAvatar = AvatarFactory.male1()
    
    static var previews: some View {
        AvatarView(avatar: stubAvatar)
    }
}
