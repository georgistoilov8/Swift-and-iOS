// let variable is a const variable
// var variable is a variable which can be changed in some point in the future

var temprature = -1
if temprature <= 0 {
    print("Too cold to go outside")
} 

var tomorrow_temprature = 20
if tomorrow_temprature <= 0 {
    print("Too cold to go outside")
} else {
    print("It's summer")
}

var car_price = 20
var expression:String
switch car_price {
    case  0:
        expression = "null"
    case 1..<10:
        expression = "cheap"
    case 10..<30:
        expression = "a little bit expensive"
    case 30..<100:
        expression = "expensive"
    default:
        expression = "way to much"
}
print("The new BMW is \(expression) and is worth \(car_price)k")

// We can use tuples also
var point = (1,1)
print("Point:\(point)")

// We can have even n-tuple
let x = (1,2,3,4,5,6,7,8,9)
print("Point:\(x)")

// Cycles:
// for cycle:
for i in 0...5 {
    print("\(i)")
}

let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) power \(power) is \(answer)")

let names = ["Pesho", "Gosho", "Ivancho", "El Maestro", "John Smith"]
for name in names {
    print("Hello \(name)")
}

// We also can go trough dictionary: array with key and value
let numberOfLegs = ["Spiders": 8, "Ants": 6, "Cats": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName) have \(legCount) legs")
}

// While cycle
var z = 1024
while z > 0 {
    print("\(z)")
    z /= 2
}

z = 1024
repeat {
    print("\(z)")
    z /= 2
}while(z > 0)