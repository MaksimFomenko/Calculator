import SwiftUI

enum Operation {
    case addition, negative, multiply, divide, none 
}

enum Buttons: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case plus = "+"
    case minus = "-"
    case decimal = "."
    case equal = "="
    case negative = "+/-"
    case clear = "AC"
    case next = "\u{02192}"
    
    var buttonColor: Color {
        switch self {
        case .clear, .plus, .minus, . decimal, .equal, .next :
            return Color.orange
        default :
            return Color.gray
        }
    }
    
    var buttonFontColor: Color {
        switch self {
        case .clear, .plus, .minus, . decimal, .equal, .next :
            return Color.white
        default :
            return Color.black
        }
    }
    
}
 
