//
//  File.swift
//  
//
//  Created by Nickolans Griffith on 12/19/23.
//

import Foundation
import AWSDynamoDB

typealias Item = [String: DynamoDBClientTypes.AttributeValue]

func getTableNames() async throws -> [String] {
    let client = try DynamoDBClient(region: "us-east-1")
    let output = try await client.listTables(input: ListTablesInput())
    
    guard let tables = output.tableNames else {
        return []
    }
    
    return tables
}

func createTable(tableName: String) async throws {
    let client = try DynamoDBClient(region: "us-east-1")
    
    let names = try await getTableNames()
    
    if names.contains(tableName) {
        return
    }
    
    let tableInput = CreateTableInput(
        attributeDefinitions: [
                        DynamoDBClientTypes.AttributeDefinition(attributeName: "id", attributeType: .s),
                    ],
        keySchema: [.init(attributeName: "id", keyType: .hash)],
                                      provisionedThroughput:
                                        DynamoDBClientTypes.ProvisionedThroughput(
                                                      readCapacityUnits: 10,
                                                      writeCapacityUnits: 10
                                                  ),
                                      tableName: tableName)
    let _ = try await client.createTable(input: tableInput)
}

func writeToTable() async throws {
    let client = try DynamoDBClient(region: "us-east-1")
    let tableName = "aws-swift-example"
    try await createTable(tableName: tableName)
    
    let item: Item = [
        "id": .s(UUID().uuidString),
        "name": .s("Nick")
    ]
    
    let item2: Item = [
        "id": .s(UUID().uuidString),
        "name": .s("Noah")
    ]
    
    let input = BatchWriteItemInput(requestItems: [tableName: [
        .init(putRequest: .init(item: item)),
        .init(putRequest: .init(item: item2))]])
    
    let _ = try await client.batchWriteItem(input: input)
}
