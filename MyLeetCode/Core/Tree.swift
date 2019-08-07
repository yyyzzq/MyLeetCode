//
//  Tree.swift
//  MyLeetCode
//
//  Created by yyyzzq on 2019/7/19.
//  Copyright © 2019 yyyzzq. All rights reserved.
//

import UIKit

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init(_ val: Int) {
        self.val = val
    }
    
    /*
     前序遍历的递推公式：
     preOrder(r) = print r->preOrder(r->left)->preOrder(r->right)
     
     中序遍历的递推公式：
     inOrder(r) = inOrder(r->left)->print r->inOrder(r->right)
     
     后序遍历的递推公式：
     postOrder(r) = postOrder(r->left)->postOrder(r->right)->print r

     */
    func preOrder(_ node: TreeNode?) {
        guard node != nil else { return }
        
        print(node!.val)
        preOrder(node?.left)
        preOrder(node?.right)
    }
    func inOrder(_ node: TreeNode?) {
        guard node != nil else { return }
        
        inOrder(node?.left)
        print(node!.val)
        inOrder(node?.right)
    }
    func postOrder(_ node: TreeNode?) {
        guard node != nil else { return }
        
        postOrder(node?.left)
        postOrder(node?.right)
        print(node!.val)
    }
}

public class BinarySearchTree {
    
    public func find(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        var p = root
        while p != nil {
            if val > p!.val {
                p = p?.right
            } else if val < p!.val {
                p = p?.left
            } else {
                return p
            }
        }
        return nil
    }
    
    public func insert(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard root != nil else {
            return TreeNode(val)
        }
        
        var p = root
        while let t = p {
            if val > t.val {
                if t.right == nil {
                    t.right = TreeNode(val)
                    return t
                }
                p = t.right
            } else {
                if t.left == nil {
                    t.left = TreeNode(val)
                    return t
                }
                p = t.left
            }
        }
        
        return root
    }
    
    public func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
//        guard let rootNode = root else {
//            return nil
//        }
//
//        if key > rootNode.val {
//            rootNode.right = deleteNode(rootNode.right, key)
//        } else if key < rootNode.val {
//            rootNode.left = deleteNode(rootNode.left, key)
//        } else {
//            if rootNode.left == nil {
//                return rootNode.right
//            } else if rootNode.right == nil {
//                return rootNode.left
//            } else {
//                var minNode = rootNode.right!
//                while let leftNode = minNode.left {
//                    minNode = leftNode
//                }
//                rootNode.val = minNode.val
//                rootNode.right = deleteNode(rootNode.right, minNode.val)
//            }
//        }
//
//        return rootNode
        
        guard root != nil else {
            return nil
        }
        
        var node = root
        var nodeParent: TreeNode?
        while node != nil && node?.val != key {
            nodeParent = node
            if key > node!.val {
                node = node?.right
            } else {
                node = node?.left
            }
        }
        
        if node == nil {
            return root
        }
        
        if node?.left != nil && node?.right != nil {
            var minNode = node?.right
            var minParent = node
            while let leftNode = minNode?.left {
                minParent = minNode
                minNode = leftNode
            }
            node?.val = minNode!.val
            if minParent?.left?.val == minNode?.val {
                minParent?.left = minNode?.right
            } else {
                minParent?.right = minNode?.right
            }
        } else {
            var child: TreeNode?
            if let leftNode = node?.left {
                child = leftNode
            } else if let rightNode = node?.right {
                child = rightNode
            }
            
            if nodeParent == nil {
                return child
            } else {
                if nodeParent?.left?.val == node?.val {
                    nodeParent?.left = child
                } else {
                    nodeParent?.right = child
                }
            }
        }
        
        return root
    }
    
    // 108. 将有序数组转换为二叉搜索树
    func sortedArrayToBST(_ nums: [Int?]) -> TreeNode? {
        return sortedArrayToBST(nums, start: 0, end: nums.count - 1)
    }
    
    private func sortedArrayToBST(_ nums: [Int?], start: Int, end: Int) -> TreeNode? {
        guard start <= end else {
            return nil
        }
        
        let mid = start + (end - start) / 2
        guard let v = nums[mid] else {
            return nil
        }
        
        let root = TreeNode(v)
        root.left = sortedArrayToBST(nums, start: start, end: mid - 1)
        root.right = sortedArrayToBST(nums, start: mid + 1, end: end)
        
        return root
    }
    
    func sortedArrayToTree(_ nums: [Int?]) -> TreeNode? {
        return sortedArrayToTree(nums, 0)
    }
    
    private func sortedArrayToTree(_ nums: [Int?], _ index: Int) -> TreeNode? {
        if index > nums.count - 1 {
            return nil
        }
        guard let val = nums[index] else {
            return nil
        }
        
        let node = TreeNode(val)
        node.left = sortedArrayToTree(nums, index * 2 + 1)
        node.right = sortedArrayToTree(nums, index * 2 + 2)
        
        return node
    }
    
    // 100. 相同的树
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        guard p != nil && q != nil else {
            return true
        }
        
        guard p?.val == q?.val else {
            return false
        }
        
        let left = isSameTree(p?.left, q?.left)
        let right = isSameTree(p?.right, q?.right)
        
        return left && right
    }
    
    // 101. 对称二叉树
    func isSymmetric(_ root: TreeNode?) -> Bool {
        return isSymmetric(root?.left, root?.right)
    }
    
    private func isSymmetric(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
        if left == nil && right == nil {
            return true
        }
        
        if let l = left, let r = right {
            if l.val != r.val {
                return false
            }
            return isSymmetric(l.left, r.right) && isSymmetric(l.right, r.left)
        }
        // 一个有节点，一个没有节点
        return false
    }
    
    // 226. 翻转二叉树
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        if root?.left == nil && root?.right == nil {
            return root
        }
        
        let left = invertTree(root?.right)
        let right = invertTree(root?.left)
        
        root?.left = left
        root?.right = right
        
        return root
    }
    
    // 111. 二叉树的最小深度
    func minDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        let left = minDepth(root?.left)
        let right = minDepth(root?.right)
        
        if left == 0 || right == 0 {
            return left + right + 1
        }
        return min(left, right) + 1
    }
    
    // 104. 二叉树的最大深度
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        let left = maxDepth(root?.left)
        let right = maxDepth(root?.right)
        
        return max(left, right) + 1
    }
    
    // 543. 二叉树的直径
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        var distance = 0
        let _ = diameterOfBinaryTree(root, &distance)
        return distance
    }
    
    private func diameterOfBinaryTree(_ root: TreeNode?, _  distance: inout Int) -> Int {
        guard let r = root else {
            return 0
        }
        let left = diameterOfBinaryTree(r.left, &distance)
        let right = diameterOfBinaryTree(r.right, &distance)
        
        distance = max(distance, left + right)
        
        return max(left, right) + 1
    }
    
    // 110. 平衡二叉树
    func isBalanced(_ root: TreeNode?) -> Bool {
        return isBalancedDepth(root) != -1
    }
    
    private func isBalancedDepth(_ root: TreeNode?) -> Int {
        guard let r = root else { return 0 }
        
        let left = isBalancedDepth(r.left)
        guard left != -1 else { return -1 }
        
        let right = isBalancedDepth(r.right)
        guard right != -1 else { return -1 }
        
        if abs(left - right) <= 1 {
            return max(left, right) + 1
        } else {
            return -1
        }
    }
    
    // 404. 左叶子之和
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        guard let r = root else {
            return 0
        }
        
        var sum = 0
        if let left = r.left {
            if left.left == nil && left.right == nil {
                sum += left.val
            } else {
                sum += sumOfLeftLeaves(left)
            }
        }
        
        if let right = r.right {
            sum += sumOfLeftLeaves(right)
        }
        
        return sum
    }
    
    // 114. 二叉树展开为链表
    func flatten(_ root: TreeNode?) {
        guard var r = root else {
            return
        }
        if r.left == nil && r.right == nil {
            return
        }
        
        flatten(r.left)
        flatten(r.right)
        
        let tmp = r.right
        root?.right = r.left
        root?.left = nil

        while let right = r.right {
            r = right
        }
        r.right = tmp
    }
    
    // 98. 验证二叉搜索树
    func isValidBST(_ root: TreeNode?) -> Bool {
        return isValidBST(root, nil, nil)
    }
    
    private func isValidBST(_ root: TreeNode?, _ lower: Int?, _ upper: Int?) -> Bool {
        guard let r = root else {
            return true
        }
        
        if let l = lower, l >= r.val {
            return false
        }
        if let u = upper, u <= r.val {
            return false
        }
        if !isValidBST(root?.left, lower, r.val) {
            return false
        }
        if !isValidBST(root?.right, r.val, upper) {
            return false
        }
        return true
    }
    
    // 102. 二叉树的层次遍历
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var levels = [[Int]]()
        guard let r = root else {
            return levels
        }
        
        var queue = [TreeNode]()
        queue.append(r)
        
        while !queue.isEmpty {
            var list = [Int]()
            for _ in 0..<queue.count {
                let node = queue.removeFirst()
                list.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            levels.append(list)
        }
        
        return levels
    }
    
    // 103. 二叉树的锯齿形层次遍历
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        var levels = [[Int]]()
        guard let r = root else {
            return levels
        }
        
        var queue = [r]
        var level = 0
        
        while !queue.isEmpty {
            var subList = [Int]()
            for _ in 0..<queue.count {
                let node = queue.removeFirst()
                if level % 2 == 0 {
                    subList.append(node.val)
                } else {
                    subList.insert(node.val, at: 0)
                }
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            levels.append(subList)
            level += 1
        }
        
        return levels
    }
    
    // 230. 二叉搜索树中第K小的元素
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        var result = 0
        var cur = 0
        
        kthSmallest(root, k, &cur, &result)
        return result
    }
    
    private func kthSmallest(_ root: TreeNode?, _ k: Int, _ cur: inout Int, _ result: inout Int) {
        guard let r = root else {
            return
        }
        
        if let left = r.left {
            kthSmallest(left, k, &cur, &result)
        }
        cur += 1
        if k == cur {
            result = r.val
            return
        }
        if let right = r.right {
            kthSmallest(right, k, &cur, &result)
        }
    }
    
    // 199. 二叉树的右视图
    func rightSideView(_ root: TreeNode?) -> [Int] {
        var levels = [Int]()
        guard let r = root else {
            return levels
        }
        
        var queue = [r]
        while !queue.isEmpty {
            let last = queue.last!
            levels.append(last.val)
            
            for _ in 0..<queue.count {
                let node = queue.removeFirst()
                
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
        }
        return levels
    }
    
    /*
     105. 从前序与中序遍历序列构造二叉树
     前序遍历 preorder = [3 | 9 | 20,15,7]
     中序遍历 inorder = [9 | 3 | 15,20,7]
     */
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        guard preorder.count > 0 && inorder.count > 0 else {
            return nil
        }
        return buildTree(preorder, 0, preorder.count - 1, inorder, 0, inorder.count - 1)
    }
    
    private func buildTree(_ preorder: [Int], _ preStart: Int, _ preEnd: Int, _ inorder: [Int], _ inStart: Int, _ inEnd: Int) -> TreeNode? {
        if preStart > preEnd || inStart > inEnd {
            return nil;
        }
        print(preStart,preEnd,inStart,inEnd)
        
        let root = TreeNode(preorder[preStart])
        
        var mid: Int?
        for i in inStart...inEnd {
            if inorder[i] == root.val {
                mid = i
                break
            }
        }
        
        if let mid = mid {
            root.left = buildTree(preorder, preStart + 1, preStart + (mid - inStart), inorder, inStart, mid - 1)
            root.right = buildTree(preorder, preStart + (mid - inStart) + 1, preEnd, inorder, mid + 1, inEnd)
        }
        
        return root
    }
    
    /*
     106. 从中序与后序遍历序列构造二叉树                
     中序遍历 inorder = [9 | 3 | 15,20,7]
     后序遍历 postorder = [9 | 15,7,20 | 3]
     */
    func postBuildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        return postBuildTree(inorder, 0, inorder.count - 1, postorder, 0, postorder.count - 1)
    }
    
    private func postBuildTree(_ inorder: [Int], _ inStart: Int, _ inEnd: Int, _ postorder: [Int], _ postStart: Int, _ postEnd: Int) -> TreeNode? {
        if inStart > inEnd || postStart > postEnd {
            return nil
        }
        
        let root = TreeNode(postorder[postEnd])
        var mid: Int?
        
        for i in inStart...inEnd {
            if inorder[i] == root.val {
                mid = i
            }
        }
        
        if let mid = mid {
            root.left = postBuildTree(inorder, inStart, mid - 1, postorder, postStart, postStart + (mid - inStart) - 1)
            root.right = postBuildTree(inorder, mid + 1, inEnd, postorder, postStart + (mid - inStart), postEnd - 1)
        }
        
        return root
    }
    
    // 112. 路径总和
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        guard let r = root else {
            return false
        }
        
        let v = sum - r.val
        if r.left == nil && r.right == nil {
            return v == 0
        }
        return hasPathSum(r.left, v) || hasPathSum(r.right, v)
    }
    
    // 113. 路径总和 II
    func pathSum(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
        var res = [[Int]]()
        var tmp = [Int]()
        pathSum(root, sum, &tmp, &res)
        return res
    }
    
    private func pathSum(_ root: TreeNode?, _ sum: Int, _ tmp: inout [Int], _ res: inout [[Int]]) {
        guard let r = root else {
            return
        }
        
        let v = sum - r.val
        tmp.append(r.val)
        
        if r.left == nil && r.right == nil {
            if v == 0 {
                res.append(tmp)
            }
        }
        
        pathSum(r.left, v, &tmp, &res)
        pathSum(r.right, v, &tmp, &res)
        tmp.removeLast()
    }
    
    // 437. 路径总和 III
    func pathSumIII(_ root: TreeNode?, _ sum: Int) -> Int {
        guard let root = root else {
            return 0
        }
        
        let value = pathsIII(root, sum)
        let left = pathSumIII(root.left, sum)
        let right = pathSumIII(root.right, sum)
        
        return value + left + right
    }
    
    private func pathsIII(_ root: TreeNode?, _ sum: Int) -> Int {
        guard let r = root else {
            return 0
        }
        
        var num = 0
        if sum == r.val {
            num += 1
        }
        
        num += pathsIII(r.left, sum - r.val)
        num += pathsIII(r.right, sum - r.val)
        
        return num
    }
    
    // 257. 二叉树的所有路径
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        var result = [String]()
        guard let root = root else {
            return result
        }
        
        binaryTreePaths(root, String(), &result)
        return result
    }
    
    private func binaryTreePaths(_ root: TreeNode?, _ path: String, _ result: inout [String]) {
        guard let root = root else {
            return
        }
        
        var path = path
        if root.left == nil && root.right == nil {
            path += "\(root.val)"
            result.append(path)
            return
        }
        
        path += "\(root.val)->"
        
        binaryTreePaths(root.left, path, &result)
        binaryTreePaths(root.right, path, &result)
    }
    
    // 617. 合并二叉树
    func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
        if t1 == nil && t2 == nil {
            return nil
        } else if t1 == nil {
            return t2
        } else if t2 == nil {
            return t1
        }
        
        t1?.val = t1!.val + t2!.val
        t1?.left = mergeTrees(t1?.left, t2?.left)
        t1?.right = mergeTrees(t1?.right, t2?.right)
        
        return t1
    }
}




