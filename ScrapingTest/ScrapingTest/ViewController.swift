//
//  ViewController.swift
//  ScrapingTest
//
//  Created by 김승찬 on 2022/07/26.
//

import UIKit

import Alamofire
import SwiftSoup
import Kanna


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlStr = "https://www.hansung.ac.kr/hansung/8385/subview.do"
        
        var notice: [NoticeModel] = []
        var titleString: [String] = []
        var writerString: [String] = []
        print(urlStr)

        print("1")
        AF.request(urlStr).responseString { (response) in
                    guard let html = response.value else {
                        return
                    }
            print("2")
                    do {
                        let doc: Document = try SwiftSoup.parse(html)
                        // #newsContents > div > div.postRankSubjectList.f_clear
                        let title: Elements = try doc.select(".td-subject")
                        for element in title {
                            var elementString = try element.select("strong").text()
                            titleString.append(elementString)
                        }

                        let writer: Elements = try doc.select(".td-write")
                
                        for element in writer {
                            var elementString = try element.select("td").text()
                            writerString.append(elementString)
                        }

                        let date: Elements = try doc.select(".td-date")
                        for element in date {
                            print(try element.select("td").text())
                        }
//
                        let new: Elements = try doc.select(".new")
                        for element in new {
                            print(element.empty())
                        }
                        
                        let data = NoticeModel(title: titleString, writer: writerString)
          
                        
                        notice.append(data)
                        
                        print(notice)

                    } catch {
                        print("crawl error")
                    }
                }
    }
    


}

struct NoticeModel {
//    var isHeader: Bool
//    var isNew: Bool
    var title: [String]
//    var date: String
    var writer: [String]
//    var url: String
}
