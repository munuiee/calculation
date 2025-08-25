# Ch 2. 프로그래밍 기초 주차 과제
## Swift로 계산기 만들기
2025년 8월 20일 - 2025년 8월 25일 


# summary
- Xcode playground Swift ver 5 로 실행
- 목표: Swift로 계산기 만들기
- 포인트: 0 나눗셈 예외 처리, 여러 설계 시도(스위치/컴포지션/상속(오버라이드)/프로토콜)

## 이 프로젝트를 통해 배운 점
- 컴포지션, 상속, 프로토콜에 대해 감을 잡은 계기
- Double 나머지 계산 시 `truncatingRemainder` 학습
- 0 나눗셈 예외 처리 필요성

<br>

# 최종 코드
```swift

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
    
    
    // 분모가 0인 경우 에외처리
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



```
  
<br>

# ✏️ 회고
- 처음엔 로드맵 없이 시작해 우왕좌왕했지만, 여러 시도를 통해 배운 점이 많았다.  
- 스위치문, 상속, override 등을 거쳐 최종적으로 단순한 구조로 완성할 수 있었다.  
- 기본기를 더 갈고닦아야 한다는 걸 느꼈고, 직접 함수를 작성하며 자신감도 얻었다.  
- 이번 프로젝트로 “개발은 어렵지만 해낼 수 있다”는 확신을 조금 가지게 됐다.


<br>




# 과정

- Lv1. `switch` 문 사용하여 구현
- Lv2. 나머지 연산 추가 및 예외처리 고려
- Lv3. Composition & 상속 시도
- Lv4. 프로토콜 구현
- 해설자료를 참고하여 수정




<br>

#### 8월 20일

<br>

# Lv1
- 더하기, 빼기, 나누기, 곱하기 연산을 수행할 수 있는 Calculator 클래스를 만들기
- 생성한 클래스를 이용하여 연산을 진행하고 출력

<br>

### Lv1. `switch` 문 사용하여 구현
처음에 어떤 식으로 시작해야할지 막막했는데, 구글링을 통해 `switch` 문으로도 계산기를 만들 수 있다는 것을 알게 되었다. <br>
소수점 계산도 고려하여 반환 타입은 `Double` 로 설정했다. 


```swift
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



---

# Lv2
- Lv1에서 만든 Calculator 클래스에 “나머지 연산”이 가능하도록 코드를 추가하고, 연산 진행 후 출력
-   ex) 나머지 연산 예시 : 6을 3으로 나눈 나머지는 0 / 5를 3으로 나눈 나머지는 2
- 오류가 날 수 있는 ‘예외처리’ 상황에 대해 고민해보기 + 구현하기

<br>

### Lv2. 나머지 연산 추가 및 예외처리 고려

#### 🎯 트러블 슈팅

<br>



```swift
case "%":
    return num1 % num2
```

나머지 연산을 위해 `%` 연산자를 그대로 사용했는데, <br>
```swift
'%' is unavailable: For floating point numbers use truncatingRemainder instead
```
이런 오류가 떴다.

<br>

알아보니 % 연산자는 Int에만 정의가 되어있기 때문에 Double에선 사용이 불가능하다고 한다. <br>
Double 타입에서 `%` 연산자 사용시 `truncatingRemainder(dividingBy:)` 메서드를 사용해야 한다는 것을 알게되었다!

```swift
case "%":
  return num1.truncatingRemainder(dividingBy: num2)
```

<br>
함수에도 추가하여 전체적인 에러를 해결하였다.



```swift
func remainResult() -> Double {
      return num1.truncatingRemainder(dividingBy: num2)
    }
    
let remainResult = calculator.calculate(cal: "%")
print(remainResult)
```



<br>

##### 예외처리 상황
나는 여기서 대체 어떤 예외처리가 난다는 걸까 하고 고민을 했는데도 답이 안 나왔다. <br>
그러다가 우리팀원끼리 코드리뷰를 하면서 알게되었고, 나누기를 했을 때 분모가 0이면 어떻게 처리를 해야할지 생각해보았다. <br>
특정 조건이 맞지 않으면 즉시 종료되는 guard를 사용하였다. <br>

```swift

// 최종 예외처리 코드

func division(_ num1: Double, _ num2: Double) -> Double? {
    guard num2 != 0 else { return nil }
        return divisionResult.division(num1, num2)
}

print(calculator.division(20, 3) ?? 0) 

```
우선 Double에 `?`  를 붙여 옵셔널 처리를 해주었다.

<br>

```swift
// 출력 결과
Optional(6.6.666666666666667)
```
코드는 잘 돌아가지만 출력 결과가 이렇게 나와 병합 연산자 `??` 를 이용해 옵셔널을 안전하게 처리해주었다.

<br>
<br>

---

# Lv3
  - 아래 각각의 클래스들을 만들고 클래스간의 관계를 고려하여 Calculator 클래스와 관계 맺기
       -  AddOperation(더하기)
       -  SubtractOperation(빼기)
       -  MultiplyOperation(곱하기)
       -  DivideOperation(나누기)
   
<br>

### Lv3. Composition & 상속 시도

#### 8월 21일
우선 `클래스와 관계 맺기`가 어떤 의미인지 몰라서 찾아보았고, **계산기에는 Composition으로 하는 게 맞다는 판단**을 내렸다. <br>
하지만 클래스 간 연결이 익숙하지 않아 에러가 잦았고, 함수 리턴을 튜플로 시도하는 등 여러 번의 시행착오를 겪었다. <br>
부모 `Operation` 클래스를 만들고 자식 클래스에서 `override` 로 구현하였으나, 구조가 깔끔해지려면 Calculator와 연산 클래스의 관계 설계가 중요하다는 것을 알게 되었다.

<br>

#### 8월 22일
Calculator와 연산 클래스를 Composition 관계로 연결하고 싶었다.  <br>
- 시도1: 여러 연산 결과를 튜플로 리턴 → 문법적으로 맞지 않아 에러 발생.  <br>
- 시도2: Operation 부모 클래스 + 각 연산을 자식으로 override 구현했으나 에러 발생.  <br>
부모 클래스에 동일한 함수를 정의해준 후 자식에서 override하니 정상 동작하였다. 

<br>

#### 8월 22일
Operation 클래스에 연산 클래스들을 연결시켜 결과값을 도출하게 하고 이걸 Calculator 클래스에 연결해서 출력하고 싶었다. <br>
두 가지 방법을 시도했다. <br>
##### 첫 번째 방법
여러 연산 결과를 튜플로 리턴 → 문법적으로 맞지 않아 에러 발생.  <br>
구글링 해본 결과 함수도 리턴값을 여러개 넣을 수 있다고 해서 콤마로 구분하여 시도해봤으나 실패했다. <br>
<details>
<summary>코드보기</summary>
   
```swift
 func calculate() -> Double {
        return add.addResult(num1, num2), 
        minus.SubtractOperation()
    }
```
</details>


##### 두 번째 방법
`Operation` 이라는 부모 클래스를 생성한 후 아래 연산 클래스들을 `override` 해주어 부모 클래스에 상속시킨다. <br>
`Method does not override any method from its superclass` <br>
이 과정에서 상속을 쓸 때 무조건 함수 모양이 부모랑 같아야하는데 부모 클래스에 함수 정의가 없어서 에러가 생겼다. <br>
그래서 `Operation` 클래스에 파라미터와 반환값, 리턴값을 추가해줬더니 해결되었다. <br>

<details>
<summary>코드보기</summary>

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
```
</details>

<br>

하지만 내가 너무 어렵게 꼬아서 생각하는 건 아닐까 하는 의문이 들기 시작했다. 그리고 팀원들의 코드 리뷰를 보고 `override` 를 사용하지 않아도 충분히 구현 가능하다는 것을 깨달았다. <br>
그래서 `let` 을 이용해 Calculator 클래스에 연산 클래스들을 연결해주었다.
<br>


#### 🎯 트러블 슈팅

##### 1

```
Return from initializer without initializing all stored properties
```
프로퍼티 초기화 누락으로 생긴 에러로 var num1: Int = 0 기본값을 줌으로써 해결되었다.

<br>

##### 2

```
Missing argument label 'num2:' in call
```

파라미터 언더스코어 누락으로 생긴 오류이다. <br>

```swift
func add(_ num1: Int, num2: Int) -> Int
```
<br>

훑어보니 전부 `num2` 에만 언더스코어가 누락되어 있어 추가해주었고 해결되었다.

<br>

##### 3

```
Method does not override any method from its superclass
```
두 번째 방법으로 하다보니 이런 오류가 생겼다. 상속을 쓸 때 무조건 함수 모양이 부모랑 같아야 하는데 부모 클래스에 함수 정의가 없어 생긴 에러였다. <br>
Operation 클래스에 파라미터와 반환값, 리턴값을 추가해줘 해결하였다.

<br>


<details>
<summary>복합관계 Composition</summary>

* 한 클래스 안에 다른 클래스를 속성으로 두는 것.
* 예: Car 클래스 안에 Engine 객체가 들어가 있으면, 차는 엔진을 갖는다 라는 관계가 됨

<br>

    
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

</details>


<br>

##### 클래스 생성하기

```swift
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




##### `let`으로 Calculator 클래스에 연산 클래스 연결
```swift
let addResult = AddOperation()
let minusResult = SubtractOperation()
let multiplyResult = MultiplyOperation()
let divisionResult = DivideOperation()
```
<br>


##### Calculator 함수명 간단히 수정

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
    
    func division(_ num1: Double, _ num2: Double) -> Double? {
        guard num2 != 0 else { return nil }
            return divisionResult.division(num1, num2)
    }
```
<br>


<br>

```swift
let calculator = Calculator()
print(calculator.add(2, 4))
print(calculator.minus(3, 1))
print(calculator.multiply(2, 3))
print(calculator.division(20, 3) ?? 0) // 옵셔널이 nil이면 0을 대신 출력
print(calculator.remainder(6, 4) ?? 0)
```
<br>

##### 출력된 결과
<br>

<img width="257" height="107" alt="스크린샷 2025-08-25 오전 9 54 12" src="https://github.com/user-attachments/assets/d2a12eba-faa0-4fe5-af88-69408c80edf3" />

<br>
<br>


##### 나머지 연산 추가
`Double` 타입으로 시작했으나 결과값이 지저분하게 느껴져 나눗셈 빼고 전부 반환값을 `Int` 로 수정하였다.

```
class RemainderOperation {
    func remainder(_ num1: Int, _ num2: Int) -> Int {
        return num1 % num2
    }
}
```
<br>


---

# Lv4
-  AbstractOperation라는 **추상화된** 프로토콜 만들기
-  기존에 구현한 AddOperation(더하기), SubtractOperation(빼기), MultiplyOperation(곱하기), DivideOperation(나누기) 클래스들과 관계를 맺고 Calculator 클래스의 내부 코드를 변경

#### Lv4. 프로토콜 구현
문법 종합반 프로토콜 강의를 듣고 프로토콜 만들기를 시도해보았다. <br>
Class 안의 함수들을 `AbstractOperation` 프로토콜에 정의해주고 `AnyObject`를 채택하여 클래스 전용 프로토콜로 만들었다. <br>
그리고 수정하면서 처음에 기본값 초기화해준 것도 없앴다. 지역변수로 선언이 되기 때문에 필요가 없다는 것을 알게 되었다.

<br>

```swift
protocol AbstractOperation: AnyObject {
    func add(_ num1: Int, _ num2: Int) -> Int
    func minus(_ num1: Int, _ num2: Int) -> Int
    func multiply(_ num1: Int, _ num2: Int) -> Int
    func division(_ num1: Double, _ num2: Double) -> Double
    func remainder(_ num1: Int, _ num2: Int) -> Int
}
```


##### 클래스에 프로토콜 채택하기

```swift
class Calculator: AbstractOperation { }
```


<br>

#### 8월 25일

과제 해설 영상을 보면서 나눗셈 메서드의 매개변수 타입을 Int로 두고 데이터 형변환을 이용하여 Double로 반환한 것을 보고 나도 시도해보았다. <br>

```swift
// 수정 전
class DivideOperation {
    func division(_ num1: Double, _ num2: Double) -> Double {
        return num1 / num2
    }
}
```

```swift
// 수정 후
class DivideOperation {
    func division(_ num1: Int, _ num2: Int) -> Double {
        return Double(num1) / Double(num2)
    }
}
```

<br>

#### 🎯 트러블 슈팅
```
Type 'Calculator' does not conform to protocol 'AbstractOperation'
```

프로토콜의 매개변수 타입도 Calculator 클래스의 메서드와 똑같이 변경해주어야 한다.

```
protocol AbstractOperation: AnyObject {
    func division(_ num1: Int, _ num2: Int) -> Double?
}
```

에러까지 해결완료 하였다.





