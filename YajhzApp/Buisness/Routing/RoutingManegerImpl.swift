//
//  RoutingController.swift
//  SwiftMVVMStartupProject
//
//  Created by Mahmoud Ibaraheim on 6/14/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

enum Storyboard: String {
    case search = "Search"
}

enum View: String {
    case searchView = "SearchView"
    case searchDetailsView = "SearchDetailsView"
    
    var storyboard: Storyboard {
        switch self {
        case .searchView, .searchDetailsView:
            return .search
        }
    }
    
    func controller<Presenter: BaseVM, Item: BaseItem>(presenterType: Presenter.Type, item: Item) -> BaseView<Presenter, Item> {
        let controller = UIStoryboard.init(name: storyboard.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: rawValue)
            as! BaseView<Presenter, Item> //swiftlint:disable:this force_cast
        controller.item = item
        return controller
    }
    
    func identifyViewController<viewController: UIViewController>(viewControllerType: viewController.Type) -> viewController {
        let controller = UIStoryboard.init(name: storyboard.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: rawValue)
            as! viewController //swiftlint:disable:this force_cast
        return controller
    }
    
    
    func baseController<ViewController: UIViewController>(viewControllerType: ViewController.Type) -> ViewController {
        let controller = UIStoryboard.init(name: storyboard.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: rawValue)
            as! ViewController //swiftlint:disable:this force_cast
        return controller
    }
}


class RouterManagerImpl: RouterManager {
    
    var currentViewController: UIViewController
    
    init(_ currentViewController: UIViewController) {
        self.currentViewController = currentViewController
    }
    
    func routeToInitialController<ViewController>(view: View, controller: ViewController.Type) where ViewController : UIViewController {
        let storyboard = UIStoryboard(name: view.storyboard.rawValue, bundle: nil)
        SceneDelegate.window!.rootViewController =  UINavigationController.init(rootViewController: storyboard.instantiateViewController(withIdentifier: view.rawValue) as! ViewController)
        SceneDelegate.window!.makeKeyAndVisible()
    }
    
    func present<Presenter: BaseVM, Item: BaseItem>(view: View, presenter: Presenter.Type, item: Item) {
        let viewController = view.controller(presenterType: presenter, item: item)
        viewController.modalPresentationStyle = .automatic
        currentViewController.present(viewController, animated: true)
    }
    
    
    func presentFullScreen<Presenter: BaseVM, Item: BaseItem>(view: View, presenter: Presenter.Type, item: Item) {
        let viewController = view.controller(presenterType: presenter, item: item)
        if #available(iOS 13.0, *) {
            if viewController.modalPresentationStyle == .automatic {
                viewController.modalPresentationStyle = .fullScreen
            }
        }
        currentViewController.present(viewController, animated: true)
    }
    
    func push<Presenter: BaseVM, Item: BaseItem>(view: View, presenter: Presenter.Type, item: Item ) {
        let viewController = view.controller(presenterType: presenter, item: item)
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func push(vc: UIViewController) {
        currentViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushNotPresenterController<ViewController: UIViewController>(view: View, controller: ViewController.Type) {
        let viewController = view.baseController(viewControllerType: controller)
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(vc: UIViewController) {
        currentViewController.present(vc, animated: true)
    }
    
    func popBack() {
        currentViewController.navigationController?.popViewController(animated: true)
    }
    
    func popNumOfViews(num: Int){
        currentViewController.navigationController?.popViewControllers(viewsToPop: num)
    }
    
    func dismiss() {
        currentViewController.dismiss(animated: true, completion: nil)
    }
    
    func openMediaPlayer(url : String){
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(.playback, mode: .default)
            let audioURL = URL.init(string: url)
            let player = AVPlayer(url: audioURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            currentViewController.present(playerViewController, animated: true) {
                playerViewController.player?.play()
            }
        }catch {
            print(error)
        }
    }
    
    func openShare(share: Any) {
        let activityViewController = UIActivityViewController(activityItems: share as! [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = currentViewController.view
        currentViewController.present(activityViewController, animated: true, completion: nil)
    }
}

extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = false) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
    
    func popViewControllers(viewsToPop: Int, animated: Bool = false) {
        if viewControllers.count > viewsToPop {
            let vc = viewControllers[viewControllers.count - viewsToPop - 1]
            popToViewController(vc, animated: animated)
        }
    }
}
