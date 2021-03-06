//
//  BEMAnimationManager.h
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

#import <UIKit/UIKit.h>

/** Animation object used by BEMCheckBox to generate animations.
 */
@interface BEMAnimationManager : NSObject

/** The duration of the animation created by the BEMAnimationManager object.
 */
@property (nonatomic) CGFloat animationDuration;

/** Designated initializer.
 * @param animationDuration The duration of the animations created with the BEMAnimationManager object.
 * @return Returns the a fully initialized BEMAnimationManager object.
 */
- (instancetype)initWithAnimationDuration:(CGFloat)animationDuration;

/** Returns a CABasicAnimation which the stroke.
 * @param reverse The direction of the animation. Set to YES if the animation should go from opacity 0 to 1, or NO for the opposite.
 * @return Returns the CABasicAnimation object.
 */
- (CABasicAnimation *)strokeAnimationReverse:(BOOL)reverse;

/** Returns a CABasicAnimation which animates the opacity.
 * @param reverse The direction of the animation. Set to YES if the animation should go from opacity 0 to 1, or NO for the opposite.
 * @return Returns the CABasicAnimation object.
 */
- (CABasicAnimation *)opacityAnimationReverse:(BOOL)reverse;

/** Returns a CABasicAnimation which animates between two paths.
 * @param fromPath The path to transform (morph) from.
 * @param toPath The path to transform (morph) to.
 * @return Returns the CABasicAnimation object.
 */
- (CABasicAnimation *)morphAnimationFromPath:(UIBezierPath *)fromPath toPath:(UIBezierPath *)toPath ;

/** Animation engine to create a fill animation.
 * @param bounces The number of bounces for the animation.
 * @param amplitude How far does the animation bounce.
 * @param reverse Flag to track if the animation should fill or empty the layer.
 * @return Returns the CAKeyframeAnimation object.
 */
- (CAKeyframeAnimation *)fillAnimationWithBounces:(NSUInteger)bounces amplitude:(CGFloat)amplitude reverse:(BOOL)reverse;

@end
