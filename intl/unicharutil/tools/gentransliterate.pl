#!/usr/bin/perl 
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

$header = <<END_OF_HEADER;
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# 
# THIS FILE IS GENERATED BY mozilla/intl/unicharutil/tools/gentransliterate.pl
# PLEASE DO NOT MODIFY THIS FILE BY HAND
#
entity.list.name=transliterate
entity.169=(c)
#
#
# Here are the windows-1252 characters from the range 0x80 - 0x9F
#
END_OF_HEADER

$handcoded = <<END_OF_HANDCODED;
# EURO SIGN
entity.8364=EUR
# SINGLE LOW-9 QUOTATION MARK
entity.8218=,
# LATIN SMALL LETTER F WITH HOOK
entity.402=f
# DOUBLE LOW-9 QUOTATION MARK
entity.8222="
# DAGGER
entity.8224=+
# DOUBLE DAGGER
entity.8225=++
# MODIFIER LETTER CIRCUMFLEX ACCENT
entity.710=^
# PER MILLE SIGN
entity.8240=0/00
# SINGLE LEFT-POINTING ANGLE QUOTATION MARK
entity.8249=<
# LATIN CAPITAL LIGATURE OE
entity.338=OE
# LEFT SINGLE QUOTATION MARK
entity.8216='
# RIGHT SINGLE QUOTATION MARK
entity.8217='
# LEFT DOUBLE QUOTATION MARK
entity.8220="
# RIGHT DOUBLE QUOTATION MARK
entity.8221="
# BULLET
entity.8226=.
# EN DASH
entity.8211=--
# EM DASH
entity.8212=---
# SMALL TILDE
entity.732=~
# SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
entity.8250=>
# LATIN SMALL LIGATURE OE
entity.339=oe
# U+2000 EN QUAD
entity.8192=\\u0020
# U+2001 EM QUAD
entity.8193=\\u0020
# U+2010 HYPHEN
entity.8208=-
# U+2011 NON-BREAKING HYPHEN
entity.8209=-
# U+2012 FIGURE DASH
entity.8210=-
# U+2015 HORIZONTAL BAR
entity.8213=--
# U+200B, ZERO WIDTH SPACE (a.k.a. InvisibleComma)
entity.8203=
# U+2061, ApplyFunction, character showing function application in presentation tagging
entity.8289=
# U+2062, InvisibleTimes, marks multiplication when it is understood without a mark
entity.8290=
# U+2146, DifferentialD, d for use in differentials, e.g., within integrals
entity.8518=d
# U+2212, MINUS SIGN, official Unicode minus sign
entity.8722=-
# Hebrew punctuation
# U+05BE HEBREW PUNCTUATION MAQAF
entity.1470=-
# U+05C0 HEBREW PUNCTUATION PASEQ
entity.1472=|
# U+05C3 HEBREW PUNCTUATION SOF PASUQ
entity.1475=:
# U+05F3 HEBREW PUNCTUATION GERESH
entity.1523='
# U+05F4 HEBREW PUNCTUATION GERSHAYIM
entity.1524="
##
## End of hand coded section
## Below are generated from the unicode character database
##
END_OF_HANDCODED

@table = ();
sub FromLatinComment
{
  my ($cmt) = (@_);
  $char = "";
  if($cmt =~ /PRECEDED BY APOSTROPHE/) {
      $char = "\'";
  }
  if($cmt =~ /CAPITAL LETTER ([A-Z]*)/) {
      $char = $char . $1;
  }
  if($cmt =~ /SMALL LETTER ([A-Z]*)/) {
      $char = $char . lc($1);
  }
  @f = split(/ / , $cmt); 
  while($item = shift @f) {
     if($item eq "DOT") {
       $char .= ".";
     } elsif ($item eq "DIAERESIS") {
       $char .= "\"";
     } elsif ($item eq "BREVE") {
       $char .= "(";
     } elsif ($item eq "ACUTE") {
       $char .= "\'";
     } elsif ($item eq "GRAVE") {
       $char .= "`";
     } elsif ($item eq "TILDE") {
       $char .= "~";
     } elsif ($item eq "CARON") {
       $char .= "(";
     } elsif ($item eq "HOOK") {
       $char .= "?";
     } elsif ($item eq "CEDILLA") {
       $char .= ",";
     } elsif ($item eq "MACRON") {
       $char .= "-";
     } elsif ($item eq "CIRCUMFLEX") {
       $char .= "^";
     } elsif ($item eq "RING") {
       $char .= "*";
     } elsif ($item eq "OGONEK") {
       $char .= ";";
     } elsif ($item eq "LINE") {
       $char .= "_";
     } elsif ($item eq "COMMA") {
       $char .= ",";
     } elsif ($item eq "STROKE") {
       $char .= "/";
     } elsif ($item eq "HORN") {
       $char .= "+";
     } elsif ($item =~ /^(LATIN|CAPITAL|SMALL|LETTER|WITH|ABOVE|BELOW|INVERTED|MIDDLE|AND|BY|APOSTROPHE|[A-Z])$/) {
       # ignore
     } else {
       #print "AAAA $item\n";
     }
  }
  
  return $char;
}
sub warning
{
  my ($warning) = (@_);
  print "WARNING: $warning \n";
}
sub doutput
{
  my ($u, $cmt, $udec, $str) = (@_);
  # don't print out comments - for debugging purposes only
  # print "# U+$u $cmt\n";
  print "entity.$udec=$str\n";
}
sub output
{
  my ($u, $cmt, $udec, $str) = (@_);
  if(decomposeIntoNonASCII($str)) {
    if(($cmt =~ "LATIN")  && ($cmt =~ "LETTER") && !($cmt =~ "LONG")) {
       $str = FromLatinComment($cmt);
       output($u,$cmt,$udec,$str);
    }
  } else {
    # don't print out comments - for debugging purposes only
    # print OUT "# U+$u $cmt\n";
    print OUT "entity.$udec=$str\n";
  }
}

sub decomposeIntoNonASCII
{
  my ($dec) = (@_);
  return $dec =~ /\\u([1-9A-F][0-9A-F][0-9A-F]|[0-9A-F][1-9A-F][0-9A-F]|00[8-9A-F])[0-9A-F]/;
}

sub foldcombining
{
  my ($dec) = (@_);
  $grave = "0060";
  $acute = "0027";
  $hat = "005E";
  $hat = "005E";
  $tilde = "007E";
  $overscore = "002D"; ## should be 00AF but we can only handle ASCII now
  $umlaut = "0022"; ## should be 00A8 but we can only handle ASCII now
  $doubleacute = "0022";
  $dot = "002E";
  $doublegrave = "0060 0060";


  $dec =~ s/00A8/$umlaut/eg;
  $dec =~ s/00AF/$overscore/eg;
 # $dec =~ s/00B0//eg;
  $dec =~ s/00B4/$acute/eg;
  $dec =~ s/00B7/$dot/eg;
 # $dec =~ s/00B8//eg;
  $dec =~ s/0300/$grave/eg;
  $dec =~ s/0301/$acute/eg;
  $dec =~ s/0302/$hat/eg;
  $dec =~ s/0303/$tilde/eg;
  $dec =~ s/0304/$overscore/eg;
  $dec =~ s/0305/$overscore/eg;
 #$dec =~ s/0306/?/eg;
  $dec =~ s/0307/$dot/eg;
  $dec =~ s/0308/$umlaut/eg;
 #$dec =~ s/0309/?/eg;
 #$dec =~ s/030A/?/eg;
  $dec =~ s/030B/$doubleacute/eg;
 #$dec =~ s/030C/?/eg;
  $dec =~ s/030D/$acute/eg;
  $dec =~ s/030E/$doubleacute/eg;
  $dec =~ s/030F/$doublegrave/eg;

 # $dec =~ s/03[0-9A-F][0-9A-F]//eg; ## drop others
  return $dec;
}
sub rdecompose
{
  my ($dec) = (@_);
  if(exists $table{$dec}) {
    $t = $table{$dec};
    $t =~ s/<[a-zA-Z]*>//eg;
    $t = foldcombining($t);
    return rdecompose( $table{$t});
  }
  return $dec;
}
sub decompose
{
  my ($removeprefix, $dec) = (@_);
  $removeprefix .= " ";
  
  $dec =~ s/$removeprefix//eg;
  if($dec eq "0020") {
   $dec = "\\u0020";
  } elsif($dec eq "005C") {
   $dec = "\\u005C";
  } else {
   $k = "\/";
   $dec =~ s/2044/$k/eg;
   $dec =~ s/([0-9A-F][0-9A-F][0-9A-F][0-9A-F])/rdecompose($1)/eg;
   $dec =~ s/([0-9A-F][0-9A-F][0-9A-F][0-9A-F])/\\u$1/g;
   $dec =~ s/\\u00([0-7][0-9A-F])/pack("C",hex($1))/eg;
   $dec =~ s/ //eg;
  } 
  return $dec;
}

######################################################################
#
# Open the unicode database file
#
######################################################################
open ( UNICODATA , "< UnicodeData-Latest.txt") 
   || die "cannot find UnicodeData-Latest.txt";

open ( UNICODATA2 , "< UnicodeData-Latest.txt") 
   || die "cannot find UnicodeData-Latest.txt";
######################################################################
#
# Open the output file
#
######################################################################
open ( OUT , "> ../tables/transliterate.properties") 
  || die "cannot open output ../tables/transliterate.properties file";

print OUT $header;

# remove comments from $handcoded
$handcoded =~ s/^#[^#].*\n//mg;
print OUT $handcoded;

######################################################################
#
# Process the file line by line
#
######################################################################
while(<UNICODATA2>) {
   chop;
   @f = split(/;/ , $_); 
   $udec = hex($u);
   if(($udec > 256 ) && ($f[5] ne "")) {
     $table{$f[0]}=$f[5];
   }
}
while(<UNICODATA>) {
   chop;
   ######################################################################
   #
   # Get value from fields
   #
   ######################################################################
   @f = split(/;/ , $_); 
   $u = $f[0];    # The unicode value
   $cmt = $f[1];  # The comment
   $dec = $f[5];  # The decomposed value
   $d1 = $f[6];  
   $d2 = $f[7];  
   $d3 = $f[8];  
   $udec = hex($u);

   if($udec > 128) 
   {
     # not ASCII
     if($dec ne "") 
     {
       # have decomposition
       if($dec =~ /</)  {
           # formated decomposition
           if($dec =~ /<wide>/)  {
              output($u,$cmt,$udec,&decompose("<wide>", $dec));
           } elsif($dec =~ /<narrow>/)  {
              # ignore non ASCII decomposition
              # warning($_);
           } elsif($dec =~ /<circle>/)  {
              output($u,$cmt,$udec,&decompose("<circle>", "(".$dec.")"));
           } elsif($dec =~ /<fraction>/)  {
              output($u,$cmt,$udec,&decompose("<fraction>", $dec));
           } elsif($dec =~ /<small>/)  {
              output($u,$cmt,$udec,&decompose("<small>", $dec));
           } elsif($dec =~ /<vertical>/)  {
              # warning($_);
           } elsif($dec =~ /<super>/)  {
              output($u,$cmt,$udec,"^(".&decompose("<super>", $dec).")");
           } elsif($dec =~ /<sub>/)  {
              output($u,$cmt,$udec,"v(".&decompose("<sub>", $dec).")");
           } elsif($dec =~ /<font>/)  {
               output($u,$cmt,$udec,&decompose("<font>", $dec));
           } elsif($dec =~ /<square>/)  {
              # ignore <square>
              # warning($_);
           } elsif($dec =~ /<compat>/)  {
               output($u,$cmt,$udec,&decompose("<compat>", $dec));
           } elsif($dec =~ /<isolated>/)  {
              # ignore <isolated>
              # warning($_);
           } elsif($dec =~ /<medial>/)  {
              # ignore <medial>
              # warning($_);
           } elsif($dec =~ /<final>/)  {
              # ignore <final>
              # warning($_);
           } elsif($dec =~ /<initial>/)  {
              # ignore <initial>
              # warning($_);
           } elsif($dec =~ /<noBreak>/)  {
             if($dec eq "<noBreak> 0020")
             {
               output($u,$cmt,$udec,"\\u0020");
             } else {
              # ignore 
              # warning($_);
             }
           } else {
             warning($_);
           }
       } else {
         # decomposition without format code
         if($cmt =~ /LATIN/) {
           $dec = foldcombining($dec);
              output($u,$cmt,$udec,&decompose("", $dec));
         } elsif($cmt =~ /CYRILLIC/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /GREEK/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /ARABIC/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /CJK/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /HEBREW/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /DEVANAGARI/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /BENGALI/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /GURMUKHI/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /ORIYA/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /TAMIL/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /TELUGU/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /KANNADA/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /MALAYALAM/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /SINHALA/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /TIBETAN/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /MYANMAR/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /KATAKANA/) {
              # ignore 
              # warning($_);
         } elsif($cmt =~ /HIRAGANA/) {
              # ignore 
              # warning($_);
         } else {
              # ignore 
              # warning($_);
         }
       }
     } else {
       # do not have decomposition
       if ($d1 ne "") 
       {
         # are numeric characters
         output($u,$cmt,$udec,$d1);
       } elsif ($d2 ne "") {
         if($cmt =~ /CIRCLED/) {
           # circled
           output($u,$cmt,$udec,"(".$d2.")");
         } else {
           # others, use [ ]
           output($u,$cmt,$udec,"[".$d2."]");
         }
       } elsif ($d3 ne "") {
         if($cmt =~ /CIRCLED/) {
           # circled
           output($u,$cmt,$udec,"(".$d3.")");
         } else {
           # others, use [ ]
           output($u,$cmt,$udec,"[".$d3."]");
         }
       } else {
         # not numeric characters

       } # end of no decomposition
     } # end of have/not decomposition
   }
}
######################################################################
#
# Close files
#
######################################################################
close(UNIDATA);
close(OUT);

