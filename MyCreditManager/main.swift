//
//  main.swift
//  MyCreditManager
//
//  Created by 예띤 on 2023/04/27.
//

import Foundation

var students = [Student]()

while true{
    print("원하는 기능을 입력해 주세요. \n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    let input = readLine()?.trimmingCharacters(in: .whitespaces)
    
    switch input {
    case "1":
        addStudent()
    case "2":
        deleteStudent()
    case "3":
        addGrade()
    case "4":
        deleteGrade()
    case "5":
        totalGrade()
    case "x", "X":
        break
    default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
}

func addStudent(){
    print("추가할 학생의 이름을 입력해주세요.")
    let student = String(readLine()!.trimmingCharacters(in: .whitespaces))

    if student == ""{
       print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }else{
        if students.filter({$0.name == student}).isEmpty{
            print("\(student) 학생을 추가했습니다.")
            students.append(Student(name: student))
        }else{
           print("\(student)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        }
    }
}

func deleteStudent(){
    print("삭제할 학생의 이름을 입력해주세요.")
    let student = String(readLine()!.trimmingCharacters(in: .whitespaces))

    if student == ""{
       print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }else{
        if students.filter({$0.name == student}).isEmpty{
           print("\(student)학생을 찾지 못했습니다.")
       }else{
           print("\(student) 학생을 삭제하였습니다.")
           students.remove(at: students.firstIndex(of: Student(name: student))!)
       }
    }
}

func addGrade(){
    print("""
            성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.\
            \n입력예) Mickey Swift A+\
            \n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
            """)
    let inputGrade = String(readLine()!.trimmingCharacters(in: .whitespaces)).split{$0 == " "}
    
    if inputGrade.count != 3{
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }else{
        if students.filter({$0.name == inputGrade[0]}).isEmpty{
            print("\(String(inputGrade[0])) 학생을 찾지 못했습니다.")
        }else{
            print("\(String(inputGrade[0])) 학생의 \(String(inputGrade[1])) 과목이 \(String(inputGrade[2]))로 추가(변경)되었습니다.")
            let studentIndex = students.firstIndex(where: {$0.name == inputGrade[0]})!
            students[studentIndex].grade = [String(inputGrade[1]):String(inputGrade[2])]
            print(students[studentIndex].grade!)
        }
    }
}

func deleteGrade(){
    print("""
            성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\
            \n입력예) Mickey Swift
            """)
    let delete = String(readLine()!.trimmingCharacters(in: .whitespaces)).split{$0 == " "}
    if delete.count != 2{
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }else{
        if students.filter({$0.name == delete[0]}).isEmpty{
            print("\(String(delete[0])) 학생을 찾지 못했습니다.")
        }else{
            print("\(String(delete[0])) 학생의 \(String(delete[1])) 과목의 성적이 삭제되었습니다.")
            let studentIndex = students.firstIndex(where: {$0.name == delete[0]})!
            students[studentIndex].grade?[String(delete[1])] = nil
        }
    }
}

func totalGrade(){
    print("평점을 알고싶은 학생의 이름을 입력해주세요.")
    var average = 0.0
    var count = 0.0
    let student = String(readLine()!.trimmingCharacters(in: .whitespaces))
    if students.filter({$0.name == student}).isEmpty{
        print("\(student) 학생을 찾지 못했습니다.")
    }else{
        let studentIndex = students.firstIndex(where: {$0.name == student})!
        students[studentIndex].grade?.forEach({
                print("\($0.key): \($0.value)")
                average += getScore(score: $0.value)
                count += 1
            })
            print(average / count)
    }
}

func getScore(score: String) -> Double{
    switch score {
       case "A+":
           return 4.5
       case "A":
           return 4.0
       case "B+":
           return 3.5
       case "B":
           return 3.0
       case "C+":
           return 2.5
       case "C":
           return 2.0
       case "D+":
           return 1.5
       case "D":
           return 1.0
       case "F":
           return 0
       default:
        return 0
       }
}
    
