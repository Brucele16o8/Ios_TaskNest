////
////  DummyDataBootstrapper.swift
////  TaskNest
////
////  Created by Tung Le on 18/7/2025.
////
//
//import SwiftData
//import Foundation
//
//struct DummyDataBootstrapper {
//    static func loadIfNeeded(modelContext: ModelContext) async {
//        do {
//            let existing: [Category] = try modelContext.fetch(FetchDescriptor<Category>())
//            guard existing.isEmpty else { return }
//
//            let categories = createDummyCategories()
//
//            for category in categories {
//                modelContext.insert(category)
//            }
//
//            try modelContext.save()
//            print("✅ Dummy data inserted into SwiftData.")
//        } catch {
//            print("❌ Error inserting dummy data: \(error)")
//        }
//    }
//
//    private static func createDummyCategories() -> [Category] {
//        let userId = "dev-user-id"
//
//      let titles = ["Work", "Personal", "Fitness", "Study"]
//      
//
//        return zip(titles, colors).enumerated().map { index, pair in
//            let (title, color) = pair
//            let category = Category(title: title, userId: userId)
//
//            let tasks = (1...3).map { taskIndex in
//                let task = TaskItem(
//                    title: "\(title) Task \(taskIndex)",
//                    notes: "Notes for \(title) Task \(taskIndex)",
//                    isCompleted: taskIndex % 3 == 0,
//                    categoryId: category.id
//                )
//
//                let subtasks = (1...2).map { subIndex in
//                    let sub = SubTask(
//                        title: "Subtask \(subIndex) for Task \(taskIndex)",
//                        isCompleted: subIndex % 2 == 0,
//                        taskId: task.id
//                    )
//
//                    let photos = (1...2).map { photoIndex in
//                        PhotoAttachment(
//                            imageUrl: "https://example.com/photo\(index)-\(taskIndex)-\(subIndex)-\(photoIndex).jpg",
//                            thumbnailData: nil, // you can optionally preload thumbnail data
//                            subTaskId: sub.id
//                        )
//                    }
//
//                    sub.photoAttachments = photos
//                    return sub
//                }
//
//                task.subTasks = subtasks
//                return task
//            }
//
//            category.tasks = tasks
//            return category
//        }
//    }
//}
