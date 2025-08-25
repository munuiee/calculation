
protocol AbstractOperation: AnyObject {
    func add(_ num1: Int, _ num2: Int) -> Int
    func minus(_ num1: Int, _ num2: Int) -> Int
    func multiply(_ num1: Int, _ num2: Int) -> Int
    func division(_ num1: Int, _ num2: Int) -> Double?
    func remainder(_ num1: Int, _ num2: Int) -> Int?
}

class Calculator: AbstractOperation {

    
    // Operation 클래스들과 Calculator 클래스 연결
    
    let addResult = AddOperation()
    let minusResult = SubtractOperation()
    let multiplyResult = MultiplyOperation()
    let divisionResult = DivideOperation()
    let remainderResult = RemainderOperation()
    

    
    func add(_ num1: Int, _ num2: Int) -> Int {
        return addResult.add(num1, num2)
    }
    
    func minus(_ num1: Int, _ num2: Int) -> Int {
        return minusResult.minus(num1, num2)
    }
    
    func multiply(_ num1: Int, _ num2: Int) -> Int {
        return multiplyResult.multiply(num1, num2)
    }
    
    
    // 분모가 0인 경우 대비
    
    func division(_ num1: Int, _ num2: Int) -> Double? {
        guard num2 != 0 else { return nil }
            return divisionResult.division(num1, num2)
    }
    
    func remainder(_ num1: Int, _ num2: Int) -> Int? {
        guard num2 != 0 else { return nil }
            return remainderResult.remainder(num1, num2)
    }

  
}


// Operation 클래스들

class AddOperation {
     func add(_ num1: Int, _ num2: Int) -> Int {
        return num1 + num2
    }
}


class SubtractOperation {
     func minus(_ num1: Int, _ num2: Int) -> Int {
        return num1 - num2
    }
}

class MultiplyOperation {
    func multiply(_ num1: Int, _ num2: Int) -> Int {
        return num1 * num2
    }
}
    
class DivideOperation {
    func division(_ num1: Int, _ num2: Int) -> Double {
        return Double(num1) / Double(num2)
    }
}

class RemainderOperation {
    func remainder(_ num1: Int, _ num2: Int) -> Int {
        return num1 % num2
    }
}



let calculator = Calculator()
print(calculator.add(2, 4))
print(calculator.minus(3, 1))
print(calculator.multiply(2, 3))
print(calculator.division(20, 3) ?? 0) // 옵셔널이 nil이면 0을 대신 출력
print(calculator.remainder(6, 4) ?? 0)

