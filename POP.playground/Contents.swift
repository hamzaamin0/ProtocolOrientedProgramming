import Foundation

//class Distribution{ // base class
//
//    func sample() -> Double{ // we can sample a number from a distribution of numbers. This is a virtual method with virtual dispatch
//
//        fatalError("Must Override")
//    }
//
//    func sample(count: Int) -> [Double] { // a convenience method for sampling a bunch of numbers
//
//        return (1...count).map{_ in sample()}
//    }
//}
//
//
//class UniformDistribution: Distribution{ // a subclass which draws from a uniform distribution which means that each number comes in with equal probability
//
//    var range: ClosedRange<Int>
//
//    init(range: ClosedRange<Int>){
//
//        self.range = range
//    }
//
//    override func sample() -> Double {
//        return Double(Int.random(in: range))
//    }
//
//
//}
//
//
//// virtual dispatch in action
//let d20 = UniformDistribution(range: 1...20)
//d20.sample(count: 10)
//
//class GeometeryBaseClass{
//
//    func area() -> Double {
//
//        fatalError("Derived class must implement this")
//    }
//
//}
//
//extension GeometeryBaseClass{
//
//    @objc func perimeter() -> Double{ //this will not be put into v-table. this function will not be able to be overriden (because of extension it think) but the workaround for this is @objc/full message dispatch. @objc = full message dispatch. if we use static keyword it would end up every single time
//
//        fatalError("derived class must implement this ")
//    }
//}

protocol Distribution { //protocols have witness table instead of v table.
    
    func sample() -> Double
    func sample(count: Int) -> [Double]
}

extension Distribution{
    
    func sample(count: Int) -> [Double]{ //cutomization point
        
        return (1...count).map{ _ in sample() }
    }
}

struct UniformDistribution: Distribution{
    
    var range: ClosedRange<Int>
    
    init(range: ClosedRange<Int>){
        self.range = range
        
    }
    
    func sample() -> Double {
        return Double(Int.random(in: range))
    }
}

let d10 = UniformDistribution(range: 1...10)
d10.sample(count: 100)


print(d10.sample(count: 100).reduce(0) { ($0 + ($1 == 10 ? 1 : 0 )) }, " times") // to print how many time 10 has occured in the array
