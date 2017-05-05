//
//  ViewController.swift
//  Graphing
//
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var chartBorderStyle = ChartBorderStyle.none
    private var tests: [() -> Void] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the Chart's backgroundView underneath the pageControl.
        let backingView = Chart.shared.backingView
        backingView.translatesAutoresizingMaskIntoConstraints = false
        backingView.frame = view.frame
        view.insertSubview(backingView, belowSubview: pageControl)
        
        // pin the backing view to all of the edges.
        backingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // DEMO POINT: "Too new API" warning.
//        backingView.backgroundColor = UIColor.init(named: "backgroundColor")
        
        // add a closure that calls earch test setup method to the master array.
        tests.append({self.test1()})
        tests.append({self.test2()})
        tests.append({self.test3()})
        tests.append({self.test4()})
        tests.append({self.test5()})
        tests.append({self.test6()})
        tests.append({self.test7()})
        tests.append({self.test8()})
        tests.append({self.test9()})
        tests.append({self.test10()})
        
        // update the page control.
        pageControl.numberOfPages = tests.count
        pageControl.currentPageIndicatorTintColor = UIColor(white: 0.35, alpha: 1.0)
        pageControl.pageIndicatorTintColor =  UIColor(white: 0.85, alpha: 0.5)
        
        // set the current page.
        pageControl.currentPage = 0
        tests[pageControl.currentPage]()
        
//        let plot = firstPlot()
//        let _ = plot.darkenPlot()
        
        // DEMO POINT: "switch missing case statements" warning.
//        switch chartBorderStyle {
//            
//        }
    }
    
    private func test1() {
        LinePlot(yData: 0.124, 4.212412, 5, 3, 2).label = "Plot 1"
        LinePlot(yData: 3, 7, 2, 1, 9).label = "Really long name for a plot"
        LinePlot(yData: 2, 6, 8, 4, 5).label = "A name that's too long to be useful and should probably be truncated"
    }
    
    private func test2() {
        let data = XYData()
        for i in -10...5 {
            data.append(x: Double(i), y: Double(i * i))
        }
        
        let line = LinePlot(xyData: data)
        line.color = Color.pink
    }
    
    private func test3() {
        let sine = LinePlot(function: tan)
        sine.color = Color.purple
        sine.lineWidth = 3
        
        Chart.shared.bounds = Bounds(minX: -(.pi * 2), maxX: (.pi * 2), minY: -2, maxY: 2)
    }
    
    private func test4() -> () {
        let scatter1 = ScatterPlot(xyData: (1,3), (5,7), (3,2))
        scatter1.symbol = Symbol(shape: .circle)
        scatter1.color = Color.blue
        
        let scatter2 = ScatterPlot(xyData: (0.5, 6.5), (2.7, 4.8), (4.5, 7))
        scatter2.symbol = Symbol(shape: .square)
        scatter2.color = Color.green
        
        let scatter3 = ScatterPlot(xyData: (2,5), (1,7), (3,8), (4,2))
        scatter3.symbol = Symbol(shape: .triangle)
        scatter3.color = Color.green
    }
    
    private func test5() {
        let scatter1 = ScatterPlot(xyData: (2,5), (1,7), (3,8),(4,2))
        scatter1.symbol = Symbol(imageNamed: "Patriots", size: 64)
        
        let scatter2 = ScatterPlot(xyData: (1,2), (2, 0), (3, 3), (4, 1))
        scatter2.symbol = Symbol(imageNamed: "Bad Value", size: 8.0)
        
        let scatter3 = ScatterPlot(xyData: (1,4), (2, 6), (3, 2), (4, 5))
        scatter3.symbol = Symbol(imageNamed: "RedSox", size: 48.0)
    }

    private func test6() {
        let line = LinePlot(xyData: (2,5), (1,6), (3,8),(4,2))
        line.color = .green
        line.lineWidth = 4
        line.symbol = .none
        line.style = .dashed
        
        let line2 = LinePlot(xyData: (1,2), (2, 7), (3, 3), (4, 5))
        line2.color = Color.purple.darker(percent: 0.15)
        line2.symbol = Symbol(imageNamed: "Patriots", size: 48)
        line2.lineWidth = 2
        line2.style = .dotted
    }
    
    private func test7() {
        let _ = LinePlot { x in
            10 + x - x * x/2
        }
    }
    
    private func test8() {
        let sine = LinePlot(function: sin)
        sine.lineWidth = 4
        sine.color = .green
    }
    
    private func test9() {
        let sine = LinePlot(function: sin)
        sine.lineWidth = 3
        
        let parabola = LinePlot { x in
            10 + x - x * x/2
        }
        parabola.color = Color.green.darker(percent: 0.5)
        
        let cosine = LinePlot(function: cos)
        cosine.color = Color.blue.darker(percent: 0.1)
        cosine.lineWidth = 2

    }
    
    private func test10() {
        let plot = ScatterPlot(xyData: (1,4), (2, 6), (3, 2), (4, 5))
        
        plot.symbol = Symbol(imageNamed: "RedSox", size: 32.0)
        
        let line = LinePlot(xyData: (2,5), (1,7), (3,8),(4,2))
        
        line.color = Color.green.darker()
        line.lineWidth = 2
        line.symbol = Symbol(shape: .square, size: 16.0)
        
        let sine = LinePlot(function: sin)
        sine.color = Color.pink.darker()
    }

    @IBAction func pageChanged(_ sender: AnyObject) {
        
        Chart.shared.reset()
        
        let index = pageControl.currentPage
        tests[index]()
    }
    
    private func firstPlot() -> AbstractPointPlot? {
        return nil
    }
}

public protocol GraphTouchDelegate {
    
    func handleGraphTouchDown(event: UIEvent)
    
    func handleGraphTouchUp(event: UIEvent)
    
    func handleGraphTouchDrag(event: UIEvent)
}
