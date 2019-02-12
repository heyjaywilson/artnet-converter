import UIKit

var str = "Hello, playground"

func calcSubnetUniverse(fixtureUniverse: Int) -> [Int]{
    var subnet = fixtureUniverse/16
    if (fixtureUniverse % 16 == 0) {
        subnet = subnet - 1
    }
    let universe = fixtureUniverse - (subnet * 16) - 1
    
    return [subnet, universe]
}

var answer = calcSubnetUniverse(fixtureUniverse: 11)

func calcFixtureUniverse(s: Int, u: Int) -> Int {
    let fixtureUniverse = u + (s * 16) + 1
    return fixtureUniverse
}

var fixtAnswer = calcFixtureUniverse(s: 0, u: 10)
