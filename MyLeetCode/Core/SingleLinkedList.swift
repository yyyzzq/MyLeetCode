//
//  SingleLinkedList.swift
//  LinkedList
//
//  Created by yyyzzq on 2019/2/25.
//  Copyright © 2019 yyyzzq. All rights reserved.
//

import UIKit

class Node<T> {
    var value: T?
    var next: Node?
    
    init() {}
    init(value: T) {
        self.value = value
    }
}

class SingleLinkedList<Element: Equatable> {
    private var dummy = Node<Element>() // 哨兵结点，不存储数据
    
    var size: Int {
        var num = 0
        var node = dummy.next
        
        while node != nil {
            num += 1
            node = node!.next
        }
        return num
    }
    
    var isEmpty: Bool {
        return dummy.next == nil
    }
    
    func node(with value: Element) -> Node<Element>? {
        var node = dummy.next
        while node != nil {
            if node!.value == value {
                return node
            }
            node = node!.next
        }
        return nil
    }
    
    // 约定：链表的 index 从 0 开始
    func node(at index: Int) -> Node<Element>? {
        var num = 0
        var node = dummy.next
        while node != nil {
            if num == index {
                return node
            }
            num += 1
            node = node!.next
        }
        return nil
    }
    
    func insertHead(value: Element) {
        insertHead(node: Node(value: value))
    }
    
    func insertHead(node: Node<Element>) {
        node.next = dummy.next
        dummy.next = node
    }
    
    func insert(at index: Int, _ newValue: Element) {
        insert(at: index, Node(value: newValue))
    }
    
    func insert(at index: Int, _ newNode: Node<Element>) {
        var num = 0
        var lastNode = dummy
        var tempNode = dummy.next
        
        repeat {
            if num == index {
                newNode.next = tempNode
                lastNode.next = newNode
                break
            }
            num += 1
            lastNode = tempNode!
            tempNode = tempNode!.next
        } while tempNode != nil
    }
    
    func insert(after node: Node<Element>, newValue: Element) {
        insert(after: node, newNode: Node(value: newValue))
    }
    
    func insert(after node: Node<Element>, newNode: Node<Element>) {
        newNode.next = node.next
        node.next = newNode
    }
    
    func insert(before node: Node<Element>, newValue: Element) {
        insert(before: node, newNode: Node(value: newValue))
    }
    
    func insert(before node: Node<Element>, newNode: Node<Element>) {
        var lastNode = dummy
        var tempNode = dummy.next
        while tempNode != nil {
            if newNode === tempNode {
                newNode.next = tempNode
                lastNode.next = newNode
                break
            }
            lastNode = tempNode!
            tempNode = tempNode!.next
        }
    }
    
    func delete(value: Element) {
        var lastNode = dummy
        var tempNode = dummy.next
        while tempNode != nil {
            if tempNode!.value == value {
                lastNode.next = tempNode!.next
                break
            }
            lastNode = tempNode!
            tempNode = tempNode!.next
        }
    }
    
    func delete(node: Node<Element>) {
        var lastNode = dummy
        var tempNode = dummy.next
        while tempNode != nil {
            if tempNode === node {
                lastNode.next = tempNode!.next
                break
            }
            lastNode = tempNode!
            tempNode = tempNode!.next
        }
    }
    
    // 单链表翻转
    func reverseSingleLinkedList<Element>(head: Node<Element>) -> Node<Element>? {
        let dummy = Node<Element>()
        dummy.next = head;
        let prevNode = head;
        var currNode = prevNode.next
        while currNode != nil {
            prevNode.next = currNode!.next
            currNode!.next = prevNode
            dummy.next = currNode
            currNode = prevNode.next
        }
        return dummy.next
    }
    
    // 检测环
    func hasCircle<Element>(head: Node<Element>) -> Bool {
        var fast = head.next?.next
        var slow: Node<Element>? = head.next
        while fast != nil {
            if fast === slow {
                return true
            }
            fast = fast!.next?.next
            slow = slow!.next
        }
        return false
    }
    
    // 寻找环的入口结点
    func detectCycle(head: Node<Element>) -> Node<Element>? {
        var fast = head.next?.next
        var slow: Node<Element>? = head.next
        while fast != nil {
            if fast === slow {
                break
            }
            fast = fast!.next?.next
            slow = slow!.next
        }
        if fast == nil {
            return nil;
        }
        // fast从头结点开始，slow从快慢指针相遇结点开始，
        // 两个指针速度相同
        fast = head
        while fast !== slow {
            fast = fast!.next!
            slow = slow!.next!
        }
        return fast;
    }
    
    // 获取环的长度
    func loopLength(head: Node<Element>) -> Int {
        var fast = head.next?.next
        var slow = head.next
        while fast != nil {
            if fast === slow {
                break
            }
            fast = fast!.next?.next
            slow = slow!.next
        }
        if fast == nil {
            return 0;
        }
        // 找出快慢指针相遇点之后，慢指针再次走一圈，直到遇到之前的快指针，便是环的长度。
        var len = 1;
        slow = slow!.next
        while fast !== slow {
            len += 1
            slow = slow!.next
        }
        return len;
    }
    
    func mergeSortedLists<Element: Comparable>(la: Node<Element>?, lb: Node<Element>?) -> Node<Element>? {
        let dummy = Node<Element>()
        var tail = dummy
        var pHead1 = la, pHead2 = lb
        while pHead1 != nil && pHead2 != nil {
            if pHead1!.value! <= pHead2!.value! {
                tail.next = pHead1
                pHead1 = pHead1!.next
            } else {
                tail.next = pHead2
                pHead2 = pHead2!.next
            }
            tail = tail.next!
        }
        if pHead1 != nil {
            tail.next = pHead1
        } else {
            tail.next = pHead2
        }
        return dummy.next
    }
    
    func removeNthFromEnd(head: Node<Element>, n: Int) -> Node<Element>? {
        let dummy = Node<Element>()
        dummy.next = head
        var fast: Node<Element>? = head
        var i = 1
        while i <= n && fast!.next != nil {
            fast = fast!.next
            i += 1
        }
        var slow = head
        while fast != nil {
            slow = slow.next!
            fast = fast!.next
        }
        if fast != nil {
            slow.next = slow.next!.next
        }
        return dummy.next
    }
}


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    
    // 21. 合并两个有序链表
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil && l2 == nil {
            return nil
        }
        if l1 == nil {
            return l2
        } else if l2 == nil {
            return l1
        }
        
        var tmpNode: ListNode?
        
        if l1!.val <= l2!.val {
            tmpNode = l1
            tmpNode?.next = mergeTwoLists(l1?.next, l2)
        } else {
            tmpNode = l2
            tmpNode?.next = mergeTwoLists(l2?.next, l1)
        }
        return tmpNode
    }
    
    /*
          pre cur
     dummy->1->2->3->4->5
     dummy->2->1->3->4->5
     dummy->3->2->1->4->5
     dummy->4>-3->2->1->5
     dummy->5->4->3->2->1
     */
    
    // 206. 反转链表
    func reverseList(_ head: ListNode?) -> ListNode? {
        let dummy = ListNode(0)
        dummy.next = head
        let prevNode = head
        var currNode = head?.next
        while currNode != nil {
            prevNode!.next = currNode!.next
            currNode!.next = dummy.next
            dummy.next = currNode
            currNode = prevNode!.next
        }
        return dummy.next
    }
    
    /*
     dummy->1->2->3->4->5
     dummy->1->3->2->4->5
     dummy->1>-4->3->2->5
     */
    // 92. 反转链表 II
    // 反转从位置 m 到 n 的链表。请使用一趟扫描完成反转。
    func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
        let dummy = ListNode(0)
        dummy.next = head
        var prevNode: ListNode? = head;
        var currNode = prevNode!.next
        var startNode = dummy
        var k = 1
        while currNode != nil && k < m {
            startNode = startNode.next!
            prevNode = prevNode?.next
            currNode = currNode?.next
            k += 1
        }
        while currNode != nil && k < n {
            prevNode!.next = currNode!.next
            currNode!.next = startNode.next
            startNode.next = currNode
            currNode = prevNode!.next
            k += 1
        }
        return dummy.next
        
//        let dummy = ListNode(0)
//        dummy.next = head
//
//        var prev:ListNode? = dummy
//        var cur = head
//        var start: ListNode?
//        var begin: ListNode?
//        var count = 1
//
//        while cur != nil && count <= n {
//            let temp = cur?.next
//            if count == m {
//                start = prev
//                begin = cur
//            } else if count > m {
//                cur?.next = prev
//            }
//            prev = cur
//            cur = temp
//            count += 1
//        }
//
//        start?.next = prev
//        begin?.next = cur
//
//        return dummy.next
    }
    
    // 19. 删除链表的倒数第N个节点
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        let dummy = ListNode(0)
        dummy.next = head
        var i = 1
        var fast: ListNode? = dummy
        var slow: ListNode? = dummy
        while i <= n + 1 && fast != nil {
            fast = fast!.next
            i += 1
        }
        while fast != nil {
            fast = fast!.next
            slow = slow!.next
        }
        slow?.next = slow?.next?.next
        return dummy.next
    }
    
    /*
     dummy->1->2->3->nil
     dummy->1->2->3->4->nil
     */
    
    // 876. 链表的中间结点
    func middleNode(_ head: ListNode?) -> ListNode? {
        var slow = head
        var fast = head
        while let fastNode = fast, let nextNode = fastNode.next {
            slow = slow!.next
            fast = nextNode.next
        }
        return slow
    }
    
    // 25. k个一组翻转链表
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        var end = head
        var i = 1
        while i < k && end != nil {
            end = end!.next
            i += 1
        }
        guard end != nil else {
            return head
        }

        i = 1
        var prev = head
        var curr = head?.next
        let dummy = ListNode(0)
        dummy.next = head
        var start = dummy
        
        while curr != nil {
            end = end?.next
            if i < k {
                prev!.next = curr!.next
                curr!.next = start.next
                start.next = curr
                curr = prev!.next
                i += 1
            } else {
                if end == nil {
                    return dummy.next
                }
                i = 1
                start = prev!
                prev = curr
                curr = prev!.next
            }
        }
        return dummy.next
    }
    
    // 23. 合并K个排序链表
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        guard !lists.isEmpty else {
            return nil
        }
        guard lists.count > 1 else {
            return lists[0]
        }
        
        let l1 = mergeKLists(Array(lists[0..<(lists.count / 2)]))
        let l2 = mergeKLists(Array(lists[(lists.count / 2)...]))
        
        return mergeTwoLists(l1, l2)
    }
}
