//: Playground - noun: a place where people can play


//See https://www.raywenderlich.com/115253/swift-2-tutorial-a-quick-start

import Cocoa

var str = "Hello, playground"

print("Hello World")

print("Hello");


let swiftTeam = 13
let iOSTeam = 54
let otherTeams = 48
var totalTeam = swiftTeam + iOSTeam + otherTeams
totalTeam+=1


let priceInferred = 19.99
let priceExplicit: Double = 19.99

let onSaleInferred = true
let onSaleExplicit: Bool = false

class TipCalculator {
    
    let total: Double
    let taxPct: Double
    let subtotal: Double
    
    
    init(total: Double, taxPct: Double) {
        self.total = total
        self.taxPct = taxPct
        self.subtotal = self.total / (self.taxPct + 1)
    }
    
    func calcTipWithTipPct(tipPct: Double) -> Double {
        return subtotal * tipPct
    }
    
    //return a dictionary of values, e.g. [18: 2.88, 15: 2.4, 20: 3.2]
    //Note that [Int: Double] is just a shortcut for Dictionary<Int, Double>.
    func returnPossibleTips() -> [Int: Double]{
        
        //let possibleTipsExplicit:[Double] = [0.15, 0.18, 0.20]
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        
        var retval = [Int: Double]()
        
        for possibleTip in possibleTipsInferred {
            let intPct = Int(possibleTip*100)
            // 3
            retval[intPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
    }
}

let tipCalc = TipCalculator(total: 20.00, taxPct: 0.25)
tipCalc.returnPossibleTips()

var dic = [String: Int]()
dic["Hello"] = 10;
print(dic)






