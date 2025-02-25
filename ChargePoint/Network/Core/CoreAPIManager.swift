//
//  CoreAPIManager.swift
//  ChargePoint
//
//  Created by Javidan on 13.02.25.
//

import Foundation

final class CoreAPIManager {
    static let instance = CoreAPIManager()
    private init() {}
    
    func request<T: Decodable>(
        type: T.Type,
        url: URL?,
        method: HttpMethods,
        header: [String: String],
        body: [String : Any] = [:],
        completion: @escaping((Result<T,CoreErrorModel>) -> Void)
    ) {
        guard let url = url else {return}
        print("URL:", url)
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = header
        request.httpMethod = method.rawValue
        //print("header:", String(data: try! JSONSerialization.data(withJSONObject: header, options: .prettyPrinted), encoding: .utf8)!)
        if !body.isEmpty {
            let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = bodyData
           // print("body: \(String(data: try! JSONSerialization.data(withJSONObject: body, options: .prettyPrinted), encoding: .utf8)!)")
            //print("header:", String(data: try! JSONSerialization.data(withJSONObject: header, options: .prettyPrinted), encoding: .utf8)!)
        }
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else {return}
            guard let response = response as? HTTPURLResponse else {return}
            //print("Status Code: \(response.statusCode)")
            
            if response.statusCode == 401 {
                completion(.failure(CoreErrorModel.authError(code: response.statusCode)))
            }
            guard let error = error else {
                guard let data = data else {
                   // print(" JSON Data yoxdur!")
                    return
                }
                if let jsonString = String(data: data, encoding: .utf8) {
                }
                handleResponse(data: data, completion: completion)
                return
            }
            completion(.failure(CoreErrorModel(code: response.statusCode, message: error.localizedDescription)))
        }
        task.resume()
    }
        
    func request<T: Decodable>(
        type: T.Type,
        url: URL?,
        method: HttpMethods,
        header: [String: String],
        body: Data?,
        completion: @escaping((Result<T, CoreErrorModel>) -> Void)
    ) {
        guard let url = url else { return }
        //print("URL:", url)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = header
        request.httpMethod = method.rawValue
        
        if let body = body {
            request.httpBody = body
            //print("Sent body:", String(data: body, encoding: .utf8) ?? "Body çevrilmədi")
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let response = response as? HTTPURLResponse else { return }
            //print(" Status Code: \(response.statusCode)")
            if response.statusCode == 401 {
                completion(.failure(CoreErrorModel.authError(code: response.statusCode)))
                return
            }
            
            if let error = error {
                completion(.failure(CoreErrorModel(code: response.statusCode, message: error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                //print("❌ JSON Data yoxdur!")
                return
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                //print("📩 Serverdən gələn cavab:")
                //print(jsonString)
            }
            handleResponse(data: data, completion: completion)
        }
        task.resume()
    }
    
    fileprivate func handleResponse<T: Decodable>(
        data: Data,
        completion: @escaping((Result<T, CoreErrorModel>) -> Void)
    ) {
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            print("✅ JSON Parsed")
            completion(.success(response))
        } catch {
            print("❌ JSON decode error: \(error)")
            completion(.failure(CoreErrorModel.decodingError()))
        }
    }

}

    
    
    

