#!/usr/bin/env perl

use strict ;
BEGIN { push (@INC, "..") }
use Version ;

our $destdir = shift @ARGV ;

print <<"EOF";
# Specifications for the "pa_ppx_string" preprocessor:
requires = "camlp5,fmt,re,pa_ppx.base,pa_ppx_string_runtime"
version = "$Version::version"
description = "pa_ppx_string: pa_ppx_string rewriter"

# For linking
package "link" (
requires = "camlp5,fmt,re,pa_ppx.base.link"
archive(byte) = "pa_ppx_string.cma"
archive(native) = "pa_ppx_string.cmxa"
)

# For the toploop:
archive(byte,toploop) = "pa_ppx_string.cma"

  # For the preprocessor itself:
  requires(syntax,preprocessor) = "camlp5,fmt,re,pa_ppx.base"
  archive(syntax,preprocessor,-native) = "pa_ppx_string.cma"
  archive(syntax,preprocessor,native) = "pa_ppx_string.cmxa"

EOF
