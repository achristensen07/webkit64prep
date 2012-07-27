use strict; use warnings;

my $windowswincairorequirementsdir="C:\\cygwin\\WinCairoRequirements";
my $wincairorequirementsdir="/WinCairoRequirements";
my $thisdir="/webkit64prep";

#sqlite3 remove /SAFESEH
#zlib remove /MACHINE:I386, remove inffas32.asm, match686.asm, add inffasx8664.c, gvmat64.obj,inffasx64.obj, no whole program optimization
#libcurl define USE_OPENSSL
#solution no build 3 openssl projects (libs and dlls found online)
#add zdll.lib dependencies to libcurl, libxml2, cairo
#changed intermediate directories of everything

print "making changes\n";
replaceLines("$wincairorequirementsdir/src/libiconv/srclib/stdint.h",              (57,"typedef int intptr_t;","",
                                                                                    58,"typedef unsigned uintptr_t;","#ifdef  _WIN64\ntypedef          __int64  intptr_t;\ntypedef unsigned __int64 uintptr_t;\n#else\ntypedef          int  intptr_t;\ntypedef unsigned int uintptr_t;\n#endif"));
replaceLines("$wincairorequirementsdir/src/sqlite/includes/stdint.h",              (57,"typedef int intptr_t;","",
                                                                                    58,"typedef unsigned uintptr_t;","#ifdef  _WIN64\ntypedef          __int64  intptr_t;\ntypedef unsigned __int64 uintptr_t;\n#else\ntypedef          int  intptr_t;\ntypedef unsigned int uintptr_t;\n#endif"));
replaceLines("$wincairorequirementsdir/src/opencflite/include/c99/stdint.h",       (57,"typedef int intptr_t;","",
                                                                                    58,"typedef unsigned uintptr_t;","#ifdef  _WIN64\ntypedef          __int64  intptr_t;\ntypedef unsigned __int64 uintptr_t;\n#else\ntypedef          int  intptr_t;\ntypedef unsigned int uintptr_t;\n#endif"));
replaceLines("$wincairorequirementsdir/src/opencflite/CFBase.h",                   (52,"#if (defined(__i386__) || defined(__x86_64__)) && !defined(__LITTLE_ENDIAN__)","#if defined(_MSC_VER) && defined(_M_AMD64)\n#define __x86_64__ 1\n#endif\n#if (defined(__i386__) || defined(__x86_64__)) && !defined(__LITTLE_ENDIAN__)"));
replaceLines("$wincairorequirementsdir/src/opencflite/include/ConditionalMacros.h",(1054,"    #elif defined(_M_IX86)  /* Visual Studio with Intel x86 target */","    #elif defined(_M_IX86) || defined(_M_AMD64)  /* Visual Studio with Intel x86 or x64 target */"));
replaceLines("$wincairorequirementsdir/src/opencflite/objc4/runtime/objc-os.h",    (190,"    __declspec(noinline) prototype { __asm { } }","    __declspec(noinline) prototype { ; }"));
replaceLines("$wincairorequirementsdir/src/icu/source/common/cmemory.h",           (243,"    T &operator[](ptrdiff_t i) { return ptr[i]; }","    T &operator[](int i) { return ptr[i]; }"));
replaceLines("$wincairorequirementsdir/src/opencflite/CFBase.c",                   (992,"    __asm int 3;","__debugbreak();"));

print "copying files\n";
my $fromdir="$thisdir/wincairorequirements_replace";
system("mkdir $wincairorequirementsdir/Lib");
system("cp $fromdir/objc-msg-win32.m             $wincairorequirementsdir/src/opencflite/objc4/runtime/Messengers.subproj/objc-msg-win32.m" );#SKELETON JUST TO COMPILE
system("cp $fromdir/gvmat64.obj                  $wincairorequirementsdir/src/zlib/contrib/masmx64/gvmat64.obj"                             );#from http://www.winimage.com/zLibDll/zlib124_masm_obj.zip
system("cp $fromdir/inffasx64.obj                $wincairorequirementsdir/src/zlib/contrib/masmx64/inffasx64.obj"                           );#from http://www.winimage.com/zLibDll/zlib124_masm_obj.zip
system("cp $fromdir/libeay32.lib                 $wincairorequirementsdir/Lib/libeay32.lib"                                                 );#from http://code.google.com/p/openssl-for-windows/downloads/detail?name=openssl-0.9.8k_X64.zip
system("cp $fromdir/ssleay32.lib                 $wincairorequirementsdir/Lib/ssleay32.lib"                                                 );#from http://code.google.com/p/openssl-for-windows/downloads/detail?name=openssl-0.9.8k_X64.zip

system("cp $fromdir/cairo_vc8.vcproj             $wincairorequirementsdir/src/cairo/cairo/src/cairo_vc8.vcproj"                             );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory, added zdll.lib to linker input
system("cp $fromdir/cairotest.vcproj             $wincairorequirementsdir/src/cairo/cairo/test/cairotest/cairotest.vcproj"                  );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/pixman_vc8.vcproj            $wincairorequirementsdir/src/cairo/pixman/pixman/pixman_vc8.vcproj"                        );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/libcurl_vc8.vcproj           $wincairorequirementsdir/src/curl/lib/libcurl_vc8.vcproj"                                  );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory, defined USE_OPENSSL, added zdll.lib to linker input
system("cp $fromdir/curl_vc8.vcproj              $wincairorequirementsdir/src/curl/src/curl/curl_vc8.vcproj"                                );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/common_vc8.vcproj            $wincairorequirementsdir/src/icu/source/common/common_vc8.vcproj"                          );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/makedata_vc8.vcproj          $wincairorequirementsdir/src/icu/source/data/makedata_vc8.vcproj"                          );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/uconv_vc8.vcproj             $wincairorequirementsdir/src/icu/source/extra/uconv/uconv_vc8.vcproj"                      );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/i18n_vc8.vcproj              $wincairorequirementsdir/src/icu/source/i18n/i18n_vc8.vcproj"                              );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/io_vc8.vcproj                $wincairorequirementsdir/src/icu/source/io/io_vc8.vcproj"                                  );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/layout_vc8.vcproj            $wincairorequirementsdir/src/icu/source/layout/layout_vc8.vcproj"                          );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/layoutex_vc8.vcproj          $wincairorequirementsdir/src/icu/source/layoutex/layoutex_vc8.vcproj"                      );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/cal_vc8.vcproj               $wincairorequirementsdir/src/icu/source/samples/cal/cal_vc8.vcproj"                        );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/date_vc8.vcproj              $wincairorequirementsdir/src/icu/source/samples/date/date_vc8.vcproj"                      );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/stubdata_vc8.vcproj          $wincairorequirementsdir/src/icu/source/stubdata/stubdata_vc8.vcproj"                      );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/cintltst_vc8.vcproj          $wincairorequirementsdir/src/icu/source/test/cintltst/cintltst_vc8.vcproj"                 );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/intltest_vc8.vcproj          $wincairorequirementsdir/src/icu/source/test/intltest/intltest_vc8.vcproj"                 );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/iotest_vc8.vcproj            $wincairorequirementsdir/src/icu/source/test/iotest/iotest_vc8.vcproj"                     );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/letest_vc8.vcproj            $wincairorequirementsdir/src/icu/source/test/letest/letest_vc8.vcproj"                     );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/ctestfw_vc8.vcproj           $wincairorequirementsdir/src/icu/source/tools/ctestfw/ctestfw_vc8.vcproj"                  );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/genbrk_vc8.vcproj            $wincairorequirementsdir/src/icu/source/tools/genbrk/genbrk_vc8.vcproj"                    );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/genccode_vc8.vcproj          $wincairorequirementsdir/src/icu/source/tools/genccode/genccode_vc8.vcproj"                );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/gencfu_vc8.vcproj            $wincairorequirementsdir/src/icu/source/tools/gencfu/gencfu_vc8.vcproj"                    );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/gencmn_vc8.vcproj            $wincairorequirementsdir/src/icu/source/tools/gencmn/gencmn_vc8.vcproj"                    );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/gencnval_vc8.vcproj          $wincairorequirementsdir/src/icu/source/tools/gencnval/gencnval_vc8.vcproj"                );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/genctd_vc8.vcproj            $wincairorequirementsdir/src/icu/source/tools/genctd/genctd_vc8.vcproj"                    );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/gennorm_vc8.vcproj           $wincairorequirementsdir/src/icu/source/tools/gennorm2/gennorm_vc8.vcproj"                 );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/derb_vc8.vcproj              $wincairorequirementsdir/src/icu/source/tools/genrb/derb_vc8.vcproj"                       );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/genrb_vc8.vcproj             $wincairorequirementsdir/src/icu/source/tools/genrb/genrb_vc8.vcproj"                      );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/gensprep_vc8.vcproj          $wincairorequirementsdir/src/icu/source/tools/gensprep/gensprep_vc8.vcproj"                );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/gentest_vc8.vcproj           $wincairorequirementsdir/src/icu/source/tools/gentest/gentest_vc8.vcproj"                  );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/icuinfo_vc8.vcproj           $wincairorequirementsdir/src/icu/source/tools/icuinfo/icuinfo_vc8.vcproj"                  );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/testplug_vc8.vcproj          $wincairorequirementsdir/src/icu/source/tools/icuinfo/testplug_vc8.vcproj"                 );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/icupkg_vc8.vcproj            $wincairorequirementsdir/src/icu/source/tools/icupkg/icupkg_vc8.vcproj"                    );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/makeconv_vc8.vcproj          $wincairorequirementsdir/src/icu/source/tools/makeconv/makeconv_vc8.vcproj"                );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/pkgdata_vc8.vcproj           $wincairorequirementsdir/src/icu/source/tools/pkgdata/pkgdata_vc8.vcproj"                  );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/toolutil_vc8.vcproj          $wincairorequirementsdir/src/icu/source/tools/toolutil/toolutil_vc8.vcproj"                );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/jpeg_vs2005.vcproj           $wincairorequirementsdir/src/jpeg/jpeg_vs2005.vcproj"                                      );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/libcharset_vc8.vcproj        $wincairorequirementsdir/src/libiconv/libcharset/libcharset_vc8.vcproj"                    );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/libiconv_vc8.vcproj          $wincairorequirementsdir/src/libiconv/libiconv_vc8.vcproj"                                 );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/iconvexe_vc8.vcproj          $wincairorequirementsdir/src/libiconv/src/iconvexe_vc8.vcproj"                             );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/libicrt_vc8.vcproj           $wincairorequirementsdir/src/libiconv/srclib/libicrt_vc8.vcproj"                           );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/png_vc8.vcproj               $wincairorequirementsdir/src/libpng/png_vc8.vcproj"                                        );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/libxml2_vc8.vcproj           $wincairorequirementsdir/src/libxml2/win32/libxml2/libxml2_vc8.vcproj"                     );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory, added zdll.lib to linker input
system("cp $fromdir/xmllint_vc8.vcproj           $wincairorequirementsdir/src/libxml2/win32/xmllint/xmllint_vc8.vcproj"                     );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/libexslt_vc8.vcproj          $wincairorequirementsdir/src/libxslt/win32/libxslt/libexslt_vc8.vcproj"                    );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/libxslt_vc8.vcproj           $wincairorequirementsdir/src/libxslt/win32/libxslt//libxslt_vc8.vcproj"                    );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/xsltproc_vc8.vcproj          $wincairorequirementsdir/src/libxslt/win32/libxslt//xsltproc_vc8.vcproj"                   );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/make_distribution_vc8.vcproj $wincairorequirementsdir/src/make_distribution_vc8.vcproj"                                 );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/StringExample_vs2005.vcproj  $wincairorequirementsdir/src/opencflite/examples/StringExample/StringExample_vs2005.vcproj");#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/objc_vs2005.vcproj           $wincairorequirementsdir/src/opencflite/objc4/objc_vs2005.vcproj"                          );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/objcrt_vs2005.vcproj         $wincairorequirementsdir/src/opencflite/objc4/objcrt/objcrt_vs2005.vcproj"                 );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/CFLiteLib_vs2005.vcproj      $wincairorequirementsdir/src/opencflite/windows/CFLiteLib_vs2005.vcproj"                   );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/libeay32_vc8.vcproj          $wincairorequirementsdir/src/openssl/openssl/libeay32_vc8.vcproj"                          );#added x64 configuration (not built by solution)
system("cp $fromdir/openssl_exe_vc8.vcproj       $wincairorequirementsdir/src/openssl/openssl/openssl_exe_vc8.vcproj"                       );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/ssleay32_vc8.vcproj          $wincairorequirementsdir/src/openssl/openssl/ssleay32_vc8.vcproj"                          );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/pthread_vc8.vcproj           $wincairorequirementsdir/src/pthreads/pthread_vc8.vcproj"                                  );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/sqlite.vcproj                $wincairorequirementsdir/src/sqlite/sqlite_vc2005/sqlite.vcproj"                           );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory, removed /SAFESEH
system("cp $fromdir/sqlite_console.vcproj        $wincairorequirementsdir/src/sqlite/sqlite_vc2005/sqlite_console.vcproj"                   );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/testzlibdll.vcproj           $wincairorequirementsdir/src/zlib/contrib/vstudio/vc8/testzlibdll.vcproj"                  );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory
system("cp $fromdir/zlibvc.vcproj                $wincairorequirementsdir/src/zlib/contrib/vstudio/vc8/zlibvc.vcproj"                       );#added x64 configuration, changed intermediate directories, removed warning level, added /MP, changed output directory, removed /MACHINE:I386, removed inffas32.asm and match686.asm, added inffasx8664.c and gvmat64.obj and inffasx64.obj, no whole program optimization
system("cp $fromdir/WinCairo_vc8.sln             $wincairorequirementsdir/WinCairo_vc8.sln"                                                 );#added x64 projects, don't build any openssl projects (found already compiled versions online)

#replaces lines in a file
#example: replaceLines("file.txt",(12,"a","b",13,"c","d")); would change line 12 in file.txt from a to b and line 13 from c to d
sub replaceLines{
	my ($filename,@changes) = @_;
	if (-e "$filename.old"){
		print "$filename already edited\n";
	}
	else{
		print "editing $filename\n";
		open my $out, '>', $filename.".new" or die "error opening $filename.new";
		$ARGV[0]=$filename;
		while(<>){
			my $replaced=0;
			for(my $i=0;$i<=$#changes;$i+=3){
				my $linenum=$changes[$i];
				my $oldline=$changes[$i+1];
				my $newline=$changes[$i+2];
				if($.==$linenum){
					if($_ ne $oldline."\n" && $_ ne $oldline."\r\n"){die "error changing $filename line $linenum. expecting $oldline, found $_"}
					if($newline ne ""){print $out $newline."\n"};
					$replaced=1;
				}
			}
			if($replaced==0){print $out $_;}
		}
		close $out;
		rename $filename, $filename.".old";
		rename $filename.".new", $filename;
	}
}

