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
