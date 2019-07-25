//
//  ViewController.swift
//  MyLeetCode
//
//  Created by yyyzzq on 2019/4/2.
//  Copyright © 2019 yyyzzq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func makeAction() {
//        var list = [11,8,3,3,3,9,7,1,2,5]
//        var list = [3,30,5,3,3,34,5,9]
        
//        let sort = MergeSort()
//        sort.mergeSort(&list)
//        print(list)
        
//        let sort = QuickSort()
//        sort.quickSort(&list)
//        print(list)
        
//        let sort = Sort()
//        sort.selectionSort(list: &list);
//        print(list)
        
//        let s = Solution()
//        s.findKthLargest(list, 1)
        
//        print(s.largestNumber(list))
//        let search = Search()
//        print(search.searchLast(list, 3))
        
//        let skip = SkipList<Int>()
//        skip.insert(10)
//        skip.insert(12)
//        skip.insert(31)
//        skip.insert(51)
//        skip.insert(16)
//        skip.insert(13)
//        skip.insert(21)
//        skip.insert(81)
//        skip.insert(99)
//        skip.printAll()
//        skip.find(21)
//        skip.delete(51)
//        skip.printAll()
        
        let tree = BinarySearchTree()
        let root = tree.sortedArrayToTree([1,2,3,4,5])
//        tree.deleteNode(root, 1)
//        tree.isSymmetric(root)
//        tree.diameterOfBinaryTree(root)
        tree.sumOfLeftLeaves(root)
    }
}

