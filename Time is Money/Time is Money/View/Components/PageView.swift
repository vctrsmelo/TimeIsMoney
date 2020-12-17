//
//  PageView.swift
//  Time is Money
//
//  Created by Victor Melo on 03/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {

    @EnvironmentObject var appState: AppState
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0
    
    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0)}
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                BackgroundView(appState.designSystem.color.primary.asColor)
                VStack {
                    PageViewController(controllers: viewControllers, currentPage: $currentPage)
                        .edgesIgnoringSafeArea(.all)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    HStack {
                        Spacer()
                        PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .withBackground(appState.designSystem.color.primary.asColor)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView([AnyView(OnboardingWelcomeView()), AnyView(OnboardingWorkTimeView()), AnyView(OnboardingWeekdaysView()), AnyView(OnboardingIncomeView())])
    }
}
