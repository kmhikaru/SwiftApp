//
//  Facts.swift
//  Animal Facts
//
//  Created by Hikaru on 2016/06/28.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import Foundation

class RandomFacts {
    let factsArray = ["A chameleon’s tongue can be as long as its body.", "The blue whale’s tongue weighs as much as an adult elephant", " Houseflies hum in the key of F. ","The howler monkey is the loudest land animal. Its can be heard from three miles away", "A cheetah can go from zero to 60 miles per hour in three seconds.", "Dogs are colorblind", " The electric eel can deliver jolts of electricity up to 600 volts", "An adult panda typically spends 12 hours a day eating","The largest giant squid recorded was 59 feet long", "Anteaters eat 35,000 ants a day.", "Snow leopards can leap to 50 feet in one jump", "When tarantulas molt, they can replace internal organs", " No two tigers have the exact same stripes.", "The largest bald eagle nest was 20 feet high and weighed two tons"]
    
    
    func randomFact() -> String{
        let arrayCount = UInt32(factsArray.count)
        let randomNumberUnsigned = arc4random_uniform(arrayCount)
        let randomNumberInt = Int(randomNumberUnsigned)
        
        return factsArray[randomNumberInt]
    }
}