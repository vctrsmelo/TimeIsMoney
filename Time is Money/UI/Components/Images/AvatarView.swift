//
//  AvatarView.swift
//  Time is Money
//
//  Created by Victor Melo on 08/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct Avatar {
    
    enum Feeling {
        case happy
        case normal
        case sad
    }
    
    let happy: Image
    let normal: Image
    let sad: Image
}


struct AvatarView: View {
    
    let avatar: Avatar
    let feeling: Avatar.Feeling
    
    init(avatar: Avatar, feeling: Avatar.Feeling) {
        self.avatar = avatar
        self.feeling = feeling
    }
    
    var body: some View {
        
        let image: Image
        
        switch feeling {
        case .happy: image = avatar.happy
        case .normal: image = avatar.normal
        case .sad: image = avatar.sad
        }
        
        return image.resizable().scaledToFit()
    }
}

struct AvatarView_Previews: PreviewProvider {
    
    static let stubAvatar = AvatarFactory.male1()
    
    static var previews: some View {
        AvatarView(avatar: stubAvatar, feeling: .happy)
    }
}
