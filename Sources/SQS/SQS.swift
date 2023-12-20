//
//  File.swift
//  
//
//  Created by Nickolans Griffith on 12/19/23.
//

import Foundation
import AWSSQS

func sqs() async throws {
    let client = try SQSClient(region: "us-east-1")
    let input = CreateQueueInput(queueName: "aws-swift-example-queue")
    let output = try await client.createQueue(input: input)
    
    guard let url = output.queueUrl else { return }
    
    print("URL: \(url)")
    
    // Send message
    let sendMessageInput = SendMessageInput(messageBody: "THIS IS A TEST MESSAGE", queueUrl: url)
    let sendMessageInput2 = SendMessageInput(messageBody: "THIS IS A TEST MESSAGE 2", queueUrl: url)
    let sendMessage = try await client.sendMessage(input: sendMessageInput)
    let _ = try await client.sendMessage(input: sendMessageInput2)
    
    let receiveMessageInput = ReceiveMessageInput(queueUrl:url)
    var receiveMessage = try await client.receiveMessage(input: receiveMessageInput)
    
    var messages: [SQSClientTypes.Message]? = []
    
    while (messages != nil) {
        messages = receiveMessage.messages
        
        if let msgs = receiveMessage.messages {
            
            if (msgs.isEmpty) {
                messages = nil
            }
            
            for message in msgs {
                print("RECEIVED MESSAGE: ", message.body ?? "", message.receiptHandle ?? "")
                let _  = try await client.deleteMessage(input: DeleteMessageInput(queueUrl: url, receiptHandle: message.receiptHandle))
            }
        }
        
        receiveMessage = try await client.receiveMessage(input: receiveMessageInput)
    }
}
