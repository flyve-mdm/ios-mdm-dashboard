/**
 *  LICENSE
 *
 *  This file is part of Flyve MDM Admin Dashboard for iOS.
 *
 *  Admin Dashboard for iOS is a subproject of Flyve MDM.
 *  Flyve MDM is a mobile device management software.
 *
 *  Flyve MDM is free software: you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version 3
 *  of the License, or (at your option) any later version.
 *
 *  Flyve MDM is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  -------------------------------------------------------------------
 *  @author    Hector Rondon - <hrondon@teclib.com>
 *  @copyright Copyright Teclib. All rights reserved.
 *  @license   LGPLv3 https://www.gnu.org/licenses/lgpl-3.0.html
 *  @link      https://github.com/flyve-mdm/ios-mdm-dashboard/
 *  @link      http://flyve.org/ios-mdm-dashboard/
 *  @link      https://flyve-mdm.com
 *  ---------------------------------------------------------------------
 */

import UIKit

class ContainerViewController: UIViewController {
    
    enum SlideOutState {
        case collapsed
        case menuExpanded
    }
    
    var mainNavigationController: UINavigationController!
    var mainViewController: MainViewController!
    
    var menuViewController: SidePanelViewController?
    
    let mainPanelExpandedOffset: CGFloat = 60
    
    var currentState: SlideOutState = .collapsed {
        didSet {
            let shouldShowShadow = currentState != .collapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        mainViewController = MainViewController()
        mainViewController.delegate = self
        
        mainNavigationController = UINavigationController(rootViewController: mainViewController)
        view.addSubview(mainNavigationController.view)
        addChild(mainNavigationController)
        
        mainNavigationController.didMove(toParent: self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        mainNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
}

// MARK: MainViewController delegate
extension ContainerViewController: MainViewControllerDelegate {
    
    func toggleMenuPanel() {
        
        let notAlreadyExpanded = (currentState != .menuExpanded)
        
        if notAlreadyExpanded {
            addMenuPanelViewController()
        }
        
        animateMenuPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func collapseMenuPanel() {
        
        switch currentState {
        case .menuExpanded:
            toggleMenuPanel()
        default:
            break
        }
    }
    
    func addMenuPanelViewController() {
        
        guard menuViewController == nil else { return }
        
        if let vc = menuViewController {
            addChildSidePanelController(vc)
            menuViewController = vc
        }
    }
    
    func addChildSidePanelController(_ sidePanelController: SidePanelViewController) {
        
        sidePanelController.delegate = mainViewController
        view.insertSubview(sidePanelController.view, at: 0)
        
        addChild(sidePanelController)
        sidePanelController.didMove(toParent: self)
    }
    
    
    func animateMenuPanel(shouldExpand: Bool) {
        
        if shouldExpand {
            currentState = .menuExpanded
            animateCenterPanelXPosition(targetPosition: mainNavigationController.view.frame.width - mainPanelExpandedOffset)
            
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { _ in
                self.currentState = .collapsed
                self.menuViewController?.view.removeFromSuperview()
                self.menuViewController = nil
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.mainNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
        if shouldShowShadow {
            mainNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            mainNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
}

// MARK: Gesture recognizer

extension ContainerViewController: UIGestureRecognizerDelegate {
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        
        switch recognizer.state {
            
        case .began:
            if currentState == .collapsed {
                if gestureIsDraggingFromLeftToRight {
                    addMenuPanelViewController()
                }
                
                showShadowForCenterViewController(true)
            }
            
        case .changed:
            if let rview = recognizer.view {
                rview.center.x = rview.center.x + recognizer.translation(in: view).x
                recognizer.setTranslation(CGPoint.zero, in: view)
            }
            
        case .ended:
            if let _ = menuViewController,
                let rview = recognizer.view {
                // animate the side panel open or closed based on whether the view has moved more or less than halfway
                let hasMovedGreaterThanHalfway = rview.center.x > view.bounds.size.width
                animateMenuPanel(shouldExpand: hasMovedGreaterThanHalfway)
                
            }
            
        default:
            break
        }
    }
}
