//
//  Sort.swift
//  leetCode
//
//  Created by yyyzzq on 2019/3/27.
//  Copyright © 2019 yyyzzq. All rights reserved.
//

import UIKit

class Sort {
    
    // 冒泡排序
    func bubbleSort(list: inout [Int]) {
        for i in 0..<list.count {
            var flag = false
            for j in 0..<list.count - i - 1 {
                if list[j] > list[j + 1] {
                    list.swapAt(j, j + 1)
                    flag = true
                }
            }
            if !flag {
                break
            }
        }
    }
    // 4 5 6 1 2 3
    // 插入排序
    func insertionSort(list: inout [Int]) {
        for i in 1..<list.count {
            let v = list[i]
            var j = i
            while j > 0 && list[j - 1] > v {
                list[j] = list[j - 1] // 移动
                j -= 1
            }
            list[j] = v; // 替换
        }
    }
    
    public func selectionSort(list: inout [Int]) {
        for i in 0..<list.count {
            for j in (i + 1)..<list.count {
                var min = i
                if list[j] < list[i] {
                   min = j
                }
                list.swapAt(i, min)
            }
        }
    }
}

class MergeSort {
    
    public func mergeSort(_ list: inout [Int]) {
        mergeSort(&list, from: 0, to: list.count - 1)
    }
    
    fileprivate func mergeSort(_ list: inout [Int], from low: Int, to high: Int) {
        
        guard low < high  else { return }
        
        let mid = (low + high) / 2
        mergeSort(&list, from: low, to: mid)
        mergeSort(&list, from: mid + 1, to: high)
        
        merge(&list, from: low, through: mid, to: high)
    }
    
    fileprivate func merge(_ list: inout [Int], from low: Int, through mid: Int, to high: Int) {
        
        var tmp = Array(repeating: 0, count: high - low + 1)
        var i = low, j = mid + 1, k = 0
        
        while i <= mid && j <= high {
            if list[i] <= list[j] {
                tmp[k] = list[i];
                i += 1
            } else {
                tmp[k] = list[j];
                j += 1
            }
            k += 1
        }
        
        if i <= mid {
            for index in i...mid {
                tmp[k] = list[index]
                k += 1
            }
        } else if j <= high {
            for index in j...high {
                tmp[k] = list[index]
                k += 1
            }
        }
        
        for index in 0..<tmp.count {
            list[low + index] = tmp[index]
        }
    }
}

class QuickSort {
    public func quickSort(_ list: inout [Int]) {
        quickSort(&list, from: 0, to: list.count - 1)
    }
    
    fileprivate func quickSort(_ list: inout [Int] ,from low: Int, to high: Int) {
        
        guard low < high else { return }
        
        var i = low
        let pivot = list[high]
        
        for j in low...high {
            if list[j] < pivot {
                list.swapAt(i, j)
                i += 1
            }
        }
        list.swapAt(i, high)
        
        quickSort(&list, from: low, to: i - 1)
        quickSort(&list, from: i + 1, to: high)
    }
}

extension Solution {
    
    // 215. 数组中的第K个最大元素
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var list = nums
        return quickSort(&list, from: 0, to: nums.count - 1, k)
    }
    
    fileprivate func quickSort(_ list: inout [Int] ,from low: Int, to high: Int, _ k: Int) -> Int {
        let pivot = list[high]
        var i = low
        
        for j in low...high {
            if list[j] > pivot {
                list.swapAt(i, j)
                i += 1
            }
        }
        list.swapAt(i, high)
        
        if k == i + 1 {
            return list[i]
        } else if k > i + 1 {
            return quickSort(&list, from: i + 1, to: high, k)
        } else {
            return quickSort(&list, from: low, to: i - 1, k)
        }
    }
    
    // 179. 最大数
    func largestNumber(_ nums: [Int]) -> String {
        var list = nums
        for i in 0..<list.count {
            var flag = false
            for j in 0..<list.count - i - 1 {
                let pre = String(list[j]) + String(list[j + 1])
                let suf = String(list[j + 1]) + String(list[j])
                if pre < suf {
                    list.swapAt(j, j + 1)
                    flag = true
                }
            }
            if !flag {
                break
            }
        }
        
        if list.first == 0 {
            return "0"
        }
        
        var result = ""
        for item in list {
            result += String(item)
        }
        return result
    }
}
