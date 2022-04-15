//: [Previous](@previous)

import Foundation
import Combine

/*
 
 What if we want something simple, that can’t fail. Something that will emit a single value and then finish.
 */

let myPublisher = Just(13)

let subscriber = myPublisher.sink { completion in
    switch completion {
    case .finished: print("Todo ha terminado bien")
    case .failure(let error): print("Ha ocurrido un error \(error.localizedDescription)")
    }
} receiveValue: { value in
    print("Ha recibido el valor \(value).")
}

// We also have the following syntax without trailing closures:
let cancellable: AnyCancellable = myPublisher.sink(
    receiveCompletion: { completion in
        print("cancellable completion \(completion)")
    },
    receiveValue: { value in
        print("cancellable value \(value)")
    }
)

/*
 Empty never emits and (as per default) immediately completes.
 */

let empty = Empty<Int, Never>()
let subscribeEmpty = empty.sink { int in
     print("Value: \(int)") // The value will never be printed.
}

/*
 If we wish to immediately fail without emitting a type, Fail has us covered.

 */

enum MyError: Error {
    case HorribleError(Int)
}

let fail = Fail<Any, MyError>(error: MyError.HorribleError(402))

let subscriber2 = fail.sink { completion in
    switch completion {
        case .finished:
            print("Todo ha terminado bien")
        
        case .failure(let error):
            print("Ha ocurrido un error \(error)")
    }
} receiveValue: { value in
    print("Ha recibido el valor \(value).")
}

/*
 Any Sequence ( Array, or anything that conforms to the Sequence Protocol)
 */

let integerPublisher = [0, 1, 2, 3, 4, 5].publisher

let subscribeInteger = integerPublisher.sink { value in
    print ("Values from integerPublisher \(value)")
}


/*
 A PassthroughSubject is an instance that can have several subscribers attached, and is an Operator. PassthroughSubject itself does not maintain a state, but rather (as the name suggests) pass through a value. A send() call will send values to Subscribers (previous to this, subscribers will not receive any values).

 */

var passThroughSubject = PassthroughSubject<Int, Never>()

passThroughSubject.send(1)   // Get's lost

let pass = passThroughSubject.sink(
    receiveValue: { value in  print("passThroughSubject \(value)" ) }
)

passThroughSubject.send(2)

// CurrentValueSubject

var currentSubject = CurrentValueSubject<Int, Never>(10)


let current = currentSubject.sink(receiveValue: { value in
    print("currentSubject \(value)" ) }
)

currentSubject.send(11)
currentSubject.send(12)


let passString = PassthroughSubject<String, MyError>()

let stringCancellable = passString.handleEvents(receiveSubscription: { (subscription) in
    print("receiveSubscription!")
}, receiveOutput: { _ in
    print("receiveOutput!")
}, receiveCompletion: { _ in
    print("receiveCompletion")
}, receiveCancel: {
    print("receiveCancel")
})
.replaceError(with: "Failure")
.sink { (value) in
    print("Subscriber received value: \(value)")
}
passString.send("Hello, World!")
passString.send(completion: .failure(MyError.HorribleError(500)))

/*
 Futures
 */

let future = Future<Bool, Never> { promise in
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        promise(.success(true))
    }
}
let fut = future.sink(
    receiveCompletion:
    {
        val in
        print("Future: \(val)")
}
,
receiveValue: { val in
    print("Received \(val)")
})

// Ejemplo suscriptores

class ClasePublicadora {
    var futuro:Future<String,Never> {
        Future<String,Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                promise(.success("OK"))
            }
        }
    }
    
    var subscriber:AnyCancellable?
    var subscribers = Set<AnyCancellable>()
    
    func start() {
        subscriber = futuro.sink { value in
            print("\(value)")
        }
        
        [1,3,5,6,7,8,10]
            .publisher
            .map { "\($0)€" }
            .sink { value in
                print("\(value)")
            }
            .store(in: &subscribers)
    }
}

let clase1 = ClasePublicadora()
clase1.start()

// Ejemplo sujetos de valor actual
let subject = CurrentValueSubject<Int,Never>(0)
subject.value

subject.send(1)

subject.send(2)
subject.value

sleep(1)

let subscription = subject.sink(receiveValue: { print("Recibí el valor \($0).") })

sleep(1)

subject.send(3)

subject.send(completion: .finished)

subject.send(4)


// Sujetos declarativos.
// Ejemplo sujetos de paso a través
enum ErroresVarios:Error, LocalizedError {
    case haCascado(Int), haPetado, haReventado
    
    var errorDescription: String? {
        switch self {
        case .haCascado(let value):
            return "Ha cascado porque sí con el valor \(value)"
        case .haPetado:
            return "Ha petado porque le tocaba"
        case .haReventado:
            return "Ha reventado porque no le cabía más"
        }
    }
}

let subject3 = PassthroughSubject<Int,ErroresVarios>()

subject3.send(1)

let subscriber = subject3.sink { completion in
    switch completion {
    case .finished: print("Todo ha terminado bien")
    case .failure(let error): print("Ha ocurrido un error \(error.localizedDescription)")
    }
} receiveValue: { value in
    print("Ha recibido el valor \(value).")
}

subject3.send(2)
sleep(1)
subject3.send(3)
sleep(1)

// Si el stream termina con error:
subject3.send(completion: .failure(.haCascado(3)))

// Si termina sin error:
subject3.send(completion: .finished)

sleep(1)
subject3.send(4)



// Cancelando una subscripción
/*
Las suscripciones pueden cancelarse para que así aunque
 un publicador siga emitiendo nosotros no lo escuchemos.
 
 */


let subject2 = PassthroughSubject<String,Never>()

let subscriber2 = subject2.sink(receiveValue: { resultado in
    print(resultado)
})

subject2.send("A")
sleep(1)
subject2.send("Long")
sleep(1)
subject2.send("Time")
sleep(1)
subject2.send("Ago")
sleep(1)
subject2.send("in")
sleep(1)
subject2.send("a")
sleep(1)
subscriber2.cancel()
subject2.send("galaxy")
sleep(1)
subject2.send("far")
sleep(1)
subject2.send("far")
sleep(1)
subject2.send("away")

subject2.send(completion: .finished)

// OPERADORES

// Operadores de Transformación

let scores = [1, 2, 3, 4, 5, 6,]
for score in scores where score > 4 {
    print(score)
}



