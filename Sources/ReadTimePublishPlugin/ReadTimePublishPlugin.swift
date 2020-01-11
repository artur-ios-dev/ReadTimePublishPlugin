/**
 * Read time plugin for Publish
 * Copyright (C) Artur Rymarz 2020
 * MIT license, see LICENSE file for details
 */

import Publish

public enum ReadTimeType {
    case seconds
    case minutes
}

public extension Item {
    typealias ReadTimeData = (time: Int, words: Int)

    func readTime(type: ReadTimeType = .minutes, averageWordsPerMinute: Int = 200) -> ReadTimeData {
        (content.body.html.readTime(type: type, averageWordsPerMinute: averageWordsPerMinute), content.body.html.wordsCount)
    }
}

private extension String {
    // TODO: Use Ink somehow to get the actual text so it does not contain any HTML and any code is stripped away as well?
    var strippedHTML: String {
        replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression, range: nil)
    }

    var wordsCount: Int {
        var count = 0
        let range = strippedHTML.startIndex..<strippedHTML.endIndex

        strippedHTML.enumerateSubstrings(in: range, options: [.byWords, .substringNotRequired, .localized], { _, _, _, _ -> () in
            count += 1
        })

        return count
    }

    func readTime(type: ReadTimeType = .minutes, averageWordsPerMinute: Int) -> Int {
        let timeInMinutes = Double(wordsCount) / Double(averageWordsPerMinute)

        switch type {
        case .seconds: return Int((timeInMinutes * 60).rounded(.toNearestOrAwayFromZero))
        case .minutes: return Int(timeInMinutes.rounded(.toNearestOrAwayFromZero))
        }
    }
}
