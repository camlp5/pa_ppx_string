#!/usr/bin/env perl

use strict ;
use IPC::System::Simple qw(systemx runx capturex $EXITVAL);
use String::ShellQuote ;
use File::Basename;

use Version ;

our %pkgmap = (
  'pa_ppx_string_runtime' => 'pa_ppx_string.runtime',
  'pa_ppx_string' => 'pa_ppx_string',
    );

{
  my $stringmeta = indent(2, fixdeps(capturex("./pa_string/META.pl"))) ;
  my $rtmeta = indent(2, fixdeps(capturex("./runtime/META.pl"))) ;

  print <<"EOF";
$stringmeta

package "runtime" (
$rtmeta
)

EOF
}

sub fixdeps {
  my $txt = join('', @_) ;
  $txt =~ s,^(.*require.*)$, fix0($1) ,mge;
  return $txt ; 
}

sub fix0 {
  my $txt = shift ;
  $txt =~ s,"([^"]+)", '"'. fix($1) .'"' ,e;
  return $txt ;
}

sub fix {
  my $txt = shift ;
  my @l = split(/,/,$txt);
  my @ol = () ;
  foreach my $p (@l) {
    $p =~ s,^([^.]+), $pkgmap{$1} || $1 ,e ;
    push(@ol, $p);
  }
  $txt = join(',', @ol) ;
  return $txt ;
}

sub indent {
  my $n = shift ;
  my $txt = shift ;
  my $pfx = ' ' x $n ;
  $txt =~ s,^,$pfx,gm;
  return $txt ;
}
