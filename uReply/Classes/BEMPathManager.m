//
//  BEMPathManager.m
//  CheckBox
//
//  Created by Bobo on 9/19/15.
//  Copyright (c) 2015 Boris Emorine. All rights reserved.
//
//The MIT License (MIT)
//
//Copyright (c) 2015 Boris Emorine.
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

#import "BEMPathManager.h"

@implementation BEMPathManager

#pragma mark Paths

- (UIBezierPath *)pathForBox {
    UIBezierPath* path;
    switch (self.boxType) {
        case BEMBoxTypeSquare:
            path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0 + (self.lineWidth / 2.0), 0.0 + (self.lineWidth / 2.0), self.size - self.lineWidth, self.size - self.lineWidth) cornerRadius:self.cornerRadius];
            [path applyTransform:CGAffineTransformRotate(CGAffineTransformIdentity, M_PI * 2.5)];
            [path applyTransform:CGAffineTransformMakeTranslation(self.size, 0)];
            break;
            
        default: {
            CGFloat radius = (self.size / 2.0) - (self.lineWidth / 2.0);;
            path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.size / 2, self.size / 2)
                                                  radius: radius
                                              startAngle: - M_PI / 4
                                                endAngle:  2 * M_PI - M_PI / 4
                                               clockwise:YES];
        }
            break;
    }
    return path;
}

- (UIBezierPath *)pathForCheckMark {
    UIBezierPath* checkMarkPath = [UIBezierPath bezierPath];
    
    [checkMarkPath moveToPoint: CGPointMake(self.size/3.1578, self.size/2)];
    [checkMarkPath addLineToPoint: CGPointMake(self.size/2.0618, self.size/1.57894)];
    [checkMarkPath addLineToPoint: CGPointMake(self.size/1.3953, self.size/2.7272)];
    
    if (self.boxType == BEMBoxTypeSquare) {
        // If we use a square box, the check mark should be a little bit bigger
        [checkMarkPath applyTransform:CGAffineTransformMakeScale(1.5, 1.5)];
        [checkMarkPath applyTransform:CGAffineTransformMakeTranslation(-self.size/4, -self.size/4)];
    }
    
    return checkMarkPath;
}

- (UIBezierPath *)pathForLongCheckMark {
    UIBezierPath* checkMarkPath = [UIBezierPath bezierPath];
    
    [checkMarkPath moveToPoint: CGPointMake(self.size/3.1578, self.size/2)];
    [checkMarkPath addLineToPoint: CGPointMake(self.size/2.0618, self.size/1.57894)];
    
    if (self.boxType == BEMBoxTypeSquare) {
        // If we use a square box, the check mark should be a little bit bigger
        [checkMarkPath addLineToPoint: CGPointMake(self.size/1.2053, self.size/4.5272)];
        [checkMarkPath applyTransform:CGAffineTransformMakeScale(1.5, 1.5)];
        [checkMarkPath applyTransform:CGAffineTransformMakeTranslation(-self.size/4, -self.size/4)];
    } else {
        [checkMarkPath addLineToPoint: CGPointMake(self.size/1.1553, self.size/5.9272)];
    }
    
    return checkMarkPath;
}

- (UIBezierPath *)pathForFlatCheckMark {
    UIBezierPath* flatCheckMarkPath = [UIBezierPath bezierPath];
    [flatCheckMarkPath moveToPoint: CGPointMake(self.size/4, self.size/2)];
    [flatCheckMarkPath addLineToPoint: CGPointMake(self.size/2, self.size/2)];
    [flatCheckMarkPath addLineToPoint: CGPointMake(self.size/1.2, self.size/2)];
    
    return flatCheckMarkPath;
}

@end
