//
//  ViewController.swift
//  M21_Homework
//
//  Created by Максим Зыкин on 09.06.2024
//

import UIKit

class ViewController: UIViewController {
    
    var fishes = [Fish]()
    var valueFish = 5
    var valueFishCatched = 0
    
    lazy var fishCatchedLabel: UILabel = {
        let label = UILabel()
        label.text = "Поймано рыб: \(valueFishCatched)"
        label.textColor = .white
        return label
    }()
    
    var resetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle("Сброс", for: .normal)
        button.tintColor = .white
        return button
    }()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
        
        let backImage = UIImage(named: "ocean") ?? UIImage()
        view.backgroundColor = UIColor(patternImage: backImage)
        
        resetButton.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
        createFish()
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(resetButton)
        view.addSubview(fishCatchedLabel)
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        fishCatchedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resetButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            resetButton.heightAnchor.constraint(equalToConstant: 30),
            resetButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            resetButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -200),
            
            fishCatchedLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -25),
            fishCatchedLabel.leadingAnchor.constraint(equalTo: resetButton.trailingAnchor, constant: 20)
            ])
    }
    
    func createFish() {
        for _ in 0 ..< valueFish {
            let newFish: Fish = Fish(fish: UIImageView(image: UIImage(named: "fish")!), isFishCathed: false)
            newFish.fish.frame = CGRect( x: Int.random(in: 45 ... 300), y: Int.random(in: 70 ... 700), width: 100, height: 100)
            newFish.fish.alpha = 1.0
            newFish.fish.contentMode = .scaleAspectFit
            fishes.append(newFish)
            view.addSubview(newFish.fish)
            switch Int.random(in: 1...4) {
                case 1: moveLeft(fish: newFish)
                case 2: moveRight(fish: newFish)
                case 3: moveTop(fish: newFish)
                default: moveBottom(fish: newFish)
            }
        }
    }
    
    func moveLeft(fish: Fish) {
        if fish.isFishCathed { return }
        UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            let randomX = Int.random(in: 0..<Int(self.view.frame.width))
            let randomY = Int.random(in: 0..<Int(self.view.frame.height))
            fish.fish.center = CGPoint(x: randomX, y: randomY)
        }, completion: { finished in
            self.moveRight(fish: fish)
          })
    }
    
    func moveRight(fish: Fish) {
        if fish.isFishCathed { return }
        UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            let randomX = Int.random(in: 0..<Int(self.view.frame.width))
            let randomY = Int.random(in: 0..<Int(self.view.frame.height))
            fish.fish.center = CGPoint(x: randomX, y: randomY)
        }, completion: { finished in
            self.moveRight(fish: fish)
          })
    }
    
    func moveTop(fish: Fish) {
        if fish.isFishCathed { return }
        UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            let randomX = Int.random(in: 0..<Int(self.view.frame.width))
            let randomY = Int.random(in: 0..<Int(self.view.frame.height))
            fish.fish.center = CGPoint(x: randomX, y: randomY)
        }, completion: { finished in
            self.moveRight(fish: fish)
          })
    }
    
    func moveBottom(fish: Fish) {
        if fish.isFishCathed { return }
        UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            let randomX = Int.random(in: 0..<Int(self.view.frame.width))
            let randomY = Int.random(in: 0..<Int(self.view.frame.height))
            fish.fish.center = CGPoint(x: randomX, y: randomY)
        }, completion: { finished in
            self.moveRight(fish: fish)
          })
    }
    
    @objc func resetGame() {
        if valueFishCatched == 5 {
            createFish()
            valueFishCatched = 0
            fishCatchedLabel.text = "Поймано рыб: \(valueFishCatched)"
        } else {
            print("не все рыбы пойманы")
        }
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        for fish in 0..<fishes.count {
            let tapLocation = gesture.location(in: fishes[fish].fish.superview)
            if (fishes[fish].fish.layer.presentation()?.frame.contains(tapLocation))! {
                if fishes[fish].isFishCathed { return }
                fishes[fish].isFishCathed = true
                fishCatchedAnimation(fishes[fish].fish)
            }
        }
    }
    
    func fishCatchedAnimation(_ fish: UIImageView) {
        fish.removeFromSuperview()
        self.valueFishCatched += 1
        print("Пойманно рыб: \(self.valueFishCatched)")
        self.fishCatchedLabel.text = "Поймано рыб: \(self.valueFishCatched)"
    }
}

