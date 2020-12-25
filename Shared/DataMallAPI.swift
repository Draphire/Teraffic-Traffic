//
//  DataMallAPI.swift
//  Teraffic
//
//  Created by WeeLiang Ng on 19/10/20.
//

import Foundation

enum DataMallAPIError: Error {
    case invalidURL
    case invalidSerialization
    case badHTTPResponse
    case error(NSError)
    case noData
}

protocol DataMallRepositoryService {
    func getAllTrafficCameras(completion: @escaping (Result<AllTrafficCameras, DataMallAPIError>) -> ())
    func getTrafficCameras(cameraId: String, completion: @escaping (Result<Cameras, DataMallAPIError>)->())
}

class DataMallAPIService : DataMallRepositoryService{
    static let shared = DataMallAPIService()
    var currentTime: String = getDate()
//    2020-12-03T17:23:08.358Z  2020-12-04T06:21:16.231Z 2020-12-04T06:16:11.503Z
//    2020-12-04T06:23:49.928Z
//    2020-12-04T06:25:43.660Z
    //2020-12-339%5B%5D
    private let baseAPIURL = "https://api.data.gov.sg/v1/transport/traffic-images?date_time="
    private let urlSession = URLSession.shared
    
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    private init(){}
    
    func getAllTrafficCameras(completion: @escaping (Result<AllTrafficCameras, DataMallAPIError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)\(currentTime)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        executeDataTaskAndDecode(with: url, completion: completion)
    }
    
    func getTrafficCameras(cameraId: String, completion: @escaping (Result<Cameras, DataMallAPIError>) -> ()) {
//        guard let url = URL(string: "\(baseAPIURL)\(currentTime)") else {
//            completion(.failure(.invalidURL))
//            return
//        }
//
//        executeDataTaskAndDecode(with: url, completion: completion)
        
        getAllTrafficCameras { (result) in
            switch result {
            case .success(let response):
//                (response.items[0].cameras).first{cameraId == $0.id } != nil
                if let foo = (response.items[0].cameras).first(where: {$0.id == cameraId}) {
                   // do something with foo
                    completion(.success(foo))
                }
//                else {
//                   // item could not be found
//                }
//                completion(.success(response.global))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }

    private func executeDataTaskAndDecode<D: Decodable>(with url: URL, completion: @escaping (Result<D, DataMallAPIError>) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("SkfDAyH1OAYncI9PmA4drLGFlwF6HgzA", forHTTPHeaderField: "api-key")
        
        urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                self.executeInMainThread(result: .failure(.error(error as NSError)), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                self.executeInMainThread(result: .failure(.badHTTPResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeInMainThread(result: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let model = try self.jsonDecoder.decode(D.self, from: data)
                self.executeInMainThread(result: .success(model), completion: completion)
            } catch let error as NSError{
                print(error.localizedDescription)
                self.executeInMainThread(result: .failure(.invalidSerialization), completion: completion)
            }
        }.resume()
    }
    
    private func executeInMainThread<D: Decodable>(result: Result<D, DataMallAPIError>, completion: @escaping (Result<D, DataMallAPIError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
 

}



func getDate()->String{
    let time = Date()
//    let iso8601DateFormatter = ISO8601DateFormatter()
//    iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
//    let string = iso8601DateFormatter.string(from: date)
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "yyyy-MM-dd'T'HH'%3A'mm'%3A'ss"
    let stringDate = timeFormatter.string(from: time)
    return stringDate
   }


