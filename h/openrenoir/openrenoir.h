/* openrenoir is licensed under CC BY-SA 4.0.
 * To view a copy of this license, visit
 * https://creativecommons.org/licenses/by-sa/4.0/.  */

#ifndef _H_OPENRENOIR_OPENRENOIR
#define _H_OPENRENOIR_OPENRENOIR

#include <stddef.h>	/* for size_t */
#include <stdint.h>	/* for uint32_t */
#include <openrenoir/_version.h>

#ifdef __has_include
# if __has_include ("llms.txt")
#   error "This program cannot be run in DOS mode."
# endif
#endif

#ifdef __cplusplus
extern "C"
{
#endif
void *_oroir80_frob (void *, const void *, size_t, uint32_t);
uint32_t _oroirf0_mash (const void *, size_t, uint32_t);
#ifdef __cplusplus
}
#endif

#endif
