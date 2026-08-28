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

function _orIn(u){gsub(/\n/,"\ninfo: ",u);print"info: "u>>"/dev/stderr"}
function _orFa(u){
 gsub(/\n/,"\nerror: ",u);print"error: "u>>"/dev/stderr";exit 99}
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
BEGIN{_orTs(_RENOIR_SHA1_SELFTEST+0)}
