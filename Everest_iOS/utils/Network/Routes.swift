//
//  Routes.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-11-24.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation

struct Routes {
  struct Api {
    static let CreateNewUser: String = "/createNewUser"
    static let SetUpUserProfile: String = "/setUserProfileFields?id="
    static let CreateNewEvent: String = "/createEvent"
    static let SignInUser: String = "/signInUser"
  }
  struct Socket {
    struct NewsFeed {
      static let Subscribe: String = "newsfeed subscribe"
      static let AddPost: String = "add newsfeed post"
      static let NewPost: String = "new newsfeed posts"
    }
  }
}