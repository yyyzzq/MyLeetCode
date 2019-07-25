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
        return nil;
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
}




