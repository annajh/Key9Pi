// Generated by Apple Swift version 3.1 (swiftlang-802.0.51 clang-802.0.41)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if defined(__has_attribute) && __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
@import CoreData;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class UIApplication;

SWIFT_CLASS("_TtC6Key9pi11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> * _Nullable)launchOptions SWIFT_WARN_UNUSED_RESULT;
- (void)applicationWillResignActive:(UIApplication * _Nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * _Nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * _Nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * _Nonnull)application;
- (void)applicationWillTerminate:(UIApplication * _Nonnull)application;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIColor;
@protocol colorDelegate;
@class UITouch;
@class UIEvent;
@class NSCoder;

SWIFT_CLASS("_TtC6Key9pi11ColorPicker")
@interface ColorPicker : UIView
@property (nonatomic) CGFloat currentSelectionX;
@property (nonatomic, strong) UIColor * _Null_unspecified selectedColor;
@property (nonatomic, strong) id <colorDelegate> _Null_unspecified delegate;
- (void)drawRect:(CGRect)rect;
- (void)selectedColorWithSColor:(UIColor * _Nonnull)sColor;
- (void)touchesBegan:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (void)touchesMoved:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (void)touchesEnded:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (void)updateColorWithTouch:(UITouch * _Nonnull)touch;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSLayoutConstraint;
@class UIButton;
@protocol UITextInput;
@class NSBundle;

SWIFT_CLASS("_TtC6Key9pi22KeyboardViewController")
@interface KeyboardViewController : UIInputViewController
- (void)updateDict;
@property (nonatomic, strong) NSLayoutConstraint * _Null_unspecified heightConstraint;
@property (nonatomic, readonly, strong) UIColor * _Nonnull myBlue;
@property (nonatomic, readonly, strong) UIColor * _Nonnull maize;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified textView;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified symView;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified numView;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified downArrow;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified downArrow2;
@property (nonatomic, copy) IBOutletCollection(UIButton) NSArray<UIButton *> * _Null_unspecified allTextButtons;
@property (nonatomic, copy) IBOutletCollection(UIButton) NSArray<UIButton *> * _Null_unspecified allArrowButtons;
@property (nonatomic, copy) IBOutletCollection(UIButton) NSArray<UIButton *> * _Null_unspecified allArrowButtons2;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified shiftButton;
@property (nonatomic, copy) IBOutletCollection(UIButton) NSArray<UIButton *> * _Null_unspecified allButtons;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified backButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified nextButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified backButton2;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified qwertyView;
- (IBAction)qwertyWordPress:(UIButton * _Nonnull)sender;
- (IBAction)qwertyBackPressed:(UIButton * _Nonnull)sender;
- (IBAction)qwertyAddPress:(UIButton * _Nonnull)sender;
- (IBAction)downArrowPress:(UIButton * _Nonnull)sender;
- (IBAction)nextArrowPress:(UIButton * _Nonnull)sender;
@property (nonatomic) BOOL shiftPressed;
@property (nonatomic) BOOL enterPressed;
@property (nonatomic) NSInteger charCounter;
@property (nonatomic, strong) UIColor * _Nonnull shiftColor;
- (void)shiftOn;
- (void)shiftOff;
- (void)resetSuggestions;
@property (nonatomic, copy) IBOutletCollection(UIButton) NSArray<UIButton *> * _Null_unspecified wordButtons;
- (IBAction)wordPress:(UIButton * _Nonnull)sender;
- (IBAction)goToNum:(UIButton * _Nonnull)sender;
- (IBAction)goToSym:(UIButton * _Nonnull)sender;
- (IBAction)goToText:(UIButton * _Nonnull)sender;
- (IBAction)goToAdd:(UIButton * _Nonnull)sender;
- (IBAction)globePress:(UIButton * _Nonnull)sender;
- (IBAction)enterPress:(UIButton * _Nonnull)sender;
- (IBAction)spacePress:(UIButton * _Nonnull)button;
- (IBAction)keyPress:(UIButton * _Nonnull)button;
- (IBAction)shiftPress:(UIButton * _Nonnull)sender;
- (void)updateViewConstraints;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)textWillChange:(id <UITextInput> _Nullable)textInput;
- (void)textDidChange:(id <UITextInput> _Nullable)textInput;
- (void)setUpHeightConstraint;
- (IBAction)letterKeyPress:(UIButton * _Nonnull)sender;
- (IBAction)backspacePress:(UIButton * _Nonnull)sender;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface UIViewController (SWIFT_EXTENSION(Key9pi))
- (void)hideKeyboardWhenTappedAround;
- (void)dismissKeyboard;
@end

@class NSUserDefaults;
@class UITextField;

SWIFT_CLASS("_TtC6Key9pi16ViewControllerMy")
@interface ViewControllerMy : UIViewController
@property (nonatomic, readonly, strong) NSUserDefaults * _Nullable userDefaults;
@property (nonatomic, weak) IBOutlet UITextField * _Null_unspecified wordTextField;
@property (nonatomic, copy) IBOutletCollection(UIButton) NSArray<UIButton *> * _Null_unspecified backgroundButtons;
@property (nonatomic, copy) IBOutletCollection(UIButton) NSArray<UIButton *> * _Null_unspecified buttonsButtons;
@property (nonatomic, copy) IBOutletCollection(UIButton) NSArray<UIButton *> * _Null_unspecified textButtons;
- (IBAction)addWordsPressed:(UIButton * _Nonnull)sender;
- (IBAction)profilePressed:(UIButton * _Nonnull)sender;
- (IBAction)delWordsPressed:(UIButton * _Nonnull)sender;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified academic;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified professional;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified personal;
- (void)highlightActiveProfile;
- (void)viewDidLoad;
- (IBAction)goBack:(UIButton * _Nonnull)sender;
- (void)didReceiveMemoryWarning;
- (IBAction)backgroundPress:(UIButton * _Nonnull)sender;
- (IBAction)buttonPress:(UIButton * _Nonnull)sender;
- (IBAction)textPress:(UIButton * _Nonnull)sender;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSEntityDescription;
@class NSManagedObjectContext;

SWIFT_CLASS_NAMED("Word")
@interface Word : NSManagedObject
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end


@interface Word (SWIFT_EXTENSION(Key9pi))
@property (nonatomic, copy) NSString * _Nullable text;
@end


SWIFT_PROTOCOL("_TtP6Key9pi13colorDelegate_")
@protocol colorDelegate
@optional
- (void)pickedColorWithColor:(UIColor * _Nonnull)color;
@end

#pragma clang diagnostic pop
