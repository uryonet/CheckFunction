//
//  BaseContract.swift
//  CheckFunction
//
//  Created by 米山諒 on 2019/01/06.
//  Copyright © 2019 yoneyama ryo. All rights reserved.
//

import Foundation
import Hydra

protocol BaseViewProtocol: class {
    
}

protocol BasePresenterProtocol: class {
    
    
    
    // LifeCycle Events /
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}
