//
//  File.swift
//  
//
//  Created by Nickolans Griffith on 12/19/23.
//

import Foundation
import AWSS3

func getBucketNames() async throws -> [String] {
    let client = try S3Client(region: "us-east-1")
    
    let output = try await client.listBuckets(input: ListBucketsInput())
    var bucketNames: [String] = []
    
    guard let buckets = output.buckets else {
        return bucketNames
    }
    
    for bucket in buckets {
        bucketNames.append(bucket.name ?? "<unknown>")
    }
    
    return bucketNames
}
