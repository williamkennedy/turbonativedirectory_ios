//
//  SceneDelegate.swift
//  turbonativedirectory_ios
//
//  Created by William Kennedy on 07/10/2023.
//

import UIKit
import Turbo

let rootURL = URL(string: "https://turbonative.directory")!

class SceneDelegate: UIResponder, UIWindowSceneDelegate {


    let navigationController = UINavigationController()
    var window: UIWindow?

    private lazy var session: Session = {
        let session = Session()
        session.delegate = self
        return session
    }()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        window!.rootViewController = navigationController
        visit(url: rootURL)
    }

    private func visit(url: URL) {
           let viewController = VisitableViewController(url: url)
           navigationController.pushViewController(viewController, animated: true)
           session.visit(viewController)
       }

}

extension SceneDelegate: SessionDelegate {
    func session(_ session: Turbo.Session, didFailRequestForVisitable visitable: Turbo.Visitable, error: Error) {
        print("Error \(error.localizedDescription)")
    }

    func session(_ session: Turbo.Session, didProposeVisit proposal: Turbo.VisitProposal) {
        visit(url: proposal.url)
    }

    func sessionWebViewProcessDidTerminate(_ session: Turbo.Session) {
        session.reload()
    }


}

