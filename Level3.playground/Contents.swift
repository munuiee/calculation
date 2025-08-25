class Calculator {
  
        
    var num1: Double = 0
    var num2: Double = 0
    
    init(num1: Double, num2: Double) {
        self.num1 = num1
        self.num2 = num2
    }
    
    let add = AddOperation()
    let minus = SubtractOperation()
    let multiply = MultiplyOperation()
    let division = DivideOperation()
    
    func calculate() -> Double {
        return add.addResult(num1, num2)
    }
     


let c = Calculator(num1: 2.5, num2: 2.5)
let r = c.calculate()
print("r =", r)


class AddOperation {
    func addResult(_ num1: Double, _ num2: Double) -> Double {
        return num1 + num2
    }
 
}

class SubtractOperation {
    func minusResult(_ num1: Double, _ num2: Double) -> Double {
        return num1 - num2
    }
}

class MultiplyOperation {
    func mutiplyResult(_ num1: Double, _ num2: Double) -> Double {
        return num1 * num2
    }
}

class DivideOperation {
    func divisionResult(_ num1: Double, _ num2: Double) -> Double {
        return num1 / num2
    }
}
