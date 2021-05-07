
import UIKit
import Foundation

/*
 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
5. Создать несколько объектов каждого класса. Применить к ним различные действия.
6. Вывести сами объекты в консоль.
 */

// 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.

enum WindowState: String {
    case open = "открыты"
    case closed = "закрыты"
}

enum EngineState: String {
    case started = "заведен"
    case idle = "заглушен"
}

protocol Car {
    
    var brand: String { get set }
    var model: String { get set }
    var year: UInt { get set }
    var trunkVol: Float { get set }
    var engine: EngineState { get set }
    var windows: WindowState { get set }
    var trunkVolFilled: Float { get set }
    
    func carClassSpecificFunc()
}


func nextLine(){
    print("\n")
}

// 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).



extension Car {
    mutating func windowsSwitch() {
        if windows == .open {
            self.windows = .closed
        }
        else {self.windows = .open}
    }
}

extension Car {
    mutating func engineSwitch() {
        if engine == .idle{
            engine = .started
        }
        else {engine = .idle}
    }
}

extension Car {
    mutating func LoadToTruckBag(BaggageVolume v: Float){
        if self.trunkVolFilled + v <= trunkVol{
            self.trunkVolFilled += v
        } else {print("Превышен объём багажника.")}
}
    }

// 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.

class trunkCar: Car {
    
    var brand: String
    var model: String
    var year: UInt
    var trunkVol: Float
    var engine: EngineState
    var windows: WindowState
    var trunkVolFilled: Float
    
    //Попытка импелементации полимфорфизма - сделать функцию, которая будет одинаково вызываться, но в разных классах выполнять уникальную для класса функцию
    /*
     изначальная функция:
 mutating func trailerToggle() {
 if trailerStatus == .connected{
 trailerStatus = .absent
 }
 else {trailerStatus = .connected}
 }
 */
    
    func carClassSpecificFunc() {
        if trailerStatus == .connected{
            trailerStatus = .absent
        }
        else {trailerStatus = .connected}
    }
    
    
    //Уникальные для класса свойства
    let wheelsAmount: UInt
    var trailerStatus: additionalTrailer
    
    enum additionalTrailer: String{
        case connected = "Присутствует дополнительный прицеп."
        case absent = "Прицеп отсутствует."
    }
    
    
    
    init(brand: String, model: String, year: UInt, trunkVol: Float, amountOfWheels: UInt, extraTrailer: additionalTrailer) {
        self.brand = brand
        self.model = model
        self.year = year
        self.trunkVol = trunkVol
        self.engine = .idle
        self.windows = .closed
        self.trunkVolFilled = 0
        self.wheelsAmount = amountOfWheels
        self.trailerStatus = extraTrailer
    }
}

class SportCar: Car {
    
    enum HatchStatus: String {
        case opened = "открыт"
        case closed = "закрыт"
    }
    
    var brand: String
    var model: String
    var year: UInt
    var trunkVol: Float
    var engine: EngineState
    var windows: WindowState
    var trunkVolFilled: Float
    var hatch: HatchStatus
    
    //Попытка импелементации полимфорфизма - сделать функцию, которая будет одинаково вызываться, но в разных классах выполнять уникальную для класса функцию
    
    func carClassSpecificFunc() {
        if hatch == .closed{
            hatch = .opened
        } else {
            hatch = .closed
        }
    }
    init(brand: String, model: String, year: UInt, trunkVol: Float, hatch: HatchStatus) {
        self.brand = brand
        self.model = model
        self.year = year
        self.trunkVol = trunkVol
        self.engine = .idle
        self.windows = .closed
        self.trunkVolFilled = 0
        self.hatch = hatch
    }
}

//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Спорткар \(brand) \(model) \(year) года выпуска. Сейчас двигатель \(engine.rawValue). Окна \(windows.rawValue). Занятое место в багажнике: \(trunkVolFilled) из \(trunkVol) литров. Люк \(hatch.rawValue)."
    }
}

extension trunkCar: CustomStringConvertible {
    var description: String {
        return "Грузовик \(brand) \(model) \(year) года выпуска. Количество колёс - \(wheelsAmount). Сейчас двигатель \(engine.rawValue). Окна \(windows.rawValue). Занятое место в багажнике: \(trunkVolFilled) из \(trunkVol) литров. \(trailerStatus.rawValue)"
    }
}
// 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
// 6. Вывести сами объекты в консоль.


var chevroletCamaro = SportCar(brand: "Chevrolet", model: "Camaro", year: 2017, trunkVol: 120, hatch: .closed)
var scaniaR600 = trunkCar(brand: "Scania", model: "R600", year: 2005, trunkVol: 40000, amountOfWheels: 8, extraTrailer: .connected)
var lambo = SportCar(brand: "Lamborghini", model: "Gallardo", year: 2007, trunkVol: 100, hatch: .closed)
var man = trunkCar(brand: "MAN", model: "M1000", year: 2000, trunkVol: 60000, amountOfWheels: 12, extraTrailer: .connected)

print(chevroletCamaro.description)
nextLine()
print(scaniaR600.description)
nextLine()
print(lambo.description)
nextLine()
print(man.description)
nextLine()
print("Загрузим в Камаро чемодан объёмом 40 литров.")
chevroletCamaro.LoadToTruckBag(BaggageVolume: 40)
print(chevroletCamaro.description)
nextLine()
print("Заведём МАН и отцепим прицеп.")
man.carClassSpecificFunc()
man.engineSwitch()
print(man.description)
nextLine()
print("Попробуем перегрузить весом Ламборджини, а потом откроем люк.")
lambo.LoadToTruckBag(BaggageVolume: 1000)
print(lambo.description)
lambo.carClassSpecificFunc()
print(lambo.description)

