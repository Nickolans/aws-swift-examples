import Foundation
import ClientRuntime
import AWSS3
import AWSSQS

@main
struct Main {
    static func main() async {
        do {
            let names = try await getBucketNames()
            print("Bucket names: ", names)
            
            let tableNames = try await getTableNames()
            print("Table names: ", tableNames)
            
//            try await sqs();
            try await writeToTable()
        } catch {
            print("ERROR: ", error)
        }
    }
}
