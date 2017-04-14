//
//  demo10ViewController.h
//  demo10
//
//  Created by DinhKhacViet on 4/14/17.
//  Copyright © 2017 DinhKhacViet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPPDropDown.h"
#import "VPPDropDownDelegate.h"

@interface demo10ViewController : UIViewController <VPPDropDownDelegate, UIActionSheetDelegate> {
    
@private
    VPPDropDown *_dropDownSelection;
    VPPDropDown *_dropDownDisclosure;
    VPPDropDown *_dropDownCustom;
    
    NSIndexPath *_ipToDeselect;
}

//-(void)miniMizeThisRows:(NSArray*)ar;




@end
