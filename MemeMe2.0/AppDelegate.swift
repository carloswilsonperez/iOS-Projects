//
//  AppDelegate.swift
//  ProtoMeme
//
//  Created by Carlos Wilson on 12/09/20.
//  Copyright © 2020 Carlos Wilson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Model data
    var memes = [Meme]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loadMemes()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func loadMemes() {
        let memes = [
            Meme(topText: "THE WEB?",
                 bottomText: "WHERE'S THE SPIDER?",
                 originalImage: UIImage(named: "placeholder")!,
                 memedImage: UIImage(named: "1")!)
        ]
        
        for meme in memes {
            self.memes.append(meme)
        }
    }
}

