//
//  Service.swift
//  Pods
//
//  Created by Abhishek.Batra on 6/26/23.
//

import Foundation



class ServiceManager {
    
    
    // MARK: - Properties

        static let shared = ServiceManager()
        private init() {
        }
        
    let brandAdURL = "https://uat-ads.commerce.inmobi.com/v1/ads"
    let productAdURL = "https://uat-ads.commerce.inmobi.com/v1/ads/bulk"
    let productDetailsURL = "https://uat-ads.commerce.inmobi.com/api/v1/retailer/####/catalog/productDetails?skuIds=****"
    
    
    //     let uat_xAPIKey = "ZDQ3YTcyMTctZmI0ZC00NjJhLWJiODMtNGFjMGExZDIxYzBj";
    //     let uat_clientId = "70891516";
    //     let uat_productAdurl = "https://uat-ads.commerce.inmobi.com/v1/ads/bulk"
    //     let uat_productDetailsURL = "https://uat-ads.commerce.inmobi.com/api/v1/retailer"
    //     let uat_AdData = [ "user": [ "guest_id": "7aac8fb0c3c711ed8f3dd1a03e907612", "iccs_id": "c1f4e04e-b5aa-486d-8405-3d96d85a8597", "user_id": "", "platform": [ "device_type": "DESKTOP" ], "address": [ "zip_code": "10001" ] ], "filter": [ "placements": [[ "ad_count": 1, "id": 216 ]], "targeting_type": "PAGE", "targeting_value_list": ["HOME"] ], "consent": [ "gdpr": true, "ccpa": true, "coppa": true ] ];
    //     let uat_SKU = "6107B330168080";
    
    let prod_xAPIKey = "ODFiNmUxODItMmMyNS00NTg4LWEyZTAtZDI3ZDAyNTY3MmQ2";
    let prod_clientId = "70891516";
    let prod_productAdurl = "https://ad-service.commerce.inmobi.com/v1/ads/bulk";
    let prod_productDetailsURL = "https://ad-service.commerce.inmobi.com/api/v1/retailer/";
    let prod_AdData = [
        "user": [
            "guest_id": "87281370e1ef11ed9119bb8e702b7726",
            "user_id" : "",
            "platform" : [ "device_type": "DESKTOP" ],
            "address": [ "zip_code": "10001" ],
        ],
        "filter": [
            "placements": [
                [ "ad_count": 2, "id": 104 ],
                [ "ad_count": 2, "id": 116 ],
            ],
            "targeting_type": "KEYWORD",
            "targeting_value_list": ["shapewear"],
        ],
        "consent": [ "gdpr": true, "ccpa": true, "coppa": true ] as [String : Any],
    ];
    let prod_SKU = "1624F0185179209";
    
    
    
    
    
    func getBrandAd(completion: @escaping (BrandAdResponse)-> ()) {
        guard let url = URL(string: brandAdURL) else {
            print("Error: cannot create URL")
            return
        }
        
        
        // Add data to the model
        let userDataModel = User(guestID: "87281370e1ef11ed9119bb8e702b7726", userID: "", platform: Platform(deviceType: "DESKTOP"))
        let bannerAdDataModel = BrandAdRequest(user: userDataModel, filter: Filter(adCount: 3, placementID: 296, targetingType: "KEYWORD", targetingValueList: ["Mobiledemo"]), consent: Consent(gdpr: true, ccpa: true, coppa: true))
        
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(bannerAdDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.setValue("MTEyM2RhNWUtNTc3Ni00NjcwLWFiMDgtNzdmMzUyMjhiZGU1", forHTTPHeaderField: "x-api-key")
        request.setValue("uat-ads.commerce.inmobi.com", forHTTPHeaderField: "authority")
        request.setValue("4987041", forHTTPHeaderField: "client-id")
        
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Couldn't print JSON in String")
                    return
                }
                                
                let decoder = JSONDecoder()
                            
                guard let json: BrandAdResponse = try? decoder.decode(BrandAdResponse.self, from: data) else {return print("error with json")}

//                print(json);
                completion(json)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
    
    
    func getProductAd(completion: @escaping (ProductAdResponse)-> ()) {
        guard let url = URL(string: productAdURL) else {
            print("Error: cannot create URL")
            return
        }
        
        
                
        let productAdDataModel = ProductAdRequest(user: ProductUser(guestID: "87281370e1ef11ed9119bb8e702b7726", iccsID: "c1f4e04e-b5aa-486d-8405-3d96d85a8597", userID: "", platform: ProductPlatform(deviceType: "DESKTOP"), address: ProductAddress(zipCode: "10001")), filter: ProductFilter(placements: [ProductPlacement(adCount: 1, id: 216)], targetingType: "PAGE", targetingValueList: ["HOME"]), consent: ProductConsent(gdpr: true, ccpa: true, coppa: true))
        
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(productAdDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.setValue("ZDQ3YTcyMTctZmI0ZC00NjJhLWJiODMtNGFjMGExZDIxYzBj", forHTTPHeaderField: "x-api-key")
        request.setValue("uat-ads.commerce.inmobi.com", forHTTPHeaderField: "authority")
        request.setValue("70891516", forHTTPHeaderField: "client-id")
        
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Couldn't print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
                
                let decoder = JSONDecoder()
                            
                guard let json: ProductAdResponse = try? decoder.decode(ProductAdResponse.self, from: data) else {return print("error with json")}

//                print(json);
                completion(json)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
    
    
    
    
    func getProductDetails(clientId: String, productSku:String, completion: @escaping (ProductDetailResponse)-> ()) {
        var productAPIrequest = productDetailsURL.replacingOccurrences(of: "####", with: clientId)
        productAPIrequest = productAPIrequest.replacingOccurrences(of: "****", with: productSku)
        guard let url = URL(string: productAPIrequest) else {
            print("Error: cannot create URL")
            return
        }
        
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.setValue("ZDQ3YTcyMTctZmI0ZC00NjJhLWJiODMtNGFjMGExZDIxYzBj", forHTTPHeaderField: "x-api-key")
        request.setValue("uat-ads.commerce.inmobi.com", forHTTPHeaderField: "authority")
        request.setValue("70891516", forHTTPHeaderField: "client-id")
        
        request.httpBody = nil
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Couldn't print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
                
                let decoder = JSONDecoder()
                            
                guard let json: ProductDetailResponse = try? decoder.decode(ProductDetailResponse.self, from: data) else {return print("error with json")}

//                print(json);
                completion(json)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
    
}



