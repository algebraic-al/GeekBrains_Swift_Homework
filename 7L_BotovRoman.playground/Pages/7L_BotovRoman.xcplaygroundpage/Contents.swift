

import UIKit
import Foundation

func nextLine() {
    print("-----\n")
}
//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.

//Единицы измерения для кофемашины
extension Double {
    var ml: Double {return self*1000}
    var l: Double {return self}
    var g: Double {return self*1000}
    var kg: Double {return self}
}

//Типы ингридиентов для напитков
struct ingProportion {
    
    var beans: Double //Coffee beans
    var water: Double //Water
    var milk: Double // Milk
}

class coffeeMachine {
    
    
    //Контейнеры с ингридиентами
    
    var stock = ingProportion(beans: 0, water: 0, milk: 0)
    let stockMax = ingProportion(beans: 0.5.kg, water: 5.l, milk: 2.l)
    
    //Функция заправки котейнеров
    
    enum refillError: Error {
        case incorrectValues
        case tanksFull
        case tooMuchVolumeToRefill
    }
    
    func refill(Refilling volume: ingProportion) -> (ingProportion?, refillError?) {
        guard volume.beans >= 0 && volume.milk >= 0 && volume.water >= 0 else {
            print("Неверные значения заправляемого объёма, укажите корректное.")
            return (nil, refillError.incorrectValues)
        }
        guard self.stock.beans + volume.beans <= self.stockMax.beans else {
            print("Заправляемый объём кофейных зёрен превышает объём контейнера.")
            return (nil, refillError.tooMuchVolumeToRefill)
                 }
        guard self.stock.milk + volume.milk <= self.stockMax.milk else {
            print("Заправляемый объём молока превышает объём контейнера.")
            return (nil, refillError.tooMuchVolumeToRefill)
        }
        guard self.stock.water + volume.water <= self.stockMax.water else {
            print("Заправляемый объём воды превышает объём контейнера.")
            return (nil, refillError.tooMuchVolumeToRefill)
        }
        //Повторяющийся код, как можно обратиться к self.stock.***, чтобы можно было например через switch сократить код?
        
        
        let v = volume
        self.stock = v
        if self.stock.beans == self.stockMax.beans && self.stock.milk == self.stockMax.milk && self.stock.water == self.stockMax.water {
            print("Кофемашина полностью заправлена.")} else {
                print("Кофемашина заправлена. Кофейные зёрна: \(self.stock.beans.g) грамм, молоко: \(self.stock.milk.l) литров, вода: \(self.stock.water.l) литров.")}
        return (self.stock, nil)
        }
    
    func checkStock() {
        print("Кофейные зёрна: \(String(format:"%.0f", self.stock.beans.g)) грамм, молоко: \(String(format:"%.2f", self.stock.milk.l)) литров, вода: \(String(format:"%.2f", self.stock.water.l)) литров.")
    }
        }
       
        
        
var DeLunghi = coffeeMachine()

//Проверка функции заправки
print(DeLunghi.stock)
DeLunghi.refill(Refilling: ingProportion(beans: 0.4, water: 4.l, milk: 1.l))
print(DeLunghi.stock)
//Работает

DeLunghi.refill(Refilling: ingProportion(beans: -1, water: 0, milk: 0))

DeLunghi.refill(Refilling: ingProportion(beans: 1, water: 0, milk: 0))
DeLunghi.refill(Refilling: ingProportion(beans: 0.1, water: 7, milk: 0))

//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

struct ingrPortion {
    
    let beans: Double //Coffee beans
    let water: Double //Water
    let milk: Double // Milk
    let coffeeName: String
}

class brewCoffeeMachine: coffeeMachine {
    

//Названия напитков и пропоции ингридиентов для приготовления
    
    let coffeeMenu: [String : ingrPortion] = [
        "espresso": ingrPortion(beans: 0.010.kg, water: 0.035.l, milk: 0, coffeeName: "espresso"),
        "cappucino": ingrPortion(beans: 0.010.kg, water: 0.035.l, milk: 0.2.l, coffeeName: "cappucino"),
        "americano": ingrPortion(beans: 0.010.kg, water: 0.120.l, milk: 0, coffeeName: "americano"),
        "latte": ingrPortion(beans: 0.010.kg, water: 0.035.l, milk: 0.3.l, coffeeName: "latte")
    ]
//Функция приготовления кофе, ингридиентов должно хватать. Если нет - ошибка. После определённого количества приготовленных напитков, нужно почистить контейнер под гущу.
    
    enum brewError: Error {
        case notEnoughMilk
        case notEnoughWater
        case notEnoughBeans
        case cleanCoffeeGroundsTray
        case noSuchDrink
    }
    
    var coffeeGroundTray: Double = 0
    
   func brew(CoffeeName name: String) throws {
    //Проверка что такой напиток есть в меню
    guard name == coffeeMenu[name]?.coffeeName else {
            throw brewError.noSuchDrink
        }
    //Проверка на достаточное количество ингридиентов для приготовления
    
    guard coffeeMenu[name]!.beans <= self.stock.beans else {
        throw brewError.notEnoughBeans
    }
    guard coffeeMenu[name]!.milk <= self.stock.milk else {
        throw brewError.notEnoughMilk
    }
    guard coffeeMenu[name]!.water <= self.stock.beans else {
        throw brewError.notEnoughWater
    }
    guard coffeeGroundTray < 20 else {
        throw brewError.cleanCoffeeGroundsTray
    }
    
    //Приготовление кофе
    
    let b: Double = self.stock.beans - coffeeMenu[name]!.beans
    let m: Double = self.stock.milk - coffeeMenu[name]!.milk
    let w: Double = self.stock.water - coffeeMenu[name]!.water
    
    let stockAftewBrew = ingProportion(beans: b, water: w, milk: m)
    
    self.stock = stockAftewBrew
    self.coffeeGroundTray += 1
    
    print("Ваш \(coffeeMenu[name]!.coffeeName) готов. \n")
    
    //return self.stock
        
    }
    
    func cleanGroundCoffeeTray() -> Double {
        self.coffeeGroundTray = 0
        return coffeeGroundTray
    }
   
    
    /*
     
//Попытка сократить код на обработку ошибок и сделать функцию, которая ловит ошибки. Свифт не разрешил это делать. Выдал ошибку "Errors thrown from here are not handled because the enclosing catch is not exhaustive". Как реализовать print ошибок, чтобы не дублировать код при вызове функции для каждого значения?
     
    func brewWithCatch(drinkName: String) {
        do {
            try brew(CoffeeName: drinkName)  //Errors thrown from here are not handled because the enclosing catch is not exhaustive
        } catch brewCoffeeMachine.brewError.cleanCoffeeGroundsTray {
            print("Контейнер кофейной гущи заполнен.")
        } catch brewCoffeeMachine.brewError.notEnoughMilk {
            print("Недостаточно молока. Заправьте кофемашину.")
        } catch brewCoffeeMachine.brewError.notEnoughWater {
            print("Недостаточно воды. Заправьте кофемашину.")
        } catch brewCoffeeMachine.brewError.notEnoughBeans {
            print("Недостаточно кофейных зёрен. Заправьте кофемашину.")
        } catch brewCoffeeMachine.brewError.noSuchDrink {
            print("Такого напитка нет в меню, выберите другой напиток.")
        }
 
    }*/
}

var nescafe = brewCoffeeMachine()

nescafe.refill(Refilling: ingProportion(beans: 0.1.kg, water: 1.l, milk: 0.5.l))

nextLine()


//print(nescafe.coffeeMenu["espresso"]!)


try nescafe.brew(CoffeeName: "espresso")
nextLine()
nescafe.checkStock()
nextLine()
print(nescafe.coffeeGroundTray)
nextLine()
try? nescafe.brew(CoffeeName: "capucino")
nextLine()
nescafe.checkStock()
nextLine()
print(nescafe.coffeeGroundTray)
nextLine()
try nescafe.brew(CoffeeName: "latte")
nextLine()
nescafe.checkStock()
nextLine()
print(nescafe.coffeeGroundTray)
nextLine()
try nescafe.brew(CoffeeName: "cappucino")
nextLine()
nescafe.checkStock()
nextLine()
print(nescafe.coffeeGroundTray)
nextLine()
try nescafe.brew(CoffeeName: "espresso")
nextLine()
nescafe.checkStock()
nextLine()
print(nescafe.coffeeGroundTray)
nextLine()


do {
    try nescafe.brew(CoffeeName: "latte")
} catch brewCoffeeMachine.brewError.cleanCoffeeGroundsTray {
    print("Контейнер кофейной гущи заполнен.")
} catch brewCoffeeMachine.brewError.notEnoughMilk {
    print("Недостаточно молока. Заправьте кофемашину.")
} catch brewCoffeeMachine.brewError.notEnoughWater {
    print("Недостаточно воды. Заправьте кофемашину.")
} catch brewCoffeeMachine.brewError.notEnoughBeans {
    print("Недостаточно кофейных зёрен. Заправьте кофемашину.")
} catch brewCoffeeMachine.brewError.noSuchDrink {
    print("Такого напитка нет в меню, выберите другой напиток.")
}
