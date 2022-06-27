//
//  User.swift
//  LocalStorage
//
//  Created by Kiroshan Thayaparan on 6/27/22.
//

class User {

    var title: String
    var first_name: String
    var last_name: String
    var email: String
    var gender: String
    var dob: String
    var city: String
    var phone: String
    var thumbnail: String
    var large_image: String
    var latitude: String
    var longitude: String
      
    init(title: String, first_name: String, last_name: String, email: String, gender: String, dob: String, city: String, phone: String, thumbnail: String, large_image: String, latitude: String, longitude: String) {

        self.title = title
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.gender = gender
        self.dob = dob
        self.city = city
        self.phone = phone
        self.thumbnail = thumbnail
        self.large_image = large_image
        self.latitude = latitude
        self.longitude = longitude
    }
}
