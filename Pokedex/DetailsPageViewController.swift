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
    
    init() {
        aboutController = AboutViewController()
        statsController = StatsViewController()
        _ = statsController.view
        evolutionController = EvolutionViewController()
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
    }
    
    func getEvolution(id: Int) {
        evolutionController.viewModel.getEvolution(id: id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstVC = orderedViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: false)
        }
        
        
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
