//
//  Course.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 22/09/22.
//

import Foundation

class Course {
    var courseId: Int
    var courseName: String
    var categoryId: Int
    var instructorId: String
    var description: String
    var price: Int
    var courseOutlook = """
    Understand and enjoy classical music at your own pace. A music history course, including a music theory introduction.
    """
    var whatYouLearn = """
You will learn the component parts of music—rhythm, pitch, melody, harmony, form, etc.\n
Then you will apply those concepts to an exploration of the history of classical music.\n
In the end, you will have developed a greater understanding of music in its various stages of development.\n
You will be able to more accurately identify the works and the composer’s style, as well as place it in the timeline of the history of music.
"""
    var prerequisite = """
I don’t require a textbook, but if you wish to complement your studies, the textbook that most closely parallels this course is The Art of Listening by Jean Ferris.
"""
    var courseCover: String = "https://cdn.pixabay.com/photo/2020/12/11/11/33/training-5822607_1280.png"
    var courseVideo: String = "https://youtu.be/OjdT2l-EZJA?list=PLfn3cNtmZdPOe3R_wO_h540QNfMkCQ0ho"
    init( courseId: Int, coutseName: String, categoryId: Int, instructorId: String, description: String, price: Int) {
        self.courseId = courseId
        self.courseName = coutseName
        self.categoryId = categoryId
        self.description = description
        self.price = price
        self.instructorId = instructorId
    }
}
