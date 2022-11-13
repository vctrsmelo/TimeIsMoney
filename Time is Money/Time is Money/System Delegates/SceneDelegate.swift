//
//  SceneDelegate.swift
//  Time is Money
//
//  Created by Victor S Melo on 10/10/19.
//  Copyright © 2019 Victor S Melo. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private(set) static var shared: SceneDelegate?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Self.shared = self
        
        let interactors = InteractorsContainer.defaultValue
        
        let pages = getPages().map { $0.environmentObject(interactors.mainInteractor.appState) }
        let onboardingView = PageView(pages).environmentObject(interactors.mainInteractor.appState)
        
        let mainView = NavigationView { MainView() }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(interactors.mainInteractor.appState)
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let isOnboardingCompleted = interactors.mainInteractor.appState.user.isOnboardingCompleted
            
            let rootVC = isOnboardingCompleted ?
                UIHostingController(rootView: mainView) :
                UIHostingController(rootView: onboardingView)
            
            window.rootViewController = rootVC
            self.window = window
            window.makeKeyAndVisible()
        }

        interactors.mainInteractor.loadAppState()
    }
    
    private func getPages() -> [AnyView] {
        [AnyView(OnboardingWelcomeView()),
         AnyView(OnboardingAvatarPickerView()),
         AnyView(OnboardingWeekdaysView()),
         AnyView(OnboardingWorkTimeView()),
         AnyView(OnboardingIncomeView())]
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

