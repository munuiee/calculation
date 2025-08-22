# Ch 2. 프로그래밍 기초 주차 과제

## 0820 수요일

원래 19일 화요일부터 Lv1을 시도해봤으나 아직 기초 지식이 부족한 탓에.. 수요일부터 챕터 1 강의를 완강하고 다시 과제를 시작해보았다. <br>


# Lv1
- 더하기, 빼기, 나누기, 곱하기 연산을 수행할 수 있는 Calculator 클래스를 만들기
- 생성한 클래스를 이용하여 연산을 진행하고 출력

```swift
class Calculator {
    // Todo : 내부 구현하기
    
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
        default:
            return 0
        }
    }
        

    func addResult() -> Double {
        return num1 + num2
    }
    

}
let calculator = Calculator(num1: 5, num2: 3)
let addResult = calculator.calculate(cal: "+")
print(addResult)
```


우선 아예 어떤식으로 구현해야할지 도저히 감이 안 잡혀서 여러 검색을 해본 결과 Switch문으로 연산을 작동하는 게 괜찮을 것이라 판단하고 Switch문으로 구현해보았다. <br>

---

# Lv2
- Lv1에서 만든 Calculator 클래스에 “나머지 연산”이 가능하도록 코드를 추가하고, 연산 진행 후 출력
-   ex) 나머지 연산 예시 : 6을 3으로 나눈 나머지는 0 / 5를 3으로 나눈 나머지는 2
- 오류가 날 수 있는 ‘예외처리’ 상황에 대해 고민해보기 + 구현하기

```swift
 case "%":
            return num1 % num2
```
우선 나름대로 나머지 연산 코드를 넣어봤는데
`'%' is unavailable: For floating point numbers use truncatingRemainder instead` 이런 오류가 떴다.
<br>

알아보니 `Double` 타입의 데이터를 나머지 연산할 때 `truncatingRemainder` 메서드를 사용해야 한다고 한다. 
```swift
case "%":
            return num1.truncatingRemainder(dividingBy: num2)
```
코드를 이렇게 바꿔주니 에러가 사라졌다.

<br>

```swift
 func remainResult() -> Double {
        return num1.truncatingRemainder(dividingBy: num2)
    }
    
let remainResult = calculator.calculate(cal: "%")
print(remainResult)
```


나머지 함수도 선언해주고 실행해보았다 <br>
![](https://velog.velcdn.com/images/jihyee10/post/ed26579a-3ad2-4516-9abc-9c754713d544/image.png)

와우!! 출력이 되었다 !

<br>

```swift
//import UIKit

//var greeting = "Hello, playground"


// 더하기, 빼기, 나누기, 곱하기 연산을 수행할 수 있는 Calculator 클래스를 만들기

class Calculator {
    // Todo : 내부 구현하기
    
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

```

여기서 문제점: 코드가 너무 지저분해 보인다... 방법을 찾아봐야할듯

<br>

# Lv3
  - 아래 각각의 클래스들을 만들고 클래스간의 관계를 고려하여 Calculator 클래스와 관계 맺기
       -  AddOperation(더하기)
       -  SubstractOperation(빼기)
       -  MultiplyOperation(곱하기)
       -  DivideOperation(나누기)
   
---

우선 `클래스와 관계 맺기`가 어떤 의미인지 몰라서 찾아보았고, **계산기에는 Composition으로 하는 게 맞다는 판단**을 내렸다.

<br>

#### 복합관계 (Composition)
* 한 클래스 안에 다른 클래스를 속성으로 두는 것.
* 예: Car 클래스 안에 Engine 객체가 들어가 있으면, 차는 엔진을 갖는다 라는 관계가 됨
```swift
class Engine {
    func start() {
        print("Engine started")
    }
}

class Car {
    let engine = Engine()
    func drive() {
        engine.start()
        print("Car is driving")
    }
}
```
<br>

그래서 Calculator 클래스 안에 나머지 객체를 포함시키면 어떨까 싶었다.

<br>

```swift
class Calculator {
    // Todo : 내부 구현하기
        
    var num1: Double = 0
    var num2: Double = 0
    
    init(num1: Double, num2: Double) {
        self.num1 = num1
        self.num2 = num2
    }
     

    func calculate(operation: String) -> Double {
        switch operation {
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
}

class AddOperation {
    func addResult(_ num1: Double, _ num2: Double) -> Double {
        return num1 + num2    
    }
}

class SubstractOperation {
    func minusResult(_ num1: Double, _ num2: Double) -> Double {
        return num1 - num2
    }
}

class MultiplyOpertaion {
    func mutiplyResult(_ num1: Double, _ num2: Double) -> Double {
        return num1 * num2
    }
}

class DivideOperation {
    func divisionResult(_ num1: Double, _ num2: Double) -> Double {
        return num1 / num2
    }
}
```
<br>

나름대로 해봤으나.. 클래스 연결이 쉽지가 않다...
계속되는 에러들 😵‍💫

<br>

```swift
//import UIKit

//var greeting = "Hello, playground"


// 더하기, 빼기, 나누기, 곱하기 연산을 수행할 수 있는 Calculator 클래스를 만들기

class Calculator {
    // Todo : 내부 구현하기
        
    var num1: Double = 0
    var num2: Double = 0
    
    init(num1: Double, num2: Double) {
        self.num1 = num1
        self.num2 = num2
    }
    
    let add = AddOperation()
    let minus = SubstractOperation()
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

class SubstractOperation {
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



```

우선 출력값은 잘 나오지만.. 이 다음이 문제. 내일 더 고민해봐야겠다.

<br>
<br>

## 0821 목요일
뭔가 많은 수정을 했는데...

우선 위의 코드가 너무 정신 없어 코드를 최대한 줄여보고 싶은 욕심이 컸다. 그리고 Calculator 클래스와 아래 연산 클래스들을 연결을 해야 했다.

오늘 enum을 배웠는데, enum으로 해보면 어떨까 도전해봤다가 도저히 감이 안 잡혀서 여러 방법을 찾아보았다. Class끼리 연결하는 것이 첫 번째 목적이었기 때문에.. 

#### 첫 번째로 생각한 방법
<br>
함수를 튜플로 리턴하는 거였다. 각각 클래스별로 함수로 묶어 리턴하는 게 초보자인 내가 봐도 지저분해보였기 때문에...
<br>
```swift
 func calculate() -> Double {
        return add.addResult(num1, num2)
    }
   
```
<br>
그래서 이 함수를
<br>

```swift
 func calculate() -> Double {
        return add.addResult(num1, num2), 
        minus.SubstractOperation()
    }
```
이런식으로..? 보니까 리턴도 이렇게 콤마로 할 수 있더란다..
근데!! 내가 봐도 이건 좀 이상했다. 그리고 오류도 났다 😭

<br>

#### 두 번째로 생각한 방법
<br>
저 아래 연산 클래스들을 하나의 클래스로 묶어 결과를 리턴하는 것이었다. 구글링을 해봤는데 여러 예제 중에 override가 있었다. 함수명을 같게 해서 override를 해주면 된다고 했다. <br>
즉 Operation은 부모 클래스, 나머지 연산 클래스들을 자식으로 삼는 것이다.
<br>

```swift
class Operation {
    func result(_ num1: Double, _ num2: Double) -> Double {
        return 0
    }
}

class AddOperation:  Operation {
    override func result(_ num1: Double, _ num2: Double) -> Double {
        return num1 + num2
    }
}


class SubstractOperation: Operation {
    override func result(_ num1: Double, _ num2: Double) -> Double {
        return num1 - num2
    }
}

    class MultiplyOperation: Operation {
        override func result(_ num1: Double, _ num2: Double) -> Double {
        return num1 * num2
    }
}
    
    class DivideOperation: Operation {
        override func result(_ num1: Double, _ num2: Double) -> Double {
        return num1 / num2
    }
}

let calculators: [Operation] = [AddOperation(), SubstractOperation(), MultiplyOperation(), DivideOperation()]

for a in calculators {
    a.result(1, 1)
}
```

‼️ `Method does not override any method from its superclass`
하다보니 이런 오류가 생겼다. 상속을 쓸 때 무조건 함수 모양이 부모랑 같아야하는데 부모 클래스에 함수 정의가 없어서란다.. 그래서 Operation 클래스에 파라미터와 반환값, 리턴값을 추가해줬더니 해결했다.
<br>

암튼 배열을 주고 반복문으로 결과를 출력시켰는데 오잉 코드가 돌아가긴 돌아간다. 근데!! 이게 맞는지 모르겠는게, 일단 Calculator 클래스와 관계를 맺지 않았다. <br>
차라리 Calculator 클래스에 함수를 모조리 넣어서 해보는 건 어떨까 싶다. 내일 도전해보겠다!

<br>

## 0822 금요일

```swift
class Calculator {
    // Todo : 내부 구현하기
    
    var operation: Operation
    var num1: Double
    var num2: Double
    
    init(num1: Double, num2: Double, operation: Operation) {
        self.num1 = num1
        self.num2 = num2
        self.operation = operation
    }
  
}
```

우선 Operation 클래스와 Calculator 클래스를 연결해주었다. <br>
중간에 `Return from initializer without initializing all stored properties` 라는 오류가 떴는데, <br>
`init`에 `self.operation = opration`으로 초기화를 안 해줘서 생긴 에러였다.

<br>

```siwft
class Calculator {
    
    var operation: Operation
    var num1: Double
    var num2: Double
    
    let add = AddOperation()
    let minus = SubstractOperation()
    let multiply = MultiplyOperation()
    let division = DivideOperation()
    
    init(num1: Double, num2: Double, operation: Operation) {
        self.num1 = num1
        self.num2 = num2
        self.operation = operation
    }
    
    let calculators: [Operation] = [AddOperation(), SubstractOperation(), MultiplyOperation(), DivideOperation()]

    
//    func result() {
//        for a in calculators {
//            a.result(num1, num2)
//        }
//        print(operation.result(num1, num2))
//    }
    
    
    
    func resultAddOperation(_ num1: Double, num2: Double) -> Double {
        return add.result(num1, num2)
    }
    
    func resultSubstractOperation(_ num1: Double, num2: Double) -> Double {
        return minus.result(num1, num2)
    }
    
    func resultMultiplyOperation(_ num1: Double, num2: Double) -> Double {
        return multiply.result(num1, num2)
    }
    
    func resultDivideOperation(_ num1: Double, num2: Double) -> Double {
        if num2 == 0 {
            print("0으로 나눌 수 없습니다.")
            return 0
        } else {
            return division.result(num1, num2)
        }
    }

  
}



class Operation {
 
    
    func result(_ num1: Double, _ num2: Double) -> Double {
        return 0
    }
}

class AddOperation:  Operation {
    override func result(_ num1: Double, _ num2: Double) -> Double {
        return num1 + num2
    }
}


class SubstractOperation: Operation {
    override func result(_ num1: Double, _ num2: Double) -> Double {
        return num1 - num2
    }
}

    class MultiplyOperation: Operation {
        override func result(_ num1: Double, _ num2: Double) -> Double {
        return num1 * num2
    }
}
    
    class DivideOperation: Operation {
        override func result(_ num1: Double, _ num2: Double) -> Double {
        return num1 / num2
    }
}

```
너무나도 뚱뚱해져버린 코드... Operation 클래스를 만들고 배열로 보내면서 뭔가 더 복잡해진 느낌이다. 원래 내 목적은 **Operation 클래스에 연산 클래스들을 연결시켜 결과값을 도출하게 하고 이걸 Calculator 클래스에 연결해서 출력하는 것** 이었는데, override를 쓰고 배열을 쓰게 되면서 너무 정신 없어진 것 같아 수정을 또다시...

<br>

+ 과제에 **예외처리 상황 고려** 를 해보라고 했는데, 나는 여기서 대체 어떤 예외처리가 난다는 걸까 하고 고민을 했는데도 답이 안 나왔더랜다. <br>
그러다가 우리팀원끼리 코드리뷰를 하면서!! 알아버렸다. 나누기를 했을 때 분모가 0이면 어떻게 처리를 해야할지에 대하여. <br>

```swift
    if num2 == 0 {    
        print("0으로 나눌 수 없습니다!")
        return 0      
    } else {
        return division.result(num1, num2)
    }

```
그래서 간단하게 추가해주었다. num2가 0일 때 "0으로 나눌 수 없습니다!"를 출력하고 return을 0으로 하는 것이다.

<br>


```swift

class Calculator {
    
    var num1: Double
    var num2: Double
    
    let add = AddOperation()
    let minus = SubstractOperation()
    let multiply = MultiplyOperation()
    let division = DivideOperation()
    
    init(num1: Double, num2: Double) {
        self.num1 = num1
        self.num2 = num2
    }
    
    
    
    func resultAddOperation(_ num1: Double, num2: Double) -> Double {
        return add.result(num1, num2)
    }
    
    func resultSubstractOperation(_ num1: Double, num2: Double) -> Double {
        return minus.result(num1, num2)
    }
    
    func resultMultiplyOperation(_ num1: Double, num2: Double) -> Double {
        return multiply.result(num1, num2)
    }
    
    func resultDivideOperation(_ num1: Double, num2: Double) -> Double {
        if num2 == 0 {
            print("0으로 나눌 수 없습니다.")
            return 0
        } else {
            return division.result(num1, num2)
        }
    }

  
}



class AddOperation {
     func result(_ num1: Double, _ num2: Double) -> Double {
        return num1 + num2
    }
}


class SubstractOperation {
     func result(_ num1: Double, _ num2: Double) -> Double {
        return num1 - num2
    }
}

    class MultiplyOperation {
        func result(_ num1: Double, _ num2: Double) -> Double {
        return num1 * num2
    }
}
    
    class DivideOperation {
        func result(_ num1: Double, _ num2: Double) -> Double {
        return num1 / num2
    }
}



```
일단 `override`와 `Operation`을 제거했더니 코드가 훨씬 깔끔해보인다.. ㅎ 그리고 result도 전부 바꿔줘야한다. <br>

그런데, 여기서 또 문제가 생겼다. `let calculator = Calculator()`를 해줬더니 파라미터를 자꾸 넣으라는 에러가 떴다. <br>

```swift
var num1: Double
var num2: Double
    
 let add = AddOperation()
 let minus = SubstractOperation()
 let multiply = MultiplyOperation()
 let division = DivideOperation()
    
init(num1: Double, num2: Double) {
   self.num1 = num1
   self.num2 = num2
}
```
그래서 기본값만 주고 init은 없애버렸다. <br>

<br>


또 새로운 오류 발견 `Missing argument label 'num2:' in call` <br>
```swift
func resultAddOperation(_ num1: Double, num2: Double) -> Double {
    return addResult.add(num1, num2)
}

```
<br>
내가 num2에만 언더스코어를 안 넣어줬다..

<br>

```swift
let addResult = AddOperation()
let minusResult = SubstractOperation()
let multiplyResult = MultiplyOperation()
let divisionResult = DivideOperation()
```
<br>
let으로 Calculator 클래스에 연산 클래스들을 연결해주었다.

<br>

```swift
    func add(_ num1: Double, _ num2: Double) -> Double {
        return addResult.add(num1, num2)
    }
    
    func minus(_ num1: Double, _ num2: Double) -> Double {
        return minusResult.minus(num1, num2)
    }
    
    func multiply(_ num1: Double, _ num2: Double) -> Double {
        return multiplyResult.multiply(num1, num2)
    }
    
    func division(_ num1: Double, _ num2: Double) -> Double {
        if num2 == 0 {
            print("0으로 나눌 수 없습니다.")
            return 0
        } else {
            return divisionResult.division(num1, num2)
        }
    }
```
<br>
Calculator 클래스 안의 함수명을 간단하게 바꿔주었다. 깔끔하고 보기좋다!
<br>

```swift
let calculator = Calculator()
print(calculator.add(2, 4))
print(calculator.minus(3, 1))
print(calculator.multiply(2, 3))
print(calculator.division(6, 0))
```
<br>

코드가 잘 돌아가나 결과를 출력해본다.

```swift
6.0
2.0
6.0
0으로 나눌 수 없습니다.
0.0
```
결과값이 너무 잘 나온다!! 그런데, 한 가지 걸리는 문제는 Double 타입으로 반환이기 때문에 소수점까지 표시된다는 것이다. <br>
내가 원하는 것은 소수로 출력되는 숫자만 Double, 나머지는 Int인데 방법을 찾아봐야겠다. <br>

```swift

class Calculator {
    
    var num1: Double = 0
    var num2: Double = 0
    
    let addResult = AddOperation()
    let minusResult = SubstractOperation()
    let multiplyResult = MultiplyOperation()
    let divisionResult = DivideOperation()
    
    
    
    func add(_ num1: Double, _ num2: Double) -> Double {
        return addResult.add(num1, num2)
    }
    
    func minus(_ num1: Double, _ num2: Double) -> Double {
        return minusResult.minus(num1, num2)
    }
    
    func multiply(_ num1: Double, _ num2: Double) -> Double {
        return multiplyResult.multiply(num1, num2)
    }
    
    func division(_ num1: Double, _ num2: Double) -> Double {
        if num2 == 0 {
            print("0으로 나눌 수 없습니다.")
            return 0
        } else {
            return divisionResult.division(num1, num2)
        }
    }

  
}



class AddOperation {
     func add(_ num1: Double, _ num2: Double) -> Double {
        return num1 + num2
    }
}


class SubstractOperation {
     func minus(_ num1: Double, _ num2: Double) -> Double {
        return num1 - num2
    }
}

    class MultiplyOperation {
        func multiply(_ num1: Double, _ num2: Double) -> Double {
        return num1 * num2
    }
}
    
    class DivideOperation {
        func division(_ num1: Double, _ num2: Double) -> Double {
        return num1 / num2
    }
}

let calculator = Calculator()
print(calculator.add(2, 4))
print(calculator.minus(3, 1))
print(calculator.multiply(2, 3))
print(calculator.division(6, 0))


```
