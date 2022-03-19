//
//  ViewController.swift
//  AysncLetDemo
//
//  Created by Xing Zhao on 2022-03-16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        // Do any additional setup after loading the view.
        loadImages()
        //loadImagesAsyncLet()
    }

    // MARK: Async Let
    
    func loadImage(index: Int) async -> UIImage {
        let imageURL = URL(string: "https://picsum.photos/200/300")!
        let request = URLRequest(url: imageURL)
        let (data, _) = try! await URLSession.shared.data(for: request)
        print("finished loading image \(index)")
        return UIImage(data: data)!
    }

    // we tell the application to wait for the first image to be returned until it can continue to fetch the second image
    func loadImages() {
        Task {
            let firstImage = await loadImage(index: 1)
            let secondImage = await loadImage(index: 2)
            let thirdImage = await loadImage(index: 3)
            let images = [firstImage, secondImage, thirdImage]
            print("images are here \(images)")
        }
    }
    
    // download images in parallel
    func loadImagesAsyncLet() {
        Task {
            async let firstImage = loadImage(index: 4)
            async let secondImage =  loadImage(index: 5)
            async let thirdImage = loadImage(index: 6)
            let images = await [firstImage, secondImage, thirdImage]
            print("images are here \(images)")
        }
    }
}

