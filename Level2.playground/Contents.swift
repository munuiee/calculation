class Calculator {
    
    var num1: Double
    var num2: Double
    
    init(num1: Double, num2: Double) {
        self.num1 = num1
        self.num2 = num2
    }
    
    func calculate(cal: String) -> Double {
        switch cal {
        case "+":
            return num1 + num2
        case "-":
            return num1 - num2
        case "*":
            return num1 * num2
        case "/":
            return num1 / num2
        case "%":
            return num1.truncatingRemainder(dividingBy: num2)
        default:
            return 0
        }
    }
        

    func addResult() -> Double {
        return num1 + num2
    }
    
    func minusResult() -> Double {
        return num1 - num2
    }
    
    func mutiplyResult() -> Double {
        return num1 * num2
    }
    
    func divisionResult() -> Double {
        return num1 / num2
    }
    
    func remainResult() -> Double {
        return num1.truncatingRemainder(dividingBy: num2)
    }

}

let calculator = Calculator(num1: 5, num2: 3)
let addResult = calculator.calculate(cal: "+")
let minusResult = calculator.calculate(cal: "-")
let multiplyResult = calculator.calculate(cal: "*")
let divisionResult = calculator.calculate(cal: "/")
let remainResult = calculator.calculate(cal: "%")
print(addResult)
print(minusResult)
print(multiplyResult)
print(divisionResult)
print(remainResult)
