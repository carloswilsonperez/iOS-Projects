import Foundation

@propertyWrapper public struct Logger {
    private var storage: Double
    private var warningValue: Double
    
    public init(wrappedValue: Double, warningValue: Double = 1) {
        storage = wrappedValue
        self.warningValue = warningValue
    }
    
    public var wrappedValue: Double {
        set {
            print("Old value: \(storage) - New Value: \(newValue)")
            storage = newValue
            if (storage < warningValue) {
                print("WARNING: The value is getting too low")
            }
        }
        get {
            return storage
        }
    }
    
    public var projectedValue: Double {
        get {
            return 10000 // ideal population; it could be the storage also.
        }
    }
}
