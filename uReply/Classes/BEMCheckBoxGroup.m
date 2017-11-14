//
//  BEMCheckBoxGroup.m
//  CheckBox
//
//  Created by Cory Imdieke on 10/17/16.
//  Copyright © 2016 Boris Emorine. All rights reserved.
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

#import "BEMCheckBoxGroup.h"
#import "BEMCheckBox.h"

@interface BEMCheckBoxGroup ()

@property (nonatomic, strong, nonnull) NSHashTable *checkBoxes;

@end

/** Defines private methods that we can call on the check box.
 */
@interface BEMCheckBox ()

@property (strong, nonatomic, nullable) BEMCheckBoxGroup *group;

- (void)_setOn:(BOOL)on animated:(BOOL)animated notifyGroup:(BOOL)notifyGroup;

@end

@implementation BEMCheckBoxGroup

- (instancetype)init {
    self = [super init];
    if (self) {
        _mustHaveSelection = NO;
        _checkBoxes = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    }
    return self;
}

+ (nonnull instancetype)groupWithCheckBoxes:(nullable NSArray<BEMCheckBox *> *)checkBoxes {
    BEMCheckBoxGroup *group = [[BEMCheckBoxGroup alloc] init];
    for (BEMCheckBox *checkbox in checkBoxes) {
        [group addCheckBoxToGroup:checkbox];
    }
    
    return group;
}

- (void)addCheckBoxToGroup:(nonnull BEMCheckBox *)checkBox {
    if (checkBox.group) {
        [checkBox.group removeCheckBoxFromGroup:checkBox];
    }
    
    [checkBox _setOn:NO animated:NO notifyGroup:NO];
    checkBox.group = self;

    [self.checkBoxes addObject:checkBox];
}

- (void)removeCheckBoxFromGroup:(nonnull BEMCheckBox *)checkBox {
    if (![self.checkBoxes containsObject:checkBox]) {
        // Not in this group
        return;
    }
    
    checkBox.group = nil;
    [self.checkBoxes removeObject:checkBox];
}

#pragma mark Getters

- (BEMCheckBox *)selectedCheckBox {
    BEMCheckBox *selected = nil;
    for (BEMCheckBox *checkBox in self.checkBoxes) {
        if(checkBox.on){
            selected = checkBox;
            break;
        }
    }
    
    return selected;
}

#pragma mark Setters

- (void)setSelectedCheckBox:(BEMCheckBox *)selectedCheckBox {
    if (selectedCheckBox) {
        for (BEMCheckBox *checkBox in self.checkBoxes) {
            BOOL shouldBeOn = (checkBox == selectedCheckBox);
            if(checkBox.on != shouldBeOn){
                [checkBox _setOn:shouldBeOn animated:YES notifyGroup:NO];
            }
        }
    } else {
        // Selection is nil
        if(self.mustHaveSelection && [self.checkBoxes count] > 0){
            // We must have a selected checkbox, so re-call this method with the first checkbox
            self.selectedCheckBox = [self.checkBoxes anyObject];
        } else {
            for (BEMCheckBox *checkBox in self.checkBoxes) {
                BOOL shouldBeOn = NO;
                if(checkBox.on != shouldBeOn){
                    [checkBox _setOn:shouldBeOn animated:YES notifyGroup:NO];
                }
            }
        }
    }
}

- (void)setMustHaveSelection:(BOOL)mustHaveSelection {
    _mustHaveSelection = mustHaveSelection;
    
    // If it must have a selection and we currently don't, select the first box
    if (mustHaveSelection && !self.selectedCheckBox) {
        self.selectedCheckBox = [self.checkBoxes anyObject];
    }
}

#pragma mark Private methods called by BEMCheckBox

- (void)_checkBoxSelectionChanged:(BEMCheckBox *)checkBox {
    if ([checkBox on]) {
        // Change selected checkbox to this one
        self.selectedCheckBox = checkBox;
    } else if(checkBox == self.selectedCheckBox) {
        // Selected checkbox was this one, clear it
        self.selectedCheckBox = nil;
    }
}

@end
