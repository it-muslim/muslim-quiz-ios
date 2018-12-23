//
//  DialogView.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 16/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

enum DialogStatus {
    case draw
    case win
    case lose
    case timeIsOver
    case giveUp
}

protocol DialogFactoryProtocol {
    func present(in viewController: UIViewController,
                 title: String,
                 msg: String,
                 cancel: String?)
    func present(in viewController: UIViewController, status: DialogStatus)
}

class DialogFactory: DialogFactoryProtocol {
    
    func present(in viewController: UIViewController,
                 title: String,
                 msg: String,
                 cancel: String? = nil) {
        
        let alertController = UIAlertController(title: title,
                                                message: msg,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .cancel,
                                                handler:
            { (alertAction) in
                alertController.dismiss(animated: true, completion: nil)
        }) )
        viewController.present(alertController,
                               animated: true,
                               completion: nil)
    }
    
    func present(in viewController: UIViewController, status: DialogStatus) {
        func message(for status: DialogStatus) -> String {
            switch status {
            case .draw:
                return "🤝\n Ничья!"
            case .win:
                return "😁\n Вы победили!"
            case .lose:
                return "😥\n Вы проиграли!"
            case .timeIsOver:
                return "⏱\n Время вышло!"
            case .giveUp:
                return "😩\n Сдался"
            }
        }
        
        self.present(in: viewController,
                     title: "Игра завершена",
                     msg: message(for: status),
                     cancel: "Продолжить")
    }
    

    
}
