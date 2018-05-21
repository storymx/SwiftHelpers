//
//  NWDService.swift
//  WebServices
//
//  Created by Gabriel Jaramillo on 5/20/18.
//  Copyright © 2018 Gabriel Jaramillo. All rights reserved.
//

import Foundation

class NWDService: NSObject {
    
    private override init(){}
    static let shared = NWDService()
    
    func makeGETCall(url: String){
        
        //retrieving url String, creating URL based on url param
        guard let endPoint = URL(string: url) else {
            print("Error parsing string to URL")
            return
        }
        
        //Creating our Request based on URL variable, setting up headers and Call Method
        var urlRequest = URLRequest(url: endPoint)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Setting our SessionConfiguration and our Session
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        //Setting up our sessionDataTask
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil && data == nil {
                print("REQUEST CALL ERROR, Check your logs...")
                return
            }

            //Make sure your data contains data and avoid the crash of EmptyData
            guard let data = data else { return }
            
            //Decode JSON using your Struct and JSONDecoder
            do{
                
                let posts = try JSONDecoder().decode([Post].self, from: data)
                print(posts)

            }catch let error as NSError{
                print(error.localizedDescription)
            }
            
        }
        
        //RESUME THE TASK
        task.resume()
        
        
    }
    
    //HTTP POST REQUEST
    func makePOSTCall(url: String){
        
        //Creating URL Object
        guard let endPoint = URL(string: url) else {
            print("Error Creating URL Object")
            return
        }
        
        //Creating URLRequest, RequestMethod and RequestHeader
        var urlRequest = URLRequest(url: endPoint)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Creating our BodyParameters to be received in the server
        let requestBody = NSMutableDictionary()
        requestBody.setValue("ggabriel_dev post", forKey: "title")
        requestBody.setValue("This is my first POST Request using Swift!, and im excited to learn more and more of iOS Development using Swift Language!", forKey: "body")
        requestBody.setValue(1, forKey: "userId")
        
        //Assigning the BodyParameters as JSON to URLRequest Body
        do{
            
            let jsonRequestBody = try JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions())
            urlRequest.httpBody = jsonRequestBody
            
        }catch let error as NSError{
            print("Error Parsing requestBody to JSONObject: \(error)")
        }
        
        //Creating Configuration, Session and Task for Request Call
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        //Firing the Request
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil && data == nil {
                print("Error during the request call, and no data received!")
                print("error: \(String(describing: error))")
            }
            
            //Here you can also parse your JSONObject from Server, in POST Calls, you will receive 200 code
            //And Current Updated Object with a message.
            
            //Make sure your data contains data and avoid the crash of EmptyData
            guard let data = data else {return}
            
            //Decode JSON using your Struct and JSONDecoder
            do{
                let postFromPOSTCall = try JSONDecoder().decode(Post.self, from: data)
                    
                //Print ServerResponse Out.
                print(postFromPOSTCall)
            }catch let error as NSError{
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
    }
}
