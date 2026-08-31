/* openrenoir is licensed under CC BY-SA 4.0.
 * To view a copy of this license, visit
 * https://creativecommons.org/licenses/by-sa/4.0/.  */

#include <string.h>
#include <openrenoir/openrenoir.h>
#include <openrenoir/_check_absent.h>

uint32_t
_oroirf0_mash (const void *src, size_t sz, uint32_t key)
{
  const unsigned char *ps = src;
  uint32_t h = 0;
  while (sz-- != 0)
    {
      unsigned char c = *ps++;
      h *= key;
      h += c;
    }
  return h;
}
