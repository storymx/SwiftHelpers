//
//  NWService.swift
//  APNSTest
//
//  Created by Gabriel Jaramillo on 5/20/18.
//  Copyright © 2018 Gabriel Jaramillo. All rights reserved.
//

import Foundation
class NWService: NSObject {
    
    private override init(){}
    static let shared  = NWService()
    
    func makeGETCall(url: String){
        
        //Creating the URL from received String
        guard let endPoint = URL(string: url) else {
            print("Error converting your String into a URL.")
            return
        }
        
        var urlRequest = URLRequest(url: endPoint)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //BODY most of GET calls do not include any specific content Body, if your GET Call includes one..
        //you can follow the steps of makePOSTCall
        
        //Configuring HTTPCall
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
            //Executing the Call and Parsing your JSON
            let task = session.dataTask(with: urlRequest) { (data, request, error) in
                
                //checking if your call has an error
                if error != nil && data == nil {
                    print("Error Executing your HTTP GET Call...")
                }
                
                do {
                //Parsing your JSON Data from Server
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                    
                    //Print our your JSON Call from Server
                    print("JSON From Server: \(jsonResponse)")
                    
                    //Here you can Manage your actions based on your JSON Object, maybecreating models or any other actions...
                    
                }catch let error as NSError{
                    //Print your Error to Console.
                    print(error.localizedDescription)
                }
            }
            
            task.resume()
    }
    
    func makePOSTCall(url: String){
        
        //creating the URL for tne End point.
        guard let endpoint = URL(string: url) else {
            print("Error creating our endpoint:  \(url) on POSTRequest")
            return
        }
        
        //creating our URLRequest, Setting Up the Method Call, and Setting Headers, Authorization Token can also be added here as Header.
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //CREATING BODY PARAMS
        let contentBody = NSMutableDictionary()
        contentBody.setValue(1, forKey: "userId")
        
        let jsonContentBody: Data
        
        //Serializing BODY PARAMS
        do{
            
            jsonContentBody = try JSONSerialization.data(withJSONObject: contentBody, options: JSONSerialization.WritingOptions())
            urlRequest.httpBody = jsonContentBody
            
        }catch{
            print("Error Adding and Parsing bodyContent to JSON")
            return
        }
        
        //configuring the HTTPCall.
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        //Executing the Call to Endpoint
        let task  = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil && data == nil {
                print("error during the request Call, and no data received: ")
                print("error: \(error)")
            }
            
            guard let contentData = String(data: data!, encoding: String.Encoding.utf8) else {
                return
            }
            
            // Here you can do whatever you want with your Received Data.
        }
     
        task.resume();
        
    }
    
    func makePUTCall(url: String){
        
        //creating the URL for tne End point.
        guard let endpoint = URL(string: url) else {
            print("Error creating our endpoint:  \(url) on POSTRequest")
            return
        }
        
        //creating our URLRequest, Setting Up the Method Call, and Setting Headers, Authorization Token can also be added here as Header.
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //CREATING BODY PARAMS
        let contentBody = NSMutableDictionary()
        contentBody.setValue(1, forKey: "userId")
        contentBody.setValue("Updated Title Field", forKey: "title")
        contentBody.setValue("Updated Body Field", forKey: "body")
        
        let jsonContentBody: Data
        
        //Serializing BODY PARAMS
        do{
            
            jsonContentBody = try JSONSerialization.data(withJSONObject: contentBody, options: JSONSerialization.WritingOptions())
            urlRequest.httpBody = jsonContentBody
            
        }catch{
            
            print("Error Adding and Parsing bodyContent to JSON")
            return
            
        }
        
        //configuring the HTTPCall.
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        //Executing the Call to Endpoint
        let task  = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil && data == nil {
                print("error during the request Call, and no data received: ")
                print("error: \(error)")
            }
            
            guard let contentData = String(data: data!, encoding: String.Encoding.utf8) else {
                return
            }
            
            // Here you can do whatever you want with your Received Data.
        }
        
        task.resume();
        
    }
    
    func makeDELETECall(url: String){
        
        
        //creating the URL for tne End point.
        guard let endpoint = URL(string: url) else {
            print("Error creating our endpoint:  \(url) on POSTRequest")
            return
        }
        
        //creating our URLRequest, Setting Up the Method Call, and Setting Headers, Authorization Token can also be added here as Header.
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //configuring the HTTPCall.
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        //Executing the Call to Endpoint
        let task  = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil && data == nil {
                print("error during the request Call, and no data received: ")
                print("error: \(error)")
            }
            
            guard let contentData = String(data: data!, encoding: String.Encoding.utf8) else {
                return
            }
            
            // Here you can do whatever you want with your Received Data.
        }
        
        task.resume();
        
    }   
}