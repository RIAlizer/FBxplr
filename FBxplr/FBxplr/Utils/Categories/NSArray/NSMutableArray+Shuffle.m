//
//  FaceHairData.h
//  create
//
//  Created by Daniele Salvioni on 15/06/12.
//  Copyright (c) 2012 JoinPad. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"
#include <stdlib.h>

@implementation NSMutableArray (Shuffle)

- (void)shuffle
{
    // http://en.wikipedia.org/wiki/Knuth_shuffle
    //
    // ALGORITMO ORIGINALE
    // To shuffle an array a of n elements (indices 0..n-1):
    // for i from n − 1 downto 1 do
    //     j ← random integer with 0 ≤ j ≤ i
    //     exchange a[j] and a[i]
    
    for (int i=([self count]-1); i>0; --i)
    {
        // estrae in modo pseudocasuale un numero tra 0 e i
        unsigned int j = arc4random_uniform(i);
        [self exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
}

@end
