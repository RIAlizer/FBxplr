// UIImage+Optimize.m


//http://stackoverflow.com/questions/924740/dispelling-the-uiimage-imagenamed-fud
//
#import "UIImage+Optimize.h"

@implementation UIImage (Optimize)

/*+ (UIImage*)imageNamed:(NSString *)name
{
    ALog(@"UIImage (Optimize) %@", name);
    return [UIImage imageFromMainBundleFile:name];
}
*/
+ (UIImage*)imageFromMainBundleFile:(NSString*)aFileName; 
{
    NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", bundlePath,aFileName]];
}
@end
