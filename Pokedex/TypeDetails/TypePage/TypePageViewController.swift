//
//  TypePageViewController.swift
//  Gotcha
//
//  Created by Majka on 08/04/2023.
//

import Foundation
import UIKit

class TypePageViewController: UIPageViewController {
    
    private let offensiveController: OffensiveViewController
    private let defensiveController: DefensiveViewController
    private var currentPageIndex: Int = 0
    private var orderedControllers: [UIViewController] {
        return [offensiveController, defensiveController]
    }
    
    init(appRouter: AppRouterProtocol) {
        offensiveController = OffensiveViewController()
        defensiveController = DefensiveViewController()
        _ = defensiveController.view
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        for subview in view.subviews {
            if let scroll = subview as? UIScrollView {
                scroll.isScrollEnabled = false
            }
        }
        
        if let firstVC = orderedControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: false)
        }
    }
    
    func set(model: TypeModel) {
        offensiveController.viewModel.set(model: model)
        defensiveController.viewModel.set(model: model)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        let controllers = orderedControllers
        return controllers[index]
    }
    
    func slideToPage(index: Int, completion: (() -> Void)?) {
        let count = orderedControllers.count
        if index > count {
            if index > currentPageIndex {
                if let vc = viewControllerAtIndex(index: index) {
                    setViewControllers([vc], direction: UIPageViewController.NavigationDirection.forward, animated: true) { (complete) -> Void in
                        self.currentPageIndex = index
                        completion?()
                    }
                }
            } else if index < currentPageIndex {
                if let vc = viewControllerAtIndex(index: index) {
                    setViewControllers([vc], direction: UIPageViewController.NavigationDirection.forward, animated: true) { (complete) -> Void in
                        self.currentPageIndex = index
                        completion?()
                    }
                }
            }
        }
    }
}

extension TypePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = orderedControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = index - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedControllers.count > previousIndex else {
            return nil
        }
        
        return orderedControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = orderedControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = index + 1
        let count = orderedControllers.count
        
        guard count != nextIndex else {
            return nil
        }
        
        guard count > nextIndex else {
         return nil
        }
        
        return orderedControllers[nextIndex]
    }
    
    
}
