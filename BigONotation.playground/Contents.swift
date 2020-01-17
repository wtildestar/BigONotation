// ***************
// Найти самый короткий несортированный непрерывный подмассив
// ***************

func findUnsortedSubarray(array: [Int]) -> Int {
    
    var maxNum = array[0]
    // фиксирую индекс последней границы
    var end = 0
    
    let n = array.count
    var minNum = array[n - 1]
    var start = 1
    // подсчет в правую сторону
    for (index, currentItem) in array.enumerated() {
        maxNum = max(maxNum, currentItem)
        if currentItem < maxNum {
            end = index
        }
    }
    // подсчет в обратную сторону
    for (index, _) in array.enumerated() {
        minNum = min(minNum, array[n - 1 - index])
        if array[n - 1 - index] > minNum {
            start = n - 1 - index
        }
    }
    
    return end - start + 1
}

findUnsortedSubarray(array: [1, 4, 2, 3, 2, 6]) // 4
findUnsortedSubarray(array: [3, 6, 8, 2, 4, 7, 2, 7, 51]) // 8
findUnsortedSubarray(array: [1, 1]) // 0

// ***************
// Написать функцию которая переворачивает строку (обхожусь space complexity Space: O(1) чтобы задействовать меньше памяти)
// ***************

func reverseString(string: inout[Character]) {
    
    
    var last = string.count - 1
    var first: Int = 0
    while first < last {
//        let temp = string[first]
//        string[first] = string[last]
//        string[last] = temp
        (string[first], string[last]) = (string[last], string[first])
        first += 1
        last -= 1
    }
}
var charArray: [Character] = ["a", "k", "a", "b", "o", "s", " ", "n", "o", "m", "m", "o", "C"]
reverseString(string: &charArray)

// ***************
// Написать функцию, которая вернет true если в двух строках между ними будет не более одного отличия
// ***************

func isOneAwaySameLength(firstString: String, secondString: String) -> Bool {
    var countDifferent = 0
    for i in 0...firstString.count - 1 {
        // нахожу индексы первой и второй строки
        let indexFirst = firstString.index(firstString.startIndex, offsetBy: i)
        let indexSecond = secondString.index(secondString.startIndex, offsetBy: i)
        if firstString[indexFirst] != secondString[indexSecond] {
            countDifferent += 1
            if countDifferent > 1 {
                return false
            }
        }
    }
    return true
}

// s1 = "hello", s2 = "helo"
func isOneAwayDiffLength(firstString: String, secondString: String) -> Bool {
    var countDifferent = 0
    var i = 0
    while i < secondString.count {
        let indexFirst = firstString.index(firstString.startIndex, offsetBy: i + countDifferent)
        let indexSecond = secondString.index(secondString.startIndex, offsetBy: i)
        if firstString[indexFirst] == secondString[indexSecond] {
            // прибавляем i у обоих строк
            i += 1
        } else {
            countDifferent += 1
            // если разница в значениях больше одного - ошибка
            if countDifferent > 1 {
                return false
            }
        }
    }
    return true
}

func isOneAway(firstString: String, secondString: String) -> Bool {
    if firstString.count - secondString.count >= 2 || secondString.count - firstString.count >= 2 {
        return false
    } else if firstString.count == secondString.count {
        return isOneAwaySameLength(firstString: firstString, secondString: secondString)
    } else if firstString.count > secondString.count {
        return isOneAwayDiffLength(firstString: firstString, secondString: secondString)
    } else {
        return isOneAwayDiffLength(firstString: secondString, secondString: firstString)
    }
}

isOneAway(firstString: "hello", secondString: "helg")
isOneAway(firstString: "helo", secondString: "helg")
isOneAway(firstString: "hello", secondString: "hello")

// ***************
// Перевернуть Linked List связанный список
// ***************

// объект списка
class ListNode {
    var value: Int
    var next: ListNode?
    init(value: Int, next: ListNode?) {
        self.value = value
        self.next = next
    }
}
//
//let thirdNode = ListNode(value: 2, next: nil)
//let secondNode = ListNode(value: 4, next: thirdNode)
//let oneNode = ListNode(value: 3, next: secondNode) // будет связан со вторым объектом

func printList(head: ListNode?) {
    var currentNode = head
    while currentNode != nil {
        print(currentNode?.value ?? "-1")
        currentNode = currentNode?.next
    }
}

//printList(head: oneNode)

func reverseList(head: ListNode?) -> ListNode? {
    var currentNode = head
    var prev: ListNode?
    var next: ListNode?
    while currentNode != nil {
        // фиксирую следующий объект
        next = currentNode?.next
        // меняю следующий объект на предыдущий
        currentNode?.next = prev // nil в первой итерации
        // присваиваю предыдущему объекту текущий объект
        prev = currentNode
        currentNode = next
        
        currentNode = next
    }
    return prev
}

// ***************
// Объединить по значениям два отсортированных Linked List связанных списка
// ***************

func mergeTwoLists(list1: ListNode?, list2: ListNode?) -> ListNode? {
    guard list1 != nil else { return list2 }
    guard list2 != nil else { return list1 }
    
    // указатель который будет прыгать по всем значениям в двух списках
    // пустышка
    let dummyHead: ListNode = ListNode(value: 0, next: nil)
    // l1 - первый элемент в первом списке, l2 - второй элемент во втором списке
    var l1 = list1, l2 = list2
    // служит для заполнения следующего значения в пустышке
    var endOfSortedList: ListNode? = dummyHead
    while l1 != nil && l2 != nil {
        // фиксирую самый маленький элемент связанного списка
        if l1!.value <= l2!.value {
            endOfSortedList!.next = l1
            // передвигаю указатель вправо на единицу
            l1 = l1!.next
        } else {
            endOfSortedList!.next = l2
            l2 = l2!.next
        }
        // беру последнее число в списке вне зависимости от итерации
        endOfSortedList = endOfSortedList?.next
    }
    endOfSortedList?.next = l1 == nil ? l2 : l1
    // возвращаю с next тк у dummyHead по умолч value: 0
    return dummyHead.next
}

// ***************
// Дважды связанные списки
// ***************

class ListNodeTwice<T> {
    var value: T
    var next: ListNodeTwice?
    var previous: ListNodeTwice?
    init(value: T) {
        self.value = value
    }
}

struct LinkedList<T>: CustomStringConvertible {
    
    
    private var head: ListNodeTwice<T>?
    private var tail: ListNodeTwice<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: ListNodeTwice<T>? {
        return head
    }
    
    var last: ListNodeTwice<T>? {
        return tail
    }
    
    var count: Int {
        var currentNode = head
        var count = 0
        while currentNode != nil {
            count += 1
            currentNode = currentNode?.next
        }
        
        
        return count
    }
    
    mutating func append(value: T) {
        let newNode = ListNodeTwice(value: value)
        if tail != nil {
            // если в связанном списке имелись какие-то элементы, предыдущий узел будет указывать на текущий хвост
            newNode.previous = tail
            tail?.next = newNode
        } else {
            // если значений в связанном списке нет присваиваю newNode
            head = newNode
        }
        tail = newNode
    }
    
    // дескрипшн для корректного вывода в консоли
    var description: String {
        var text = "["
        var node = head
        
        while node != nil {
            text += "\(node!.value)"
            node = node?.next
            if node != nil { text += ", " }
        }
        return text + "]"
    }
    // удаляет любую ноду
    mutating func remove(node: ListNodeTwice<T>) -> T {
        let prev = node.previous
        let next = node.next
        
        // если у ноды которую хочу удалить есть предыдущий элемент
        if let prev = prev {
            // у предыдущей ноды следующее значение пойдет на следующее значение после удаляемого элемента
            prev.next = next
        } else {
            head = next
        }
        // обратная связь
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        
        node.previous = nil
        node.next = nil
        
        return node.value
        
    }
}

var list = LinkedList<Int>()
list.append(value: 1)
list.append(value: 2)
list.append(value: 3)
list.append(value: 4)
list.append(value: 5)
list.remove(node: list.first!)
list.description // [1,2,3]

var list2 = LinkedList<String>()

list2.append(value: "abc")
list2.append(value: "cdf")


// ***************
// Queue Data Structure
// ***************

struct Queue<T>:CustomStringConvertible {
    
    private var list = LinkedList<T>()
    
    var isEmpty: Bool {
        return list.isEmpty
    }
    
    var count: Int {
        return list.count
    }
    
    mutating func enqueue(element: T) {
        list.append(value: element)
    }
    
    mutating func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else { return nil }
        list.remove(node: element)
        return element.value
    }
    
    mutating func peek() -> T? {
        return list.first?.value
    }
    
    var description: String {
        return list.description
    }
}

var queue = Queue<Int>()
queue.enqueue(element: 3)
queue.enqueue(element: 4)
queue.enqueue(element: 5)
queue.enqueue(element: 6)

queue.dequeue()
queue.dequeue()
queue // [5, 6]
queue.peek() // 5

// ***************
// Создать поле с бомбами в игре Сапер
// Расширить доступную часть игрового поля при нажатии в игре Сапер
// ***************

func minesweeper(bombs: [[Int]], rows: Int, columns: Int) -> [[Int]] {
    var field = Array(repeating: Array(repeating: 0, count: columns), count: rows)
    for bomb in bombs {
        let row = bomb[0]
        let column = bomb[1]
        field[row][column] = -1
        // показываю соседним клеткам где находятся бомбы
        for i in row - 1...row + 1 {
            for j in column - 1...column + 1 {
                if (0 <= i) && (i < rows) && (0 <= j) && (j < columns) && (field[i][j] != -1) {
                    field[i][j] += 1
                }
            }
        }
    }
    return field
}

var field = minesweeper(bombs: [[0,4], [3,1]], rows: 4, columns: 5)
field.map { (array) in
//    print(array)
}

// Расширить доступную часть поля при нажатии
func click(field: inout [[Int]], givenI: Int, givenJ: Int) -> [[Int]] {
    var queue = Queue<[Int]>()
    let rows = field.count
    let columns = (field.first?.count)!
    
    if field[givenI][givenJ] == 0 {
        field[givenI][givenJ] = -2
        queue.enqueue(element: [givenI, givenJ])
    } else {
        return field
    }
    while !queue.isEmpty {
        let position = queue.dequeue()
        // проверяю соседние значения на 0
        for i in (position?.first)! - 1...(position?.first)! + 1 {
            for j in (position?.last)! - 1...(position?.last)! + 1 {
                // если i & j находятся в пределах поля и какой-то соседний равняется нулю
                if (0 <= i) && (i < rows) && (0 <= j) && (j < columns) && (field[i][j] == 0) {
                    field[i][j] = -2
                    queue.enqueue(element: [i,j])
                }
            }
        }
        
    }
    return field
}

let newField = click(field: &field, givenI: 2, givenJ: 3)
//print("------------")
newField.map { (array) in
//    print(array)
}

//[0, 0, 0, 1, -1]
//[0, 0, 0, 1, 1]
//[1, 1, 1, 0, 0]
//[1, -1, 1, 0, 0]
//------------
//[-2, -2, -2, 1, -1]
//[-2, -2, -2, 1, 1]
//[1, 1, 1, -2, -2]
//[1, -1, 1, -2, -2]


// ***************
// Поиск в структуре данных Binary
// ***************

//         12
//       /   \
//      6    15
//     /    /  \
//    2    13   20

// Объявление узла
class Node {
    var value: Int
    let leftChild: Node?
    let rightChild: Node?
    init(value: Int, leftChild: Node?, rightChild: Node?) {
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
}

// Левая ветвь
let secondNode = Node(value: 2, leftChild: nil, rightChild: nil)
let sixNode = Node(value: 6, leftChild: secondNode, rightChild: nil)

// Правая ветвь
let thirteenNode = Node(value: 13, leftChild: nil, rightChild: nil)
let twentyNode = Node(value: 20, leftChild: nil, rightChild: nil)
let fifteenNode = Node(value: 15, leftChild: thirteenNode, rightChild: twentyNode)
let headNode = Node(value: 12, leftChild: sixNode, rightChild: fifteenNode)

func search(node: Node?, searchValue: Int) -> Bool {
    
    if node == nil {
        return false
    }
    
    if node?.value == searchValue {
        return true
    } else if searchValue < node!.value {
            return search(node: node?.leftChild, searchValue: searchValue)
        } else {
        return search(node: node?.rightChild, searchValue: searchValue)
    }
}

search(node: headNode, searchValue: 13)

// Максимальная глубина бинарного дерева
func maxDepth(head: Node?) -> Int {
    guard let head = head else { return 0 }
    var maxLevel = 0
    var queue = Queue<Node>()
    queue.enqueue(element: head)
    while !queue.isEmpty {
        maxLevel += 1
        let count = queue.count
        for _ in 0..<count {
            let current = queue.dequeue()
            if let left = current?.leftChild {
                queue.enqueue(element: left)
            }
            if let right = current?.rightChild {
                queue.enqueue(element: right)
            }
        }
    }
    return maxLevel
}

maxDepth(head: headNode) // 3
