//
//  UserModel.swift
//  LocalStorage
//
//  Created by Kiroshan Thayaparan on 6/27/22.
//

import SwiftyJSON
import CoreData

class UserModel {
    
    private let api = ApiClient()
    var user: User!
    
    func getUserData(getUserDataCallFinished: @escaping (_ status: Bool) -> Void) {
        //get data from http request
        api.sendRequest(request_url: "https://randomuser.me/api/", success: { (response, code) -> Void in

            if code == 200 {
                let currentData = JSON(response as Any)
                let res = currentData["results"].arrayObject
                let jsonArray = JSON(res as Any).array

                if let jsonList = jsonArray {
                    for jsonObject in jsonList {
                        let userData = User(title: jsonObject["name"]["title"].string ?? "",
                                        first_name: jsonObject["name"]["first"].string ?? "",
                                        last_name: jsonObject["name"]["last"].string ?? "",
                                        email: jsonObject["email"].string ?? "",
                                        gender: jsonObject["gender"].string ?? "",
                                        dob: jsonObject["dob"]["date"].string ?? "",
                                        city: jsonObject["location"]["city"].string ?? "",
                                        phone: jsonObject["phone"].string ?? "",
                                        thumbnail: jsonObject["picture"]["thumbnail"].string ?? "",
                                        large_image: jsonObject["picture"]["large"].string ?? "",
                                        latitude: jsonObject["location"]["coordinates"]["latitude"].string ?? "74.7046",
                                        longitude: jsonObject["location"]["coordinates"]["longitude"].string ?? "-89.9307")
                        self.user = userData
                        self.saveData(user: userData)
                    }
                }
                getUserDataCallFinished(true)
            } else {
                print("Api status not equal 200")
                getUserDataCallFinished(false)
            }
        }) { (error) -> Void in
            NSLog("Error (getUserDataCallFinished): \(error.localizedDescription)")
            getUserDataCallFinished(false)
        }
    }
    
    func saveData(user: User) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserData", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(user.title, forKey: "title")
        newUser.setValue(user.first_name, forKey: "first_name")
        newUser.setValue(user.last_name, forKey: "last_name")
        newUser.setValue(user.email, forKey: "email")
        newUser.setValue(user.gender, forKey: "gender")
        newUser.setValue(user.dob, forKey: "dob")
        newUser.setValue(user.city, forKey: "city")
        newUser.setValue(user.phone, forKey: "phone")
        newUser.setValue(user.thumbnail, forKey: "thumbnail")
        newUser.setValue(user.large_image, forKey: "large_image")
        newUser.setValue(user.latitude, forKey: "latitude")
        newUser.setValue(user.longitude, forKey: "longitude")
        do {
            print(newUser)
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}
