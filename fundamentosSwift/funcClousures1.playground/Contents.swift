import UIKit

func calculateStatistics(score: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = score[0]
    var max = score[0]
    var sum = 0
    
    for score in score {
        if score < min {
            min = score
        }
        else if score > max {
            max = score
        }
        sum += score
    }
    return (min, max, sum)
}

let statistics = calculateStatistics(score: [5, 3, 9, 1, 5, 4])
print(statistics.sum)
print(statistics.1)
