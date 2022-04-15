import Cocoa
import UIKit
import SwiftyBeaver


let log = SwiftyBeaver.self

var greeting = "Hello, playground"

// add log destinations. at least one is needed!
let console = ConsoleDestination()  // log to Xcode Console

// use custom format and set console output to short time, log level & message
console.format = "$DHH:mm:ss$d $L $M"
// or use this for JSON output: console.format = "$J"

// add the destinations to SwiftyBeaver
log.addDestination(console)

// Now let’s log!
log.verbose("not so important")  // prio 1, VERBOSE in silver
log.debug("something to debug")  // prio 2, DEBUG in green
log.info("a nice information")   // prio 3, INFO in blue
log.warning("oh no, that won’t be good")  // prio 4, WARNING in yellow
log.error("ouch, an error did occur!")  // prio 5, ERROR in red

