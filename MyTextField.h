@interface MyTextField : UITextField
@end

@implementation MyTextField

- (void)deleteBackward
{
    [super deleteBackward];
    
    //At here, you can handle backspace key pressed event even the text field is empty
}

@end