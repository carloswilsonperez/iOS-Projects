import Cocoa

// option + click -> To get info about the type for a variable or constant
// command + 0 -> To toggle the navigator area
// option + command + 0 -> To toggle the utility area
// Cmd + Shift + O -> To open the search tool
// Cmd + Shift + J
// Cmd + L

// Data Types:
let forStrings: String
let forCharacters: Character
let forIntegers: Int
let forFloats: Float
let forDoubles: Double
let forBools: Bool


var greeting = "Hello, playground"
let a: Int16 = 200
let b: Int8 = 50
let c = a + Int16(b)

let url = URL(string: "https://www.google.com")

func returnOne(completion: () -> Void) -> Int {
    completion()
    return 1
}

func greetReturnedOne() {
    print("OK, the number 1 was returned")
}


print(returnOne(completion: greetReturnedOne))

// FUNCTIONS
// Functions are a data type in Swift. This means a function can actually be stored
// in a variable, or passed as a parameter to another function.
func greetingSent() -> Void {
    print("Ok, the greeting was sent, what now?")
}

func sendGreeting(_ greeting: String, to planet: String, completion: () -> Void) {
    print("\(greeting), \(planet)")
    completion()
}

sendGreeting("Hello", to: "World", completion: greetingSent)
sendGreeting("Hello", to: "World", completion: {// Using a closure
    print("Greeting was sent, tada!")
})

sendGreeting("Hello", to: "World") {// Trailing Closure notation
    print("Greeting was sent, yay!")
}

//Any function or closure with only one expression can implicitly return the value of that expression by omitting the return keyword
func hi() -> Int {
    5
}

let result = hi()
print(result)

func someFunctionThatTakesAClosure(closure: () -> Void) {
    closure()
}

// Calling function and providing a closure - traditional syntax
someFunctionThatTakesAClosure(closure: {
    print("Hello from a closure!")
})

// Closure trailing syntax - applies at invokation time
someFunctionThatTakesAClosure {
    print("Hello from a trailing closure")
}

// Closures

// Closure of type () -> ()
var greet = {
    print("Hello, World!")
}

// Closure of type (Int) -> Int
var greet2 = {(x: Int) -> Int in
    return x*2
}

// call the closure
greet()
greet2(4)

// define a function
func grabLunch(search: () -> ()) {
    
    // closure call
    search()
}

// function call
grabLunch(search: {
    print("Alfredo's Pizza: 2 miles away")
})

func grabMiddleName(fromFullName name: (String, String?, String)) -> String? {
    return name.1
}

let middleName = grabMiddleName(fromFullName: ("Alice", "Al", "Ward"))
if let theName = middleName {
    print(theName)
}

let volunteerCounts = [1,3,40,32,2,53,77,13]

func isAscending(_ i: Int, _ j: Int) -> Bool {
    return i < j
}
let volunteersSorted = volunteerCounts.sorted(by: isAscending)
print(volunteersSorted)

// Using closure expression
let volunteersSorted2 = volunteerCounts.sorted(by: {(i: Int, j: Int) -> Bool in
    return i < j
})

let volunteersSorted3 = volunteerCounts.sorted(by: { $0 < $1 })

let volunteersSorted4 = volunteerCounts.sorted { $0 < $1 } // Parenthesis were removed

var data = [1, 2, 3, 4]

data.sort { $0 > $1}

print(data)

// Capturing closure example
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        print(runningTotal)
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()    // 10
incrementByTen()    // 20
incrementByTen()    // 30

// The escaping optionals
var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    
    // Saving the completionHandler to be executed at some future moment
    completionHandlers.append(completionHandler)
}

someFunctionWithEscapingClosure { print("Hello") }
completionHandlers.count
completionHandlers.first?()

// SINGLETONS
class ChiefExecutiveOfficer {
    var salary = 1_000_000
    
    // Singleton via a type property
    static var shared = ChiefExecutiveOfficer()
    
    // Prevent direct initializaztion
    private init() {}
}

print(ChiefExecutiveOfficer.shared.salary)

// OPTIONALS
var name: String? = "Ana"

// Unwrapping an optional - Forced Unwrpping
print(name!) // Too risky!

// Unwrapping an optional - Conditional Unwrapping
if name != nil {
    print(name!)
}

// Unwrapping an optional - Optional Binding
if let myName = name {
    print(myName)
}

// Unwrapping an optional - Optional Chaining
if let initial = name?.first {
    print(initial)
}

print(name ?? "John Doe")

enum LightBulb {
    case on
    case off
    
    func surfaceTemperature(ambientTemperature ambient: Double) -> Double {
        switch self {
        case .on:
            return ambient + 150.0
            
        case .off:
            return ambient
        }
    }
    
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
            
        case .off:
            self = .on
        }
    }
}

var bulb = LightBulb.on // Instance of lightbulb
bulb.toggle()

print("the bulb is now \(bulb)")

var bulbTemperature = bulb.surfaceTemperature(ambientTemperature: 77.0)
print("the bulb's temperature is \(bulbTemperature)")


// In Swift, an enumeration is a value type, and, by default, methods on value types are not allowed to make changes to self.

// If you want to allow a method on a value type to change self, you need to mark the method as mutating, which makes the implicit self argument mutable

bulb.toggle()
bulbTemperature = bulb.surfaceTemperature(ambientTemperature: 77.0)
print("the bulb's temperature is \(bulbTemperature)")

// Enum with associatd values

enum ShapeDimensions {
    // point has no associated value - it is dimensionless
    case point
    
    // square's associated value is the length of one side
    case square(side: Double)
    
    // rectangle's associated value defines its width and height
    case rectangle(width: Double, height: Double)
    
    func area() -> Double {
        switch self {
        case .point:
            return 0
            
        case let .square(side: side):
            return side * side
            
        case let .rectangle(width: w, height: h):
            return w * h
        }
    }
    
    func perimeter() -> Double {
        switch self {
        case .point:
            return 0
            
        case let .square(side: side):
            return 4 * side
            
        case let .rectangle(width: w, height: h):
            return 2 * w + 2 * h
        }
    }
}

var squareShape = ShapeDimensions.square(side: 10.0)
var rectShape = ShapeDimensions.rectangle(width: 5.0, height: 10.0)
var pointShape = ShapeDimensions.point

print("square's area = \(squareShape.area())")
print("rectangle's area = \(rectShape.area())")
print("point's area = \(pointShape.area())")

print("square's perimeter = \(squareShape.perimeter())")
print("rectangle's perimeter = \(rectShape.perimeter())")
print("point's perimeter = \(pointShape.perimeter())")

// Arrays, Dictionaries, Sets
var coloresArray = Array<String>()
coloresArray.append("green")

var coloresSet =  Set<String>()
coloresSet.insert("yellow")

var coloresDict = [Int:String]()
coloresDict[17] = "red"


// Classes, Srtucts, OOP

struct Resolution {
    var width = 0
    var height = 0
}

let device1 = Resolution()
// device1.width = 100 Cannot assign property width because device1 was declared with let

var device2 = Resolution(width: 5, height: 100)
device2.width
device2.width = 50
device2.width

class A {
    func myMethod() {
        print("Saludos desde myMethod")
    }
}

class B: A {}
class C: B {
    func aMethodForC() {
        print("Saludos desde C")
        super.myMethod()
    }
}

var myB = B()
myB.myMethod()

var myC = C()
myC.myMethod()
myC.aMethodForC()

// Lazy properties
class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Algo de datos")
//Hasta esta línea, el importer no ha sido creado

// Property Observers
class StepConter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("El número de pasos va a subir hasta \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Has mejorado!")
            }
        }
    }
}

let stepCounter = StepConter()
stepCounter.totalSteps = 100
stepCounter.totalSteps = 50
stepCounter.totalSteps = 60



class Personaje {
    var vida : Int=50 {
        willSet(nuevaVida){
            print("hp:\(vida)")
        } didSet{
            if vida>oldValue{
                print("hp:\(vida) xd")
            }else if vida<oldValue {
                print("dead")
            }
        }
    }
}
let chief = Personaje()
chief.vida = 100
chief.vida = 10
chief.vida = 0

// Static Properties
class PersonInHome {
    static var presupuesto = 100
    var name = ""
    
    func hacerCompras(_ gasto: Int, _ detalle: String) -> Void {
        PersonInHome.presupuesto -= gasto
        print("\(name) compró \(detalle) y ahora el presupuesto es de \(PersonInHome.presupuesto)")
    }
}

// Mutating Methods
enum Thermostat {
    case off, low, middle, high
    
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .middle
        case .middle:
            self = .high
        case .high:
            self = .off
        }
    }
}

var myThermostat = Thermostat.off
print(myThermostat)

// Subíndices
struct TimesTable {
    let multiplier: Int
    
    subscript(index: Int) -> Int {
        return multiplier*index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print(threeTimesTable[6]) // 6 x 3 = 18

enum Planet: Int {
    case noPlanet, mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        if n <= 9 && n > 0 {
            return Planet(rawValue: n)!
        } else {
            return Planet(rawValue: 0)!
        }
    }
}

let mars = Planet[18] // noPlanet
mars

class MyClass {
    var aProperty: String?
}

/*
 Para los inicializadores con herencia, se deben cumplir las siguientes condiciones de manera obligatoria:
 
 Un inicializador designado llama a un designado de la super clase (implícita o explícitamente)
 Un inicializador por conveniencia solo puede llamar a otro de la misma clase
 El último init que se llame siempre debe ser designado
 */

// Failable initializer
enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    
    init?(symbol: Character) {
        switch(symbol) {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

let someUnit: TemperatureUnit? = TemperatureUnit(symbol: "K") // .kelvin
let someFailedUnit: TemperatureUnit? = TemperatureUnit(symbol: "h") // nil

class Product {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let edgar = Person()
edgar.residence = Residence()
if let roomCount = edgar.residence?.numberOfRooms {
    print("Edgar tiene \(roomCount) cuartos")
}


// GENERICS

struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else { return nil }
        return items.removeLast()
    }
    
    mutating func filter(_ closure: (Element) -> Bool) -> Stack<Element> {
        var filteredStack = Stack<Element>()
        var currentStack = self // shallow copy to avoid mutating the current array
        while let item = currentStack.pop() {
            if closure(item) {
                filteredStack.push(item)
            }
        }
        return filteredStack
    }
}

var intStack = Stack<Int>()
intStack.push(1)
intStack.push(6)
intStack.push(7)

let greaterThanFive = intStack.filter {$0 > 5}
print(greaterThanFive)

print(String(describing: intStack.pop()))
print(String(describing: intStack.pop()))
print(String(describing: intStack.pop()))
var stringStack = Stack<String>()
stringStack.push("this is a string")
stringStack.push("another string")

print(String(describing: stringStack.pop()))

// Generic functions and methods

func myMap<T,U>(_ items: [T], _ txform: (T) -> (U)) -> [U] {
    var result = [U]()
    for item in items {
        result.append(txform(item))
    }
    return result
}


let strings = ["one", "two", "three"]
let stringLengths = myMap(strings) { $0.count }
print(stringLengths)

// Type Constraints

func checkIfEqual<T: Equatable>(_ first: T, _ second: T) -> Bool {
    return first == second
}

print(checkIfEqual(1, 1))
print(checkIfEqual("a string", "a string"))
print(checkIfEqual("a string", "a different string"))

func checkIfDescriptionsMatch<T: CustomStringConvertible, U: CustomStringConvertible>(
    _ first: T, _ second: U) -> Bool {
        return first.description == second.description
    }

print(checkIfDescriptionsMatch(Int(1), UInt(1)))
print(checkIfDescriptionsMatch(1, 1.0))
print(checkIfDescriptionsMatch(Float(1.0), Double(1.0)))

enum Optional2<Wrapped> {
    case none
    case some(Wrapped)
}

var abc: Optional2<Int> = Optional2<Int>.none
print(abc)

enum Example {
    case number(Int)
    case NONE
    
    func get() -> Int {
        switch self {
        case .number(let num):
            return num
        case .NONE:
            return 0
        }
    }
}

var example1 = Example.number(5)
var example2 = Example.NONE

print(example1.get())
print(example2.get())

enum Beverage: CaseIterable {
    case coffee, tea, juice
}

let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// Prints "3 beverages available"

for beverage in Beverage.allCases {
    print(beverage)
}

// PROPERTY WRAPPERS
struct Town {
    @Logger(warningValue: 100) var population: Double = 10000
    @Logger(warningValue: 5) var officers: Double = 20
}

extension Town: CustomStringConvertible {
    var description: String {
        return "Population: \(population), wrapped by \(_population)"
    }
}

var miami = Town()
miami.population = 50
miami.population = 101
// Accessing a wrapped property prefixing it with $, gives you
// access to the projectedValue instead of the wrappedValue
print(miami.$population)
print(miami.population)
print(miami)
// Closure

let anIntFromClosure: Int = {
    let a = 10
    return a
}()
print(anIntFromClosure)

class SingletonExample {
    private(set) var dice: Int = 6
    static func shared (dice: Int) -> SingletonExample {
        return SingletonExample()
    }
    
    private init() {}
}

var singletonA = SingletonExample.shared(dice: 6)

singletonA.dice


// RANDOM NUMBERS

// arc4random() returns a random number between zero and (2^32 or UInt32.max) – 1
// the resulting number will be of type UInt32
print(arc4random())

// arc4random_uniform(n) returns a random number between zero and the (parameter minus one).
// the resulting number will be of type UInt32
print(arc4random_uniform(10))

// drand48() returns a random Double between 0.0 and 1.0
// the resulting number will be of type Double
print(drand48())

let randomInteger = Int(arc4random_uniform(50))

let numberIntOpen = Int.random(in: 0 ..< 100)
print("Number: \(numberIntOpen)")
//returns a random number from 0 - 99

let numberIntClosed = Int.random(in: 0 ... 100)
print("Number: \(numberIntClosed)")
//returns a random number from 0 - 100

// The .random(in:) function can be used on several primitive data types such as Int, Double, Float, and even Bool.
let decimal = Float.random(in: 0 ..< 1)
print("Decimal: \(decimal)")
//returns a random decimal number from 0.0 - 0.99999

// We can also easily randomize boolean now. No need for the usual random number from 0 – 1!
let TrueOrFalse = Bool.random()
print("Bool: \(TrueOrFalse)")
//returns a random boolean value True/False

// There is also a way to easily get a random element in a Collection (array, dictionary) data type via the .randomElement() function
let fruits = ["Banana", "Mango", "Apple", "Orange"]
let randomFruit = fruits.randomElement()
print("The computer selected: \(String(describing: randomFruit))")
//output: The computer selected Optional("Mango")



class Vehicle {
    let wheels = 0
    var engines: Int
    
    init(_ engines: Int) {
        self.engines = engines
    }
}

class Truck : Vehicle {
    override init(_ engines: Int) {
        super.init(engines)
    }
}

let truck = Truck(1)
print(truck.wheels)
print(truck.engines)

// String Reference Cycles (Retain Cycles)

class Pet {
    let name: String
    var owner: Owner?
    init(name: String) { self.name = name }
    
    deinit {
        print("Pet deallocated")
    }
}

class Owner {
    let name: String
    var pet: Pet?
    init(name: String) { self.name = name }
    
    deinit {
        print("Owner deallocated")
    }
}

var pet: Pet? = Pet(name: "Dog")
var owner: Owner? = Owner(name: "Alice")
pet?.owner = owner
owner?.pet = pet

pet = nil
owner = nil

// In the above case, the ARC could not deallocate the memory taken by the objects
// due to the retain cycle. The reference count of both the pet and the owner
// is always 1 as they reference one another.
print(owner?.pet!)
