//
//  Sequence.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 2/1/23.
//

extension Sequence {
    func asyncForEach (
        _ operation: @escaping (Element) async -> Void
    ) async {
        // A task group automatically waits for all of its
        // sub-tasks to complete, while also performing those
        // tasks in parallel:
        await withTaskGroup(of: Void.self) { group in
            for element in self {
                group.addTask {
                    await operation(element)
                }
            }
        }
    }
}
