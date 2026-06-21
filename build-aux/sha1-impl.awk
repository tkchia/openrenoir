#!/usr/bin/awk -f
# © 2026 TK Chia
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#   * Redistributions of source code must retain the above copyright notice,
#     this list of conditions and the following disclaimer.
#   * Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#   * Neither the name of the developer(s) nor the names of its contributors
#     may be used to endorse or promote products derived from this software
#     without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

function _orLr(x,n, m,l,r){m=2^(32-n);r=x%m;l=int(x/m);return(2^n)*r+l}
function _orCh(x,y,z, f,m){
 f=0;m=1;while(y+z){f+=(x%2?y:z)%2?m:0;x=int(x/2);y=int(y/2);z=int(z/2);m+=m}
 return f}
function _orMj(x,y,z, f,m){
 f=0;m=1
 while(x+y){f+=x%2+y%2+z%2>1?m:0;x=int(x/2);y=int(y/2);z=int(z/2);m+=m}
 return f}
function _orXo(x,y, g,m){
 g=0;m=1;while(x+y){g+=x%2-y%2?m:0;x=int(x/2);y=int(y/2);m+=m}
 return g}
function _orAd(x,y, g,m,q){
 m=0;q=_orQ;if(x>=q){m=q;x-=q}if(y>=q){m=q-m;y-=q}g=x+y;if(g>=q){m=q-m;g-=q}
 return g+m}
function _orSf(t,b,c,d){
 return t<20?_orCh(b,c,d):39<t&&t<60?_orMj(b,c,d):_orXo(_orXo(b,c),d)}
function _orLw(s,i, j,x,y,z,u){
 j=4*i;x=substr(s,j+1,1);y=substr(s,j+2,1);z=substr(s,j+3,1);u=substr(s,j+4,1)
 return (x in _orO)&&(y in _orO)&&(z in _orO)&&(u in _orO)\
  ?_orO[x]*2^24+_orO[y]*2^16+_orO[z]*2^8+_orO[u]:"?"}
# https://www.rfc-editor.org/info/rfc3174/
function sha1(S, l,n,A,B,C,D,E,a,b,c,d,e,W,w,i,t,v,x,y,z){
 l=length(S);if(l>=2^61)return"?";n=int(l/4)
 for(i=0;i<n;++i){v=_orLw(S,i);if(v""=="?")return v;W[i]=v}
 v=_orLw(S _orA,n);if(v""=="?")return v
 W[n++]=v+(l%4>2?12:l%4>1?2965:l%4?758941:194288792);while(n%16-14)W[n++]=0
 W[n++]=int(l/(2^29));W[n++]=(l%(2^29))*8
 A=1732584193;B=4023233417;C=2562383102;D=271733878;E=3285377520
 for(i=0;i<n;i+=16){
  for(t=0;t<16;++t)w[t]=W[i+t];a=A;b=B;c=C;d=D;e=E
  for(;t<80;++t)
   w[t]=_orLr(_orXo(_orXo(w[t-3],w[t-8]),_orXo(w[t-14],w[t-16])),1)
  for(t=0;t<80;++t){
   v=w[t];x=_orLr(a,5);y=_orSf(t,b,c,d)
   z=t<20?1518500249:t<40?1859775393:t<60?2400959708:3395469782
   v=_orAd(_orAd(_orAd(x,y),_orAd(e,v)),z);e=d;d=c;c=_orLr(b,30);b=a;a=v}
  A=_orAd(A,a);B=_orAd(B,b);C=_orAd(C,c);D=_orAd(D,d);E=_orAd(E,e)}
 return sprintf("%08x%08x%08x%08x%08x",A,B,C,D,E)}
function _orIn(u){gsub(/\n/,"\ninfo: ",u);print"info: "u>>"/dev/stderr"}
function _orFa(u){
 gsub(/\n/,"\nerror: ",u);print"error: "u>>"/dev/stderr";exit 1}
function _orTh(s,H, h){
 h=sha1(s);if(h""!=H"")_orFa("got sha1(\""s"\")\n= \""h"\"")
 _orIn("sha1(\""s"\") OK")}
function _orSd(p,r){return r?r%2?_orSd(p,r-1)p:_orSd(p p,r/2):""}
function _orTr(p,r,H, h){
 h=sha1(_orSd(p,r));if(h""!=H"")_orFa("got sha1(\""p"\" × "r")\n= \""h"\"")
 _orIn("sha1(\""p"\" × "r") OK")}
function _orTs(T){
 _orIn("sha1-impl.awk self-test  "_orUr);_orIn("  license: "_orCo)
 _orTh("","da39a3ee5e6b4b0d3255bfef95601890afd80709")
 _orTh("a","86f7e437faa5a7fce15d1ddcb9eaeaea377667b8")
 _orTh("ab","da23614e02469a0d7c7bd1bdab5c9c474b1904dc")
 _orTh("abc","a9993e364706816aba3e25717850c26c9cd0d89d")
 _orTh("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq",\
  "84983e441c3bd26ebaae4aa1f95129e5e54670f1")
 _orTr("01234567012345670123456701234567",20,\
  "dea356a2cddd90c7a7ecedc5ebb563934f460452")
 if(T>1)_orTr("a",1000000,"34aa973cd4c4daa4f61eeb2bdbad27316534016f")}
function _orCt(T,U, c,v,a){
 _orUr="https://codeberg.org/tkchia/openrenoir";_orCo="BSD-3-Clause"
 for(v=32;v<127;++v){c=sprintf("%c",v);_orO[c]=v}
 _orQ=2^31;split(_orUr,a,/\/+/);_orA=a[3]
 if(T)_orTs(T);else if(U!="")print sha1(toupper(U))}
BEGIN{_orCt(_RENOIR_SHA1_SELFTEST+0,_RENOIR_HASH_NAME"")}
