# DRGKeyboardManager

## GOAL

Move to a class manager all the code responsible to updating the view 
after the keyboard state change. We don't like the Massive ViewControllers :)

## DESCRIPTION
 
 This a simple manager that resizes the viewController.view
 when a keyboard appears or disappears. The change is animated
 and synchronized with keyboard's animation.
 
## DISCUSSION
 
 The idea is to resize the viewController's container view using an animation.
 Since we are resizing the superview, this manager works perfectly with
 UITableViews, UICollectionViews and UIScrollViews (scrollable views in general).
 This is because we are not modifying the scrollview's contentView,
 only its superview (the view that contains the scrollview).
 
## IMPORTANT ISSUES
 
 - If your viewController doesn't contain an scrollable view, then you are 
 responsible to ensure that your UI looks great after its superview was resized.
 You can use its delegate's methods to make changes in the layout, adapting
 it to the new size.
 
 - About scrollable views. After resizing their superview, these automatically
 adjust their scroll in order to make visible the active field.
 However, you can always adjust manually the view's scroll after the animation 
 was finished. Take a look at the sample project.
 
 - viewController's width view will never change.
 
 ## HOW TO USE IT
 
Five pretty straightforward steps

        #import "SimpleViewController.h"
        // 1. Import the class
        #import "DRGKeyboardManager.h"
        
        @interface SimpleViewController ()
        
        // 2. Create a property
        @property (nonatomic, strong) DRGKeyboardManager *kbManager;
        
        @end
        
        @implementation SimpleViewController
        
        - (void)viewDidLoad {
            [super viewDidLoad];
            
            // 3. Initialize the keyboard manager
            self.kbManager = [[DRGKeyboardManager alloc] initForViewController:self];
        }
        
        - (void)viewDidAppear:(BOOL)animated {
            [super viewDidAppear:animated];
            
            // 4. Register to UIKeyboard notifications
            [self.kbManager beginObservingKeyboard:[NSNotificationCenter defaultCenter]];
        }
        
        - (void)viewWillDisappear:(BOOL)animated {
            [super viewWillDisappear:animated];
            
            // 5. Don't forget to unregister it
            [self.kbManager endObservingKeyboard];
        }
 
 
