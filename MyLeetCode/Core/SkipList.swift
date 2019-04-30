//
//  SkipList.swift
//  MyLeetCode
//
//  Created by yyyzzq on 2019/4/9.
//  Copyright © 2019 yyyzzq. All rights reserved.
//

import UIKit

class SkipList<Element: Comparable> {
    private var dummy = SkipNode<Element>() // 哨兵结点，不存储数据
    private var level = 1

    func find(_ val: Element) -> SkipNode<Element>? {
        var node = dummy
        for i in (0..<level).reversed() {
            while let n = node.forwards[i], n.val! < val {
                node = n
            }
        }
        if let n = node.forwards[0], n.val == val {
            return n
        }
        return nil
    }

    func insert(_ val: Element) {
        let length = randomLevel()
        let node = SkipNode(v: val)
        node.length = length
        
        var list: Array = [SkipNode<Element>?](repeating: dummy, count: length)
        
        var p = dummy
        for i in (0..<length).reversed() {
            if let n = p.forwards[i], n.val! < val {
                p = n
            }
            list[i] = p
        }
        
        for i in 0..<length {
            node.forwards[i] = list[i]?.forwards[i]
            list[i]?.forwards[i] = node
        }
        
        if self.level < length {
            self.level = length
        }
    }
    
    func delete(_ val: Element) {
        var list: Array = [SkipNode<Element>?](repeating: dummy, count: level)
        
        var node = dummy
        for i in (0..<level).reversed() {
            if let n = node.forwards[i], n.val! < val {
                node = n
            }
            list[i] = node
        }
        
        if let n = node.forwards[0], n.val! == val {
            for i in 0..<level {
                if let m = list[i]?.forwards[i], m.val == val {
                    list[i]?.forwards[i] = list[i]?.forwards[i]?.forwards[i]
                }
            }
        }
    }
    
    private func randomLevel() -> Int {
        var level = 1
        for _ in 0..<16 {
            if arc4random() % 2 == 1 {
                level += 1
            }
        }
        return level
    }
    
    public func printAll() {
        var p = dummy
        while let n = p.forwards[0] {
            for _ in 0..<n.length {
                print("\(n.val!) ", terminator: "")
            }
            print("")
            p = n
        }
        print("")
    }
}

class SkipNode<Element: Comparable> {
    var val: Element?
    var forwards = Array<SkipNode<Element>?>(repeating: nil, count: 16)
    var length = 0

    init() {}
    init(v: Element) {
        self.val = v
    }
}
