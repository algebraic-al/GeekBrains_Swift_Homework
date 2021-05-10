
import UIKit
import Foundation

// 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
 

struct Queue<T: Comparable> {
    private(set) var elements: [T] = []
    
    mutating func add(_ element: T) {
        elements.append(element)
    }
    mutating func poll() -> T? {
        print("Элемент \(elements.first!) вышел из очереди, т.к. стоял первым. Следующий в очереди - \(elements[1]).")
        return elements.removeFirst()
    }
    
}

var intQueue = Queue<Int>()
repeat{
    for i in 17...21 {
        intQueue.add(i)
    }
} while intQueue.elements.count < 30

print(intQueue)

print(intQueue.poll()!)

print(intQueue)

repeat{
    intQueue.poll()
} while intQueue.elements.count > 25

print(intQueue)

//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)

extension Queue{
    func filter(element: T){
        print("Find \(elements.filter{$0 == element})")
    }
    
    mutating func sortAsc() -> [T] {
        return elements.sorted(by: > )
    }
    mutating func sortDsc() -> [T] {
        return elements.sorted(by: < )
    }
}

print(intQueue.sortAsc())
print(intQueue.sortDsc())


//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

extension Queue{
    subscript (index: Int) -> T? {
        return (index < elements.count ? elements[index] : nil)
    }
}

print(intQueue[12]!)
print(intQueue[77])
