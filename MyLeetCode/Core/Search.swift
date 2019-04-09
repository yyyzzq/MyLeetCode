//
//  Search.swift
//  MyLeetCode
//
//  Created by yyyzzq on 2019/4/8.
//  Copyright © 2019 yyyzzq. All rights reserved.
//

import UIKit

class Search {
    
    // 704. 二分查找
    func search(_ nums: [Int], _ target: Int) -> Int {
        var low = 0
        var high = nums.count - 1
        var mid: Int
        
        while low <= high {
            mid = low + (high - low) / 2
            if target < nums[mid] {
                high = mid - 1
            } else if target > nums[mid] {
                low = mid + 1
            } else {
                return mid
                /*
                 查找第一个值等于给定值的元素
                 if (mid == 0 || nums[mid - 1] != target) {
                 return mid
                 } else {
                 high = mid - 1
                 }
                 
                 查找最后一个值等于给定值的元素
                 if (mid == nums.count - 1 || nums[mid + 1] != target) {
                 return mid
                 } else {
                 low = mid + 1
                 }
                 */
            }
        }
        return NSNotFound
    }
    
    // 查找第一个大于等于给定值的元素
    func searchFirst(_ nums: [Int], _ target: Int) -> Int {
        var low = 0
        var high = nums.count - 1
        var mid: Int
        
        while low <= high {
            mid = low + (high - low) / 2
            if nums[mid] >= target {
                if (mid == 0 || nums[mid - 1] < target) {
                    return mid
                } else {
                    high = mid - 1
                }
            } else {
                low = mid + 1
            }
        }
        return NSNotFound
    }
    
    // 查找最后一个小于等于给定值的元素
    func searchLast(_ nums: [Int], _ target: Int) -> Int {
        var low = 0
        var high = nums.count - 1
        var mid: Int
        
        while low <= high {
            mid = low + (high - low) / 2
            if nums[mid] <= target {
                if mid == nums.count - 1 || nums[mid + 1] > target {
                    return mid
                } else {
                    low = mid + 1
                }
            } else {
                high = mid - 1
            }
        }
        return NSNotFound
    }
}
