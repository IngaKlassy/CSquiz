//
//  ViewController.swift
//  CSquiz
//
//  Created by Inga Klassy on 9/17/18.
//  Copyright © 2018 Inga Klassy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //@IBOutlet var questionLabel: UILabel!
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = ["What is a file?", "What is a class?", "What is an object?", "What is a constructor?", "What is inheritance?", "What are instance and class variables?", "Compare method and constructor?", "Name different types of access\n modifiers in Java?", "Which operator has the highest\n precedence in Java?", "Is string class final in Java?", "What is the difference between\n overloading and overriding?", "What are multiple inheritances in Java?", "What is a sream?", "What is the difference between class and\n interface in Java?", "What is an abstract class?"]
    let answers: [String] = ["A file is a named location which stores data or information permanently.", "A class is a blueprint from which objects are created. A class contains methods and variables associated with an instance of a class.", "An object is an instance of a class.", "A constructor is a method which is used to create an object of a class.", "Inheritance is a property in which a property of a parent class (Superclass) is passed on to a child class (Subclass).", "Instance variables belong to a particular instance of a class; class variables belong to the class itself. Class variables are also known as static variables.", "Constructor is used to initialize the instance of a class; it does not have a return type. Method is used to perform some function or operation; it has a return type.", "There are four types of access modifiers: 1.Visible to the overall package. No modifier needed. 2.Private - visible to class only. 3.Public - visible to the world. 4. Protected - visible to package and subclass.", "The operator with the highest precedence is Postfix, i.e. () [].", "Yes", "Overloading is when two or more methods in the same class have the same method name but different parameters (i.e. different method signatures). Overriding is when two methods having the same method name and parameters (i.e. method signature) but one of the methods is in the parent class and the other is in the child class.", "Java supports multiple inheritances i.e. the ability of a class to implement more than one interface. A class can implement multiple interfaces but cannot extend multiple classes.", "A stream can be defined as the sequence of data. There are two types of streams: Input Stream is used to read data from a source. Output Stream is used to write data into a destination.", "The interfaces cannot be instantiated. An interface does not have any constructors. Interfaces only have abstract methods. A class implements an interface and extends a class.", "A class which contains the abstract keyword in a declaration is called abstract class. Abstract classes may or may not contain abstract methods, but if a class has at least one abstract method, then it must be declared abstract. The abstract class cannot be instantiated, so in order to use it we have to inherit it from another class. If we inherit an abstract class, then we have to provide implementations to all the abstract methods in it." ]
    var currentQuestionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    func animateLabelTransitions() {
        //force any outstanding layout changes to occur
        view.layoutIfNeeded()
        
        //animate the alpha and the center X constraints
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animate(withDuration: 0.5,
            delay: 0,
            options: [],
            animations: {
                self.currentQuestionLabel.alpha = 0
                self.nextQuestionLabel.alpha = 1
                self.view.layoutIfNeeded()
        },
            completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
                self.updateOffScreenLabel()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //label's initial alpha
        nextQuestionLabel.alpha = 0
    }
    
}











