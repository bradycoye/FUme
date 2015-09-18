//
//  MyTextField.h
//  Drunkly
//
//  Created by James Villarrubia on 9/18/15.
//  Copyright (c) 2015 James Villarrubia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTextField : UITextField
@end

@implementation MyTextField

- (void)deleteBackward
{
    [super deleteBackward];
    
    //At here, you can handle backspace key pressed event even the text field is empty
}

@end