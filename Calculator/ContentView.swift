//
//  ContentView.swift
//  Calculator
//
//  Created by Zev Eisenberg on 1/20/22.
//

import SwiftUI

enum Operator: String, CaseIterable {
    case plus = "+"
    case minus = "-"
    case multiply = "✕"
    case divide = "÷"
    case power = "^"

    func getTheFunctionThatDoesMath() -> ((Double, Double) -> Double) {
        switch self {
        case .plus:
            return (+)
        case .minus:
            return (-)
        case .multiply:
            return (*)
        case .divide:
            return (/)
        case .power:
            return (**)
        }
    }
}

precedencegroup ExponentGroup {
    associativity: right
    higherThan: MultiplicationPrecedence
}
infix operator **: ExponentGroup

extension Double {
    static func ** (lhs: Double, rhs: Double) -> Double {
        pow(lhs, rhs)
    }
}

struct ContentView: View {

    @State var typedText1 = ""
    @State var typedText2 = ""
    @State var currentOperator = Operator.plus
    @State var sum = ""

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Number 1", text: $typedText1)
                    TextField("Number 2", text: $typedText2)
                }
                .textFieldStyle(.roundedBorder)

                Picker(selection: $currentOperator, label: Text("Operator")) {
                    ForEach(Operator.allCases, id: \.rawValue) { op in
                        Text(op.rawValue)
                            .tag(op)
                    }
                }
                .pickerStyle(.segmented)

                HStack {
                    Text("Sum: \(sum)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button("Calculate") {
                        // do the calculation
                        if let number1 = Double(typedText1),
                           let number2 = Double(typedText2) {
                            let theFunction = currentOperator.getTheFunctionThatDoesMath()
                            let result = theFunction(number1, number2)
                            sum = String(result)
                        } else {
                            sum = "not a number"
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
