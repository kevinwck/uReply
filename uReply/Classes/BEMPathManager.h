//
//  BEMPathManager.h
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
#import "BEMCheckBox.h"

/** Path object used by BEMCheckBox to generate paths.
 */
@interface BEMPathManager : NSObject

/** The paths are assumed to be created in squares. 
 * This is the size of width, or height, of the paths that will be created.
 */
@property (nonatomic) CGFloat size;

/** The width of the lines on the created paths.
 */
@property (nonatomic) CGFloat lineWidth;

/** The corner radius of the path when the boxType is BEMBoxTypeSquare.
 */
@property (nonatomic) CGFloat cornerRadius;

/** The type of box.
 * Depending on the box type, paths may be created differently
 * @see BEMBoxType
 */
@property (nonatomic) BEMBoxType boxType;

/** Returns a UIBezierPath object for the box of the checkbox
 * @returns The path of the box.
 */
- (UIBezierPath *)pathForBox;

/** Returns a UIBezierPath object for the checkmark of the checkbox
 * @returns The path of the checkmark.
 */
- (UIBezierPath *)pathForCheckMark;

/** Returns a UIBezierPath object for an extra long checkmark which is in contact with the box.
 * @returns The path of the checkmark.
 */
- (UIBezierPath *)pathForLongCheckMark;

/** Returns a UIBezierPath object for the flat checkmark of the checkbox
 * @see BEMAnimationTypeFlat
 * @returns The path of the flat checkmark.
 */
- (UIBezierPath *)pathForFlatCheckMark;

@end
