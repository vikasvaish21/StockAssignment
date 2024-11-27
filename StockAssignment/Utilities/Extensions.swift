//
//  Extensions.swift
//  StockAssignment
//
//  Created by Vikas Vaish on 25/11/24.
//

import Foundation
import UIKit

extension UIColor {
    static let primaryColor = UIColor(red: 17/255, green: 49/255, blue: 98/255, alpha: 1)
    static let lightGrayColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
}


extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?  = nil,left: NSLayoutXAxisAnchor? = nil,bottom: NSLayoutYAxisAnchor? = nil,right: NSLayoutXAxisAnchor? = nil,paddingTop: CGFloat = 0,paddingLeft:CGFloat = 0,paddingBottom:CGFloat = 0,paddingRight:CGFloat = 0,width: CGFloat? = nil,height : CGFloat? = nil){
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top,constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left,constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom,constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right,constant: -paddingRight).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant : width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant : height).isActive = true
        }
    }
    
    
    func centerX(inView view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    func centerY(inView view: UIView,constant:CGFloat = 0) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    func addSubViews(view: UIView...){
        view.forEach { view in
            addSubview(view)
        }
    }

    func pinToEdges(superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: superView.safeAreaLayoutGuide.topAnchor, left: superView.leftAnchor, bottom: superView.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }

    func pinToCentre(superView:  UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerX(inView: superView)
        centerY(inView: superView)
        anchor(width: 50, height: 50)
    }

}


extension URLSession {
    
    enum CustomError:Error{
        case invalidURL
        case invalidData
    }
    
    public func request<T:Codable>(url: URL?,expecting:T.Type,completion:@escaping (Result<T,Error>) -> Void) {
        guard let url = url else{
            completion(.failure(CustomError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, responseData, error in
            guard let data =  data else {
                if let error = error{
                    completion(.failure(error))
                }else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting.self,from: data)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
