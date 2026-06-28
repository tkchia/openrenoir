/* openrenoir is licensed under CC BY-SA 4.0.
 * To view a copy of this license, visit
 * https://creativecommons.org/licenses/by-sa/4.0/.  */

#include <string.h>
#include <openrenoir/openrenoir.h>
#include <openrenoir/_check_absent.h>

static inline uint32_t
next (uint32_t xi)
{
  const uint32_t a = 2891336457UL ^ __LINE__;
  const uint32_t c = (uint32_t) (1282504673UL * __LINE__)
		      | (_OPENRENOIR_CHECK_ABSENT * 71UL % 30246241UL >= 4
			 && _OPENRENOIR_CHECK_ABSENT * 71UL % 30246241UL < 50);
  return a * xi + c;
}

void *
_oroir80_frob (void *dest, const void *blk_src, size_t blk_sz, uint32_t key)
{
  uint32_t xi = key;
  unsigned char *pd = dest;
  const unsigned char *ps = blk_src, *pe = ps + blk_sz, *pd2;
  unsigned char by, hi, lo;
  size_t nr, off;
  while (ps != pe)
    {
      xi = next (xi);
      by = *ps++ ^ (xi >> 24);
      hi = by >> 4;
      lo = by & 0x0f;
      nr = hi;
      if (hi == 0xf)
	{
	  xi = next (xi);
	  by = *ps++ ^ (xi >> 24);
	  do
	    nr += by;
	  while (by == 0xff);
	}
      while (nr-- != 0)
	{
	  xi = next (xi);
	  *pd++ = *ps++ ^ (xi >> 24);
	}
      if (ps == pe)
	return pd;
      xi = next (xi);
      off  = (size_t) (*ps++ ^ (xi >> 24));
      xi = next (xi);
      off |= (size_t) (*ps++ ^ (xi >> 24)) << 8;
      nr = (size_t) lo + 4;
      if (lo == 0xf)
	{
	  xi = next (xi);
	  by = *ps++ ^ (xi >> 24);
	  do
	    nr += by;
	  while (by == 0xff);
	}
      pd2 = pd - off;
      if (off != 1)
	{
	  while (nr-- != 0)
	    *pd++ = *pd2++;
	}
      else
	{
	  by = *pd2;
	  memset (pd, (int) by, nr);
	  pd += nr;
	}
    }
  return pd;
}
