//
//  AuthContract.swift
//  CheckFunction
//
//  Created by 米山諒 on 2019/01/06.
//  Copyright © 2019 yoneyama ryo. All rights reserved.
//

import Foundation
import Hydra

protocol AuthViewProtocol: class {
    var presenter: AuthPresenterProtocol! { get }
    func initView()
    func isEnableLoginBtn(state: Bool)
}

protocol AuthPresenterProtocol {
    var view: AuthViewProtocol? { get }
    var invalidator: InvalidationToken! { get set }
    
    func onViewInitialized()
    func onLogin()
    func onLogout()
    func setLoginSettings(state: LoginSettingsState)
    
    func viewDidLoad()
    func viewDidDisappear()
}
