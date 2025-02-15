//
//  Scene.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 08/01/21.
//

import UIKit

//Each ViewController has a correspondent Scene witch holds its presenter
enum Scene {
    case feed(FeedPresenter)
    case detail(DetailPresenter)

    func viewController(coordinator: Coordinator) -> UIViewController {
        switch self {
        case .feed(let presenter):
            return getFeedSplitViewController(coordinator: coordinator, presenter: presenter)
        case .detail(let presenter):
            return DetailViewController(coordinator: coordinator, presenter: presenter)
        }
    }

    private func getFeedSplitViewController(coordinator: Coordinator, presenter: FeedPresenter) -> UISplitViewController {
        let feedViewController = FeedViewController(coordinator: coordinator, presenter: presenter)
        let feedNavigationController = feedViewController.embedInNavigation()
        presenter.view = feedViewController

        let splitViewController = UISplitViewController()
        splitViewController.preferredDisplayMode = .allVisible

        splitViewController.viewControllers = [feedNavigationController]

        return splitViewController
    }
}
