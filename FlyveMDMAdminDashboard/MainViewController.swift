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

class MainViewController: UIViewController {
    
    var imageView: UIImageView!
    var titleLabel: UILabel!
    
    var delegate: MainViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {

        let menuButton = UIBarButtonItem()
        
        let attributes = [
            NSAttributedString.Key.font : UIFont(name: "Fabric External MDL2 Assets", size: 17),
        ]
        
        let attributesTitle = [
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.font: UIFont(name: "Segoe UI", size: 17)!
        ]
        
        menuButton.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        menuButton.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .highlighted)
        menuButton.title = "\u{e700}"
        menuButton.target = self
        menuButton.action = #selector(self.openMenu)
        
        view.backgroundColor = .white
        UINavigationBar.appearance().titleTextAttributes = attributesTitle
        navigationItem.title = NSLocalizedString("title_admin", comment: "")
        navigationItem.leftBarButtonItem = menuButton

    }
    
    @objc func openMenu() {
        print("open menu")
    }

    // MARK: Button actions
    func menuTapped(_ sender: Any) {
        delegate?.toggleMenuPanel?()
    }
}

// MARK: - SidePanelViewControllerDelegate
extension MainViewController: SidePanelViewControllerDelegate {
    
    func didSelectMenuItem(_ menuItem: AnyObject) {
        imageView.image = menuItem.image
        titleLabel.text = menuItem.title
        
        delegate?.collapseSidePanels?()
    }
}

