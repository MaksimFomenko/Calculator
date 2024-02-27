//
//  MainView.swift
//  Calculator
//
//  Created by Maksim on 21.02.2024.
//

import SwiftUI

struct MainView: View {
    @State private var a = 0.0
    @State private var b = 0.0
    @State private var c = 0.0
    @State private var message = "Input a"
    @State private var value = "0"
//    @State private var number: Double = 0.0
//    @State private var currentOperation: Operation = .none
    

    let buttonsArray: [[Buttons]] = [
        [.seven, .eight, .nine, .clear],
        [.four, .five, .six, .plus],
        [.one, .two, .three, .minus],
        [.zero, .decimal, .next]
    ]
    
    var body: some View {
        ZStack {
            //Background
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Spacer()
                //Display
                HStack {
                    Spacer()
                    Text(message)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 35))
                        .fontWeight(.light)
                        .padding(.horizontal, 30)
                }
                
                //Display
                HStack {
                    Spacer()
                    Text(value)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 35))
                        .fontWeight(.light)
                        .padding(.horizontal, 30)
                }
                
                //Buttons
                ForEach( buttonsArray, id: \.self) { 
                    row in HStack(spacing: 12) {
                        ForEach(row, id: \.self) {
                            item in Button {
                                self.didTap(item: item)
                            } label: {
                                Text(item.rawValue)
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight())
                                    .foregroundStyle (item.buttonFontColor)
                                    .font(.system(size: 35))
                                    .background(item.buttonColor)
                                    .cornerRadius(40)
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
    }
    
    func didTap(item: Buttons) {
        switch item {
        case .clear:
            value = "0"
            message = "Input a"
        case .decimal:
            if !value.contains(".") {
                value += "."
            }
        case .next:
            if message == "Input a" {
                if let value = Double(value) {
                    a = value
                    message = "Input b"
                    self.value = "0"
                } else {
                    message = "Error"
                }
            } else if (message == "Input b") {
                if let value = Double(value) {
                    b = value
                    message = "Input c"
                    self.value = "0"
                }
            }  else if (message == "Input c") {
                if let value = Double(value) {
                    c = value
                    message = solveQuadraticEquation(a: a, b: b, c: c)
                    self.value = "0"
                }
            }
        default:
            if value == "0" {
                value = item.rawValue
            } else {
                value += item.rawValue
            }
        }
//        switch item {
//        case .plus:
//            currentOperation = .addition
//            number = Double(value ) ?? 0
//            value = "0"
//        case .minus:
//            currentOperation = .negative
//            number = Double(value) ?? 0
//            value = "0"
//        case .decimal:
//            if !value.contains(".") {
//                value += "."
//            }
//        case .equal:
//            if let currentValue = Double(value) {
//                value = formatResult(performOperation(currentValue))
//            }
//        case .clear:
//            message = "Input a"
//            value = "0"
//        case .next:
//            message = "Input b"
//            value = "0"
//        default:
//            if value == "0" {
//                value = item.rawValue
//            } else {
//                value += item.rawValue
//            }
//        }
    }
    
    
//    func formatResult(_ result: Double) -> String {
//        return String(format: "%g", result)
//    }
    
//    func performOperation(_ currentValue: Double) -> Double {
//        switch currentOperation {
//        case .addition:
//            return number + currentValue
//        case .negative:
//            return number - currentValue
//        default:
//            return currentValue
//        }
//    }
    
    func buttonWidth(item: Buttons) -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = 5 * spacing
        let totalColums: CGFloat = 4
        let  screenWidth = UIScreen.main.bounds.width
        
        return (screenWidth - totalSpacing) / totalColums
    }
    
    func buttonHeight() -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = 5 * spacing
        let totalColums: CGFloat = 4
        let  screenWidth = UIScreen.main.bounds.width
        
        return (screenWidth - totalSpacing) / totalColums
    }
    
}

func solveQuadraticEquation(a: Double, b: Double, c: Double) -> String {
    // Вычисление дискриминанта
    let discriminant = b * b - 4 * a * c
    
    // Проверка знака дискриминанта
    if discriminant > 0 {
        // Два действительных корня
        let root1 = (-b + sqrt(discriminant)) / (2 * a)
        let root2 = (-b - sqrt(discriminant)) / (2 * a)
        return "two roots: x1 = \(root1), x2 = \(root2)"
    } else if discriminant == 0 {
        // Один действительный корень
        let root = -b / (2 * a)
        return "one roots: x = \(root)"
    } else {
        // Нет действительных корней
        return "no roots"
    }
}

#Preview {
    MainView()
}
 
