//
//  DetailsPageViewController.swift
//  Gotcha
//
//  Created by Majka on 13/11/2022.
//

import UIKit

class DetailsPageViewController: UIPageViewController {
    
    private let aboutController: AboutViewController
    private let statsController: StatsViewController
    private let evolutionController: EvolutionViewController
    private var currentPageIndex: Int = 0
    

    init(appRouter: AppRouterProtocol) {
        aboutController = AboutViewController()
        statsController = StatsViewController()
        _ = statsController.view
        evolutionController = EvolutionViewController(router: appRouter)
        _ = evolutionController.view

        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var orderedViewControllers: [UIViewController] {
        return [aboutController, statsController, evolutionController]
    }
    
    func set(model: PokemonModel) {
        aboutController.viewModel.set(model: model)
        statsController.viewModel.set(model: model)
        evolutionController.viewModel.getEvolution(withSpeciesUrl: model.species.url)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        // disable scrolling but not user interaction
        for subview in view.subviews {
            if let scroll = subview as? UIScrollView {
                scroll.isScrollEnabled = false
            }
        }
        
        if let firstVC = orderedViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: false)
        }
    }
    
    func slideToPage(index: Int, completion: (() -> Void)?) {
        let count = orderedViewControllers.count
        if index < count {
            if index > currentPageIndex {
                if let vc = viewControllerAtIndex(index: index) {
                    setViewControllers([vc], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: { (complete) -> Void in
                        self.currentPageIndex = index
                        completion?()
                    })
                }
            } else if index < currentPageIndex {
                if let vc = viewControllerAtIndex(index: index) {
                    setViewControllers([vc], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: { (complete) -> Void in
                        self.currentPageIndex = index
                        completion?()
                    })
                }
            }
        }
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        let controllers = orderedViewControllers
        return controllers[index]
    }
}

//MARK: - Data Source Methods

extension DetailsPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
                    return nil
                }
                
                let nextIndex = viewControllerIndex + 1
                let orderedViewControllersCount = orderedViewControllers.count

                guard orderedViewControllersCount != nextIndex else {
                    return nil
                }
                
                guard orderedViewControllersCount > nextIndex else {
                    return nil
                }
                
                return orderedViewControllers[nextIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
                    return nil
                }
                
                let previousIndex = viewControllerIndex - 1
                
                guard previousIndex >= 0 else {
                    return nil
                }
                
                guard orderedViewControllers.count > previousIndex else {
                    return nil
                }
                
                return orderedViewControllers[previousIndex]
    }
    
}
