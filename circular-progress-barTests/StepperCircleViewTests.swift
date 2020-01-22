//
//  circular_progress_barTests.swift
//  circular-progress-barTests
//
//  Created by mac on 21/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Quick
import Nimble

class StepperCircleViewTests: QuickSpec {
    
    override func spec() {
        describe("stepper circle view") {
            
            var stepperCircleView: StepperCircleView!
            
            beforeEach {
                stepperCircleView = StepperCircleView()
            }
            
            context("change progress") {
                it("can change status string") {
                    stepperCircleView.totalSteps = 6
                    stepperCircleView.currentStatus = "Passo \(stepperCircleView.currentStep)\nde \(stepperCircleView.totalSteps)"
                    expect(stepperCircleView.currentStatus).to(equal("Passo 1\nde 6"))
                }
                
                it("should change progress step") {
                    stepperCircleView.currentStep = 2
                    stepperCircleView.totalSteps = 6
                    let currentProgress = stepperCircleView.currentProgress
                    expect(currentProgress).to(equal(2 / 6))
                }
            }
        }
    }
    
}
