/// High Order function.
/// High order functions are fucntons that take another function/closure as argument and return it.
///


// MARK: Pass Function to another Function

import Foundation

func addition(num1: Double, num2: Double) -> Double {
    return num1 + num2
}

func multiply(num1: Double, num2: Double) -> Double {
    return num1 * num2
}


func doMathOperation(operation: (_ x: Double, _ y: Double) -> Double, num1: Double, num2: Double ) -> Double {
    
    return operation(num1, num2)
}

doMathOperation(operation: multiply, num1: 10, num2: 10)
doMathOperation(operation: addition, num1: 15, num2: 20)


// MARK: Return function from another function

func doArithmeticOperation(isMultiply: Bool) -> (Double, Double) -> Double {
    func add(num1: Double, num2: Double) -> Double {
        return num1 + num2
    }
    
    func multiply(num1: Double, num2: Double) -> Double {
        return num1 * num2
    }
    
    return isMultiply ? multiply : add
}

let operationToMultiply = doArithmeticOperation(isMultiply: true)
let operationToAdd = doArithmeticOperation(isMultiply: false)

operationToMultiply(2, 4)
operationToAdd(5, 4)


/// The following high order functions uses closures as argument. You can use these functions to operate on swift collection types such as Array, set or Dictionary


// MARK: - MAP

/*
 - use map to loop over a collection and apply the same operation to each element in the collection.
 - The map function returns an array containing the result of applying a mapping or transformation function to each item
*/

// MARK: MAP on Array

// using for-in
let arrayOfInt = [2, 3, 4, 5, 6, 7]

var newArry: [Int] = []

for i in arrayOfInt {
    newArry.append(i * 10)
}
print(newArry)

// using map
let newValues = arrayOfInt.map {$0 * 3 }
print(newValues)


// MARK: MAP on Dictionary

let bookAmount = ["harrypotter" : 100.0, "junglebook" : 100.0]

let returnFromMap = bookAmount.map {(key, value) in
    return key.capitalized
}

print(returnFromMap)


// MARK: MAP on Set

let lengthInMeters: Set = [4.0, 6.2, 8.9]
let lengthInFeet = lengthInMeters.map { meters in meters * 3.2808 }

print(lengthInFeet)


/* What if you want to know the index of the collection while applying map to it?
 
 You will have to enumurate it before mapping
*/

let numbers = [1, 2, 3, 4, 5]
let indexAndNum = numbers.enumerated().map { (index, element ) in
    return "\(index) : \(element)"
}

print(indexAndNum)


// MARK: - FIlter

/*
    - use filter to loop over a collection and return an Array containing only those elements that match and include the condition
 */

// MARK: - Filter on Array

// consider the following code to filter even numbers from an array of integers

let arrayOfIntegers = [1,2,3,4,5,6,7,8,9]
var newIntegers : [Int] = []

for value in arrayOfIntegers {
    if value % 2 == 0 {
        newIntegers.append(value)
    }
}

print(newIntegers)


// simpler method to do this

var newEvenValues = arrayOfIntegers.filter { (someInt) in
    someInt % 2 == 0
}

print(newEvenValues)

var newEvenValues2 = arrayOfIntegers.filter({ (someInt: Int) -> Bool in return someInt % 2 == 0 })
print(newEvenValues2)


var newEvenValue3 = arrayOfIntegers.filter { $0 % 2 == 0 }
print(newEvenValue3)


// MARK: - Filter on Dictionary

let bookName = ["harrypotter": 100.0, "junglebook": 1000.0]
var newFilterBook = bookName.filter { $1 < 1000 }

print("new filter books\(newFilterBook)")


// MARK: - Filter on Set

let lengthInM: Set =  [4.0, 6.2, 8.9]
let lengthInF = lengthInM.filter {$0 > 5 }
print(lengthInF)


// MARK: Reduce

/*
    - user reduce to combine all items in one collection to create a single new value
 - the reduce function takes two arguments
 1. The initial value - which is used to store the initial value or the value or result returned by the closure from each iteration
 2. the other one is closure which takes two arguments, one is the initial value or the result from the previous execution of closure and the other one is next item in the collection
 */



let numberz = [2, 4, 5, 6, 8]
let numberSum = numberz.reduce(0, { x, y in
    x + y
})

print(numberSum)

let reducedSum = numberz.reduce(0) { $0 + $1 }
print(reducedSum)

// reduce can also work with strings
let stringChar = ["am", "by", "mb", "ayi"]
let fullName = stringChar.reduce("", +)
print(fullName)


// MARK: - Reduce on Dictionary
let bookShelf = ["ambyMbayi": 100.00, "kenya one": 90.0]
let reducedAmount = bookShelf.reduce(10) {(result, newAmmount) in
    return result + newAmmount.value
}
print(reducedAmount)

let reducedName = bookShelf.reduce("") {(result, newName) in
    return result + newName.key
}

print(reducedName)


// MARK: - FlatMap

/*
    - Flatmap is used to flatten a colleciton of collections. But before flattening the collection, we apply map to each elements
 */

let codes = [["abs", "def", "ghe"], ["abs", "khvy", "hdjr"]]
let newCodes = codes.flatMap {$0.map { $0.uppercased() }}
print(newCodes)


let codes2 = ["abs", "def", "ghe"]
let newCodes2 = codes2.flatMap {$0.uppercased()}
print(newCodes2)

let code3 = "amby mbayi heloo me"
let newCode3 = code3.flatMap {return $0}
print(newCode3)


// MARK: - FlatMap on Dictionary
// it returns an array of tuples after flatmapping. We have to convert it to an array:

let dictArray = [["key1": "value1", "key2": "value2"], ["key3": "value3"]]
let flatmapDict = dictArray.flatMap {$0}
print(flatmapDict)


var dictionary = [String: String]()

flatmapDict.forEach {
    dictionary[$0.0] = $0.1
}

print(dictionary)


// MARK: - FlatMap on Set

let numberSet: Set = [Set([4.0, 6.2, 8.9]), Set([9.9])]
let flatmapSet = numberSet.flatMap { $0 }

print(flatmapSet)

/*
 - Advantages of FlatMap
 */

// 1. Remove optionals

// evern more usefully it knows about optionals and will remove them from a collection

let people: [String?] = ["amby", nil,"peter", nil, "harry"]
let valid = people.flatMap { $0 }
print(valid)


// MARK: - CompactMap

/*
    - Returns an array containing the non-nil results of calling the given transformation with each element of this sequence
 */

// compactMap on array
let arrayCompact = [1, nil, 2, 4, nil]

print(arrayCompact.compactMap{$0 })


// compact on dictionary
let dict = ["a": 1, "b": nil]

print(dict.compactMap{$0})
