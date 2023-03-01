//
//  File.swift
//  PrimeiroAppMVVM
//
//  Created by Igor Fortti on 15/02/23.
//

import Foundation
import UIKit

//Extension que contem metodos que podem ser acessados por todos os objetos que herdam de UIColor. Abaixo, método de exemplo que cria uma cor para ser usada de forma simples em qualquer momento.
extension UIColor {
    @nonobjc class var appBackGround: UIColor {
        return UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
    }
}
