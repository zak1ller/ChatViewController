//
//  ChatViewModel.swift
//  ChatViewController
//
//  Created by Min-Su Kim on 1/24/24.
//

import Foundation
import RxSwift

final class ChatViewModel {
  
  var chatsByDate: [String: [ChatModel]] = [:]
  var chats: [ChatModel] = mockupChats.reversed()
  
  var sentNewMessage = BehaviorSubject(value: false)
  
  init() {
    distinguishDates()
  }
  
  func sendMessage(message: String, uid: Int) {
    sentNewMessage.onNext(false)
    chats.insert(ChatModel(uid: 1, message: message, createdAt: TimeManager.makeCurrentTimeString()), at: 0)
    sentNewMessage.onNext(true)
  }
  
  private func distinguishDates() {
    chatsByDate.removeAll()
    
    var dates: [String] = []
    for chat in chats {
      dates.append(TimeManager.extractDate(from: chat.createdAt))
    }
    
    for date in dates {
      var refinedChats: [ChatModel] = []
      for chat in chats {
        if TimeManager.extractDate(from: chat.createdAt) == date {
          refinedChats.append(chat)
        }
      }
      chatsByDate[date] = refinedChats
    }
    
    print(chatsByDate)
  }
}

var mockupChats: [ChatModel] = [
  ChatModel(uid: 1, message: "Just because the water is red doesn't mean you can't drink it.", createdAt: "2023-12-05 20:58:43"),
  ChatModel(uid: 2, message: "Today I dressed my unicorn in preparation for the race.", createdAt: "2023-12-05 20:58:44"),
  ChatModel(uid: 2, message: "Patricia found the meaning of life in a bowl of Cheerios.", createdAt: "2023-12-05 20:58:45"),
  ChatModel(uid: 2, message: "I just wanted to tell you I could see the love you have for your child by the way you look at her.", createdAt: "2023-12-05 20:58:46"),
  ChatModel(uid: 1, message: "There were three sphered rocks congregating in a cubed room.", createdAt: "2023-12-05 20:58:47"),
  ChatModel(uid: 1, message: "With a single flip of the coin, his life changed forever.", createdAt: "2023-12-05 20:58:48"),
  ChatModel(uid: 2, message: "Always bring cinnamon buns on a deep-sea diving expedition.", createdAt: "2023-12-05 20:58:49"),
  ChatModel(uid: 1, message: "Nothing is as cautiously cuddly as a pet porcupine.", createdAt: "2023-12-05 20:58:50"),
]
                        
