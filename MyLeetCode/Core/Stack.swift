//
//  Stack.swift
//  leetCode
//
//  Created by yyyzzq on 2019/3/4.
//  Copyright © 2019 yyyzzq. All rights reserved.
//

import UIKit

class Stack {
    
    // 20. 有效的括号 ({[]}) ([)]
    func isValid(_ s: String) -> Bool {
        guard s.count % 2 == 0 else {
            return false
        }
        let map: [Character:Character] = ["(":")", "[":"]", "{":"}"]
        var tmpArray = Array<Character>()
        for c in s {
            if tmpArray.isEmpty {
                if map.values.contains(c) {
                    return false
                } else {
                    tmpArray.append(c)
                }
            } else if (c == map[tmpArray.last!]) {
                tmpArray.removeLast()
            } else if (map.values.contains(c)) {
                return false
            } else {
                tmpArray.append(c)
            }
        }
        return tmpArray.isEmpty
    }
}

// 155 最小栈
class MinStack {
    
    lazy private var list = Array<Int>()
    lazy private var minList = Array<Int>()

    /** initialize your data structure here. */
    init() {}

    func push(_ x: Int) {
        list.append(x)
        minList.append(min(x, minList.last ?? x))
    }

    func pop() {
        guard !list.isEmpty else {
            return
        }
        list.removeLast()
        minList.removeLast()
    }

    func top() -> Int {
        if list.isEmpty {
            return NSNotFound
        } else {
            return list.last!
        }
    }

    func getMin() -> Int {
        guard !minList.isEmpty else {
            return NSNotFound
        }
        return minList.last!
    }
}

// 232. 用栈实现队列
class MyQueue {
    
    //       4 5
    // 3 2 1
    
    lazy private var input = [Int]()
    lazy private var output = [Int]()
    
    /** Initialize your data structure here. */
    init() {}
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        input.append(x)
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        if output.isEmpty {
            inputToOutPut()
        }
        return output.popLast() ?? NSNotFound
    }
    
    /** Get the front element. */
    func peek() -> Int {
        if output.isEmpty {
            inputToOutPut()
        }
        return output.last ?? NSNotFound
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return input.isEmpty && output.isEmpty
    }
    
    func inputToOutPut() {
        while !input.isEmpty {
            output.append(input.removeLast())
        }
    }
}

// 844. 比较含退格的字符串
extension Solution {
    func backspaceCompare(_ S: String, _ T: String) -> Bool {
        var stackS = [Character]()
        var stackT = [Character]()
        
        for c in S {
            if c != "#" {
                stackS.append(c)
            } else {
                let _ = stackS.popLast()
                
            }
        }
        for c in T {
            if c != "#" {
                stackT.append(c)
            } else {
                let _ = stackT.popLast()
            }
        }
        return stackS == stackT
    }
}

// 224. 基本计算器
extension Solution {
    func calculate(_ s: String) -> Int {
        var num = [Int]()
        var symbol = [Character]()
        var tmp = 0
        var result = 0
        let map: Dictionary<Character,Int> = ["(":0, "+":1, "-":1, ")":0]
        
        for c in s {
            if c == " " {
                continue
            } else if var number = Int(String(c)) {
                if tmp != 0 {
                    num.removeLast()
                }
                number = tmp * 10 + number
                num.append(number)
                tmp = number
            } else {
                tmp = 0
                if c == "+" || c == "-" {
                    while !symbol.isEmpty && map[c]! <= map[symbol.last!] ?? 0 {
                        let r = cal(symbol.popLast(), num.popLast(), num.popLast())
                        num.append(r)
                    }
                    symbol.append(c)
                } else if c == "(" {
                    symbol.append(c)
                } else if c == ")" {
                    while !symbol.isEmpty {
                        if symbol.last == "(" {
                            symbol.removeLast()
                            break
                        } else {
                            let r = cal(symbol.popLast(), num.popLast(), num.popLast())
                            num.append(r)
                        }
                    }
                }
            }
        }
        
        while !num.isEmpty {
            result += cal(symbol.popLast(), num.popLast(), num.popLast())
        }
        return result
    }
    
    func cal(_ symbol: Character?, _ right: Int?, _ left: Int?) -> Int {
        var result = 0
        if let l = left, let r = right {
            switch symbol {
            case "+":
                result = l + r
            case "-":
                result = l - r
            default:
                break
            }
        } else if let r = right {
            return r
        } else if let l = left {
            return l
        }
        return result
    }
}

// 682. 棒球比赛
extension Solution {
    func calPoints(_ ops: [String]) -> Int {
        var stack = [Int]()
        var point = 0
        for op in ops {
            switch op {
            case "+":
                var num = 0
                if stack.count >= 2 {
                    num += stack[stack.count - 2]
                }
                if let prev = stack.last {
                    num += prev
                }
                stack.append(num)
                point += num
            case "D":
                var num = 0
                if let prev = stack.last {
                    num = prev * 2
                }
                stack.append(num)
                point += num
            case "C":
                if stack.count > 0 {
                    point -= stack.removeLast()
                }
            default:
                if let num = Int(op) {
                    stack.append(num)
                    point += num
                }
            }
        }
        return point
    }
}

// 496. 下一个更大元素 I
extension Solution {
    func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var stack = [Int]()
        var map = Dictionary<Int, Int>()
        var result = [Int]()
        
        for n in nums2 {
            while !stack.isEmpty && stack.last! < n {
                map[stack.removeLast()] = n
            }
            stack.append(n)
        }
        
        for n in nums1 {
            result.append(map[n] ?? -1)
        }
        return result
    }
}
