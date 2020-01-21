//
//  circular_progress_barTests.swift
//  circular-progress-barTests
//
//  Created by mac on 21/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Quick
import Nimble

/*
 - Given
    a step circular progress
 - When
    set total of screens of scenario
 - Then
    

*/

class StepCircularProgressTests: QuickSpec {
    override func spec() {
        
        var stepperCircle: StepperCircle!
        var scenes: [UIViewController]!
        
        describe("stepper circle") {
            context("get total screens of scenario") {
                
                beforeSuite {
                    scenes = [UIViewController(), UIViewController()]
                    stepperCircle = StepperCircle(scenes: scenes)
                }
                
                it("should sets stepper circle view") {
                    let stepperCircleView = stepperCircle.view
                    expect(stepperCircleView).notTo(beNil())
                }
                
                it("should get initial progress") {
                    let currentProgress = stepperCircle.view.step
                    expect(currentProgress).to(equal(0))
                }
            }
            
            describe("navigate between screens") {
                
                beforeEach {
                    scenes = [UIViewController(), UIViewController()]
                    stepperCircle = StepperCircle(scenes: scenes)
                }
                
                context("back step") {
                    
                    it("back to previous step") {
                        let currentProgressStep = 5
                        stepperCircle.view.step = currentProgressStep
                        stepperCircle.backStep()
                        let previousProgressStep = stepperCircle.view.step
                        expect(previousProgressStep).to(equal(currentProgressStep - 1))
                    }
                    
                    it("not exceed first step") {
                        stepperCircle.backStep()
                        let previousProgressStep = stepperCircle.view.step
                        expect(previousProgressStep).toNot(beLessThan(0))
                    }
                }
                
                context("next step") {
                    it("go to next step") {
                        let currentStep = stepperCircle.scenes.startIndex
                        stepperCircle.view.step = currentStep
                        stepperCircle.goToNextStep()
                        let nextStep = stepperCircle.view.step
                        expect(nextStep).to(equal(currentStep + 1))
                    }
                    
                    it("no exceed last step") {
                        let lastStep = stepperCircle.scenes.count - 1
                        stepperCircle.view.step = lastStep
                        stepperCircle.goToNextStep()
                        let nextStep = stepperCircle.view.step
                        expect(nextStep).to(equal(lastStep))
                    }
                }
                
            }
        }
    }
}
