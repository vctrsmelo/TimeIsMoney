//
//  PageView.swift
//  Time is Money
//
//  Created by Victor Melo on 03/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {

    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 1
    
    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0)}
    }

    var body: some View {
        VStack {
            PageViewController(controllers: viewControllers, currentPage: $currentPage).edgesIgnoringSafeArea(.all)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView([WelcomeView(), WelcomeView()])
    }
}
