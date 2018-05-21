//
//  NWService.swift
//  WebServices
//
//  Created by Gabriel Jaramillo on 5/20/18.
//  Copyright © 2018 Gabriel Jaramillo. All rights reserved.
//

import Foundation

class NWService: NSObject {
    
    private override init(){}
    static let shared = NWService()
    
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
            
            //parse JSONResponse from Server
            do{
             
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        
                for element in jsonResponse {
                    
                    let jsonObject = element as! [String:Any]
                    
                    print(jsonObject["body"] as! String)
                    
                }
                
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
            
            guard let serverResponse = String(data: data!, encoding: String.Encoding.utf8) else {
                print("Error parsing Server Response")
                return
            }
            
            //Print ServerResponse Out.
            print(serverResponse)
            
        }
        
        task.resume()
    }
    
    //HTTP PUT REQUEST
    func makePUTCall(url: String){
        
        //Creating URL Object
        guard let endPoint = URL(string: url) else {
            print("Error creating URL based on URLString parameter")
            return
        }
        
        //Creating URLRequest, RequestMethod and RequestHeader
        var urlRequest = URLRequest(url: endPoint)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Creating our BodyParameters to be received in the server
        let requestBody = NSMutableDictionary()
        requestBody.setValue(1, forKey: "userId")
        requestBody.setValue("GGabriel_Dev", forKey: "title")
        requestBody.setValue("UPDATED This is my first POST Request using Swift!, and im excited to learn more and more of iOS Development using Swift Language! ", forKey: "body")
        
        //Assigning the BodyParameters as JSON to URLRequest Body
        do{
            
            let jsonRequestBody = try JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions())
            urlRequest.httpBody = jsonRequestBody
            
        }catch let error as NSError{
            print("Error creating RequestJSON Body to be sent to the endpoint, Error: \(error)")
        }
        
        //Creating Configuration, Session and Task for Request Call
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        //Firing the Request
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil && data == nil {
                print("Error from Request PUT Call, or No Data received")
            }
            
            //Here you can also parse your JSONObject from Server, in PUT or UPDATE Calls, you will receive 200 code
            //And Current Updated Object with a message.
            
            
            //Printing Server Response
            guard let serverResponse = String(data: data!, encoding: String.Encoding.utf8)  else {
                print("Error parsing the Server Response to a String")
                return
            }
            
            print("serverResponse: \(serverResponse)")
        }
        
        task.resume()
        
        
    }
    
    //HTTP DELETE REQUEST
    func makeDELETECall(url: String){
        
        //Creating URL Object
        guard let endPoint = URL(string: url) else {
            print("Error creating URL based on URLString parameter")
            return
        }
        
        //Creating URLRequest, RequestMethod and RequestHeader
        var urlRequest = URLRequest(url: endPoint)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
        
        //Creating Configuration, Session and Task for Request Call
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil && data == nil {
                print("Error from Request GET Call, or No Data received")
            }
            
            //Here we can convert our Server Response in case we have one, usually in DELETE Calls is just 200 Call and
            //Message with a successfull Delete
            
            //printing Server Response
            guard let serverResponse = String(data: data!, encoding: String.Encoding.utf8)  else {
                print("Error parsing the Server Response to a String")
                return
            }
            
            print("serverResponse: \(serverResponse)")
        }
        
        task.resume()
        
    }
}