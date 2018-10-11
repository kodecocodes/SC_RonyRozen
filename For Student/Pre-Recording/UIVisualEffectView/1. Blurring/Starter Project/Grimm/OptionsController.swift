/// Copyright (c) 2017 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class OptionsController: UIViewController {
  
  private var currentPage = 0
  @IBOutlet weak var readingModeSegmentedControl: UISegmentedControl!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var titleAlignmentSegmentedControl: UISegmentedControl!
  @IBOutlet weak var pageControl: UIPageControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let optionsView = UINib(nibName: "OptionsView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else { return }
    scrollView.scrollsToTop = false
    
    view.addSubview(optionsView)
    NSLayoutConstraint.activate([
      view.centerXAnchor.constraint(equalTo: optionsView.centerXAnchor),
      view.centerYAnchor.constraint(equalTo: optionsView.centerYAnchor)
      ])
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let theme = Theme.shared
    readingModeSegmentedControl.selectedSegmentIndex = theme.readingMode.rawValue
    titleAlignmentSegmentedControl.selectedSegmentIndex = theme.titleAlignment.rawValue
    currentPage = theme.font.rawValue
    pageControl.currentPage = currentPage
    synchronizeViews(scrolled: false)
  }
  
  @IBAction func pageControlPageDidChange() {
    synchronizeViews(scrolled: false)
  }
  
  @IBAction func readingModeDidChange(_ segmentedControl: UISegmentedControl) {
    Theme.shared.readingMode = ReadingMode(rawValue: segmentedControl.selectedSegmentIndex) ?? .dayTime
  }
  
  @IBAction func titleAlignmentDidChange(_ segmentedControl: UISegmentedControl) {
    Theme.shared.titleAlignment = TitleAlignment(rawValue: segmentedControl.selectedSegmentIndex) ?? .left
  }
  
  private func synchronizeViews(scrolled: Bool) {
    let pageWidth = scrollView.bounds.width
    var page: Int = 0
    var offset: CGFloat = 0
    
    if scrolled {
      offset = scrollView.contentOffset.x
      page = Int(offset / pageWidth)
      pageControl.currentPage = page
    } else {
      page = pageControl.currentPage
      offset = CGFloat(page) * pageWidth
      scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
    
    if page != currentPage {
      currentPage = page
      Theme.shared.font = Font(rawValue: currentPage) ?? .firaSans
    }
  }
}

extension OptionsController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.isDragging || scrollView.isDecelerating {
      synchronizeViews(scrolled: true)
    }
  }
}
