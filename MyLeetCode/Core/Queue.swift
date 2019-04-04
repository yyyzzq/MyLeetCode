//
//  Queue.swift
//  leetCode
//
//  Created by yyyzzq on 2019/3/7.
//  Copyright © 2019 yyyzzq. All rights reserved.
//

import UIKit

// 622. 设计循环队列
class MyCircularQueue {
    
    private var queue: [Int]
    private var head: Int
    private var tail: Int
    private let capacity: Int
    
    /** Initialize your data structure here. Set the size of the queue to be k. */
    init(_ k: Int) {
        head = 0
        tail = 0
        capacity = k + 1
        queue = Array(repeating: 0, count: capacity)
    }
    /** Insert an element into the circular queue. Return true if the operation is successful. */
    
    func enQueue(_ value: Int) -> Bool {
        guard !isFull() else {
            return false
        }
        queue[tail] = value
        tail = (tail + 1) % capacity
        return true
    }
    /** Delete an element from the circular queue. Return true if the operation is successful. */
    
    func deQueue() -> Bool {
        guard !isEmpty() else {
            return false
        }
        head = (head + 1) % capacity
        return true
    }
    /** Get the front item from the queue. */
    
    func Front() -> Int {
        guard !isEmpty() else {
            return -1
        }
        return queue[head]
    }
    /** Get the last item from the queue. */
    
    func Rear() -> Int {
        guard !isEmpty() else {
            return -1
        }
        return queue[(tail + (capacity - 1)) % capacity]
    }
    /** Checks whether the circular queue is empty or not. */
    
    func isEmpty() -> Bool {
        return head == tail
    }
    /** Checks whether the circular queue is full or not. */
    
    func isFull() -> Bool {
        return head == (tail + 1) % capacity
    }
}

// 641. 设计循环双端队列
class MyCircularDeque {
    
    private var queue: [Int]
    private var head: Int
    private var tail: Int
    private let capacity: Int
    
    /** Initialize your data structure here. Set the size of the deque to be k. */
    init(_ k: Int) {
        head = 0
        tail = 0
        capacity = k + 2
        queue = Array(repeating: 0, count: capacity)
    }
    
    /** Adds an item at the front of Deque. Return true if the operation is successful. */
    func insertFront(_ value: Int) -> Bool {
        guard !isFull() else {
            return false
        }
        if isEmpty() {
            tail = (tail + 1) % capacity
        } else {
            head = (head + (capacity - 1)) % capacity
        }
        queue[head] = value
        return true
    }
    
    /** Adds an item at the rear of Deque. Return true if the operation is successful. */
    func insertLast(_ value: Int) -> Bool {
        guard !isFull() else {
            return false
        }
        queue[tail] = value
        tail = (tail + 1) % capacity
        return true
    }
    
    /** Deletes an item from the front of Deque. Return true if the operation is successful. */
    func deleteFront() -> Bool {
        guard !isEmpty() else {
            return false
        }
        head = (head + 1) % capacity
        return true
    }
    
    /** Deletes an item from the rear of Deque. Return true if the operation is successful. */
    func deleteLast() -> Bool {
        guard !isEmpty() else {
            return false
        }
        tail = (tail + (capacity - 1)) % capacity
        return true
    }
    
    /** Get the front item from the deque. */
    func getFront() -> Int {
        guard !isEmpty() else {
            return -1
        }
        return queue[head]
    }
    
    /** Get the last item from the deque. */
    func getRear() -> Int {
        guard !isEmpty() else {
            return -1
        }
        return queue[(tail + (capacity - 1)) % capacity]
    }
    
    /** Checks whether the circular deque is empty or not. */
    func isEmpty() -> Bool {
        return head == tail
    }
    
    /** Checks whether the circular deque is full or not. */
    func isFull() -> Bool {
        return head == (tail + 1) % capacity
    }
}

// 862. 和至少为 K 的最短子数组
extension Solution {
    
    func shortestSubarray(_ A: [Int], _ K: Int) -> Int {
        guard !A.isEmpty else {
            return -1
        }
        
        var sum = Array(repeating: 0, count: A.count)
        sum[0] = A.first!
        for i in 1..<A.count {
            sum[i] = sum[i - 1] + A[i]
        }
        
        var head = 0
        var tail = 0
        var len = -1
        var queue = Array(repeating: 0, count: A.count)
        
        for i in 0..<A.count {
            while head != tail && sum[i] <= sum[tail - 1] {
                tail -= 1
            }
            while head != tail && sum[i] - sum[head] >= K {
                let new_len = i - head;
                head += 1
                if (new_len < len) {
                    len = new_len;
                }
            }
            queue[tail] = i
            tail += 1
        }
        return len 
    }
}
