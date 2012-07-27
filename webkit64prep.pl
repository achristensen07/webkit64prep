use strict; use warnings;

my $webkitdir="/WebKit";
my $thisdir="/webkit64prep";

chdir $webkitdir;
print "updating and installing wincairo headers\n";
system("svn update -r 123475");
system ("perl Tools/Scripts/update-webkit-auxiliary-libs");
system ("perl Tools/Scripts/update-webkit-wincairo-libs");

print "making changes\n";
replaceLines("$webkitdir/Source/WTF/wtf/FastMalloc.cpp",                               (2475,"  char pad_[(64 - (sizeof(TCMalloc_Central_FreeList) % 64)) % 64];","#ifndef _WIN64\n  char pad_[(64 - (sizeof(TCMalloc_Central_FreeList) % 64)) % 64];\n#endif"));
replaceLines("$webkitdir/WebKitLibraries/win/include/stdint.h",                        (57,"typedef int intptr_t;","",
                                                                                        58,"typedef unsigned uintptr_t;","#ifdef  _WIN64\ntypedef          __int64  intptr_t;\ntypedef unsigned __int64 uintptr_t;\n#else\ntypedef          int  intptr_t;\ntypedef unsigned int uintptr_t;\n#endif"));
replaceLines("$webkitdir/WebKitLibraries/win/include/CoreFoundation/CFBase.h",         (52,"#if (defined(__i386__) || defined(__x86_64__)) && !defined(__LITTLE_ENDIAN__)","#if defined(_MSC_VER) && defined(_M_AMD64)\n#define __x86_64__ 1\n#endif\n#if (defined(__i386__) || defined(__x86_64__)) && !defined(__LITTLE_ENDIAN__)"));
replaceLines("$webkitdir/WebKitLibraries/win/include/ConditionalMacros.h",             (1054,"    #elif defined(_M_IX86)  /* Visual Studio with Intel x86 target */","    #elif defined(_M_IX86) || defined(_M_AMD64)  /* Visual Studio with Intel x86 or x64 target */"));
replaceLines("$webkitdir/WebKitLibraries/win/tools/vsprops/common.vsprops",            (28,"\t\tAdditionalOptions=\"/SAFESEH /FIXED:NO /dynamicbase /ignore:4221\"","\t\tAdditionalOptions=\"/FIXED:NO /dynamicbase /ignore:4221\""));
replaceLines("$webkitdir/Source/WebCore/platform/cf/BinaryPropertyList.cpp",           (368,"    void appendByte(unsigned);","    void appendByte(size_t);",
                                                                                        398,"inline void BinaryPropertyListSerializer::appendByte(unsigned byte)","inline void BinaryPropertyListSerializer::appendByte(size_t byte)",
                                                                                        700,"            appendByte(asciiStringMarkerByte | length);","            appendByte((char)(asciiStringMarkerByte | length));",
                                                                                        709,"            appendByte(unicodeStringMarkerByte | length);","            appendByte((char)(unicodeStringMarkerByte | length));",
                                                                                        726,"        appendByte(asciiStringMarkerByte | length);","        appendByte((char)(asciiStringMarkerByte | length));"));
replaceLines("$webkitdir/Source/WebCore/platform/win/ClipboardUtilitiesWin.cpp",       (433,"    int maxSize = std::min(pathname.length(), WTF_ARRAY_LENGTH(fgd->fgd[0].cFileName));","    int maxSize = std::min<int>(pathname.length(), WTF_ARRAY_LENGTH(fgd->fgd[0].cFileName));"));
replaceLines("$webkitdir/Source/WebCore/platform/win/ClipboardWin.h",                  (273,"    int maxSize = min(fsPath.length(), WTF_ARRAY_LENGTH(fgd->fgd[0].cFileName));","    int maxSize = min<int>(fsPath.length(), WTF_ARRAY_LENGTH(fgd->fgd[0].cFileName));",
                                                                                        723,"    unsigned maxSize = min(fsPath.length(), WTF_ARRAY_LENGTH(fgd->fgd[0].cFileName));","    unsigned maxSize = min<unsigned>(fsPath.length(), WTF_ARRAY_LENGTH(fgd->fgd[0].cFileName));"));
replaceLines("$webkitdir/Source/WebCore/platform/win/ClipboardWin.cpp",                (273,"    int maxSize = min(fsPath.length(), WTF_ARRAY_LENGTH(fgd->fgd[0].cFileName));","    int maxSize = min<size_t>(fsPath.length(), WTF_ARRAY_LENGTH(fgd->fgd[0].cFileName));",
																						723,"    unsigned maxSize = min(fsPath.length(), WTF_ARRAY_LENGTH(fgd->fgd[0].cFileName));","    unsigned maxSize = min<size_t>(fsPath.length(), WTF_ARRAY_LENGTH(fgd->fgd[0].cFileName));"));
replaceLines("$webkitdir/Source/WebCore/platform/win/ClipboardUtilitiesWin.cpp",       (273,"    int maxSize = std::min<size_t>(pathname.length(), WTF_ARRAY_LENGTH(fgd->fgd[0].cFileName));","    int maxSize = std::min<size_t>(pathname.length(), WTF_ARRAY_LENGTH(fgd->fgd[0].cFileName));"));
replaceLines("$webkitdir/Source/WebCore/platform/PlatformMouseEvent.h",                (46,"typedef unsigned WPARAM;","",
                                                                                        47,"typedef long LPARAM;","#if defined(_WIN64)\ntypedef unsigned __int64 WPARAM;\ntypedef __int64 LPARAM;\n#else\ntypedef unsigned WPARAM;\ntypedef long LPARAM;\n#endif"));
replaceLines("$webkitdir/Source/WebCore/platform/PlatformWheelEvent.h",                (42,"typedef unsigned WPARAM;","",
                                                                                        43,"typedef long LPARAM;","#if defined(_WIN64)\ntypedef unsigned __int64 WPARAM;\ntypedef __int64 LPARAM;\n#else\ntypedef unsigned WPARAM;\ntypedef long LPARAM;\n#endif"));
replaceLines("$webkitdir/Source/WebCore/platform/PlatformKeyboardEvent.h",             (40,"typedef unsigned WPARAM;","",
                                                                                        41,"typedef long LPARAM;","#if defined(_WIN64)\ntypedef unsigned __int64 WPARAM;\ntypedef __int64 LPARAM;\n#else\ntypedef unsigned WPARAM;\ntypedef long LPARAM;\n#endif"));
replaceLines("$webkitdir/Source/WebCore/platform/MediaPlayerPrivateFullscreenWindow.h",(35,"typedef unsigned WPARAM;","",
                                                                                        36,"typedef long LPARAM;","#if defined(_WIN64)\ntypedef unsigned __int64 WPARAM;\ntypedef __int64 LPARAM;\n#else\ntypedef unsigned WPARAM;\ntypedef long LPARAM;\n#endif"));
replaceLines("$webkitdir/Source/WebCore/platform/WindowMessageListener.h",             (35,"typedef unsigned WPARAM;","",
                                                                                        33,"typedef long LPARAM;","#if defined(_WIN64)\ntypedef unsigned __int64 WPARAM;\ntypedef __int64 LPARAM;\n#else\ntypedef unsigned WPARAM;\ntypedef long LPARAM;\n#endif"));
replaceLines("$webkitdir/Source/WebKit2/win/WebKit2CFLite.def",                        (262,'	??1ContextDestructionObserver@WebCore@@MAE@XZ','        ??1ContextDestructionObserver@WebCore@@MEAA@XZ'));
replaceLines("$webkitdir/Tools/WinLauncher/WinLauncher.cpp",                           (231,"    DefWebKitProc = reinterpret_cast<WNDPROC>(::GetWindowLongPtr(hMainWnd, GWL_WNDPROC));","    DefWebKitProc = reinterpret_cast<WNDPROC>(::GetWindowLongPtr(hMainWnd, GWLP_WNDPROC));",
																						232,"    ::SetWindowLongPtr(hMainWnd, GWL_WNDPROC, reinterpret_cast<LONG_PTR>(WndProc));","    ::SetWindowLongPtr(hMainWnd, GWLP_WNDPROC, reinterpret_cast<LONG_PTR>(WndProc));",
																						317,"    DefEditProc = reinterpret_cast<WNDPROC>(GetWindowLongPtr(hURLBarWnd, GWL_WNDPROC));","    DefEditProc = reinterpret_cast<WNDPROC>(GetWindowLongPtr(hURLBarWnd, GWLP_WNDPROC));",
																						318,"    SetWindowLongPtr(hURLBarWnd, GWL_WNDPROC, reinterpret_cast<LONG_PTR>(MyEditProc));","    SetWindowLongPtr(hURLBarWnd, GWLP_WNDPROC, reinterpret_cast<LONG_PTR>(MyEditProc));"));
replaceLines("$webkitdir/Source/WebCore/platform/win/WindowMessageListener.h",         (33,"typedef long LPARAM;","",
																						35,"typedef unsigned WPARAM;","#ifdef  _WIN64\ntypedef          __int64  intptr_t;\ntypedef unsigned __int64 uintptr_t;\n#else\ntypedef          int  intptr_t;\ntypedef unsigned int uintptr_t;\n#endif"));
replaceLines("$webkitdir/Source/WebCore/platform/win/ClipboardWin.cpp",                (723,"    unsigned maxSize = min(fsPath.length(), WTF_ARRAY_LENGTH(fgd->fgd[0].cFileName));","    unsigned maxSize = min<size_t>(fsPath.length(), WTF_ARRAY_LENGTH(fgd->fgd[0].cFileName));"));
replaceLines("$webkitdir/Tools/win/DLLLauncher/DLLLauncherMain.cpp",                   (187,'    const char* entryPointName = "_dllLauncherEntryPoint@8";','#ifdef _M_AMD64\n    const char* entryPointName = "dllLauncherEntryPoint";\n#else\n    const char* entryPointName = "_dllLauncherEntryPoint@8";\n#endif',
																						190,'    const char* entryPointName = "_dllLauncherEntryPoint@16";','#ifdef _M_AMD64\n    const char* entryPointName = "dllLauncherEntryPoint";\n#else\n    const char* entryPointName = "_dllLauncherEntryPoint@16";\n#endif'));

#move new solutions
print "moving new solutions and libraries\n";
my $fromdir="$thisdir/webkit_replace";
system("cp $fromdir/JavaScriptCore.vcproj              $webkitdir/Source/JavaScriptCore/JavaScriptCore.vcproj/JavaScriptCore/JavaScriptCore.vcproj"         );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/JavaScriptCoreGenerated.vcproj     $webkitdir/Source/JavaScriptCore/JavaScriptCore.vcproj/JavaScriptCore/JavaScriptCoreGenerated.vcproj");#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/jsc.vcproj                         $webkitdir/Source/JavaScriptCore/JavaScriptCore.vcproj/jsc/jsc.vcproj"                               );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/testapi.vcproj                     $webkitdir/Source/JavaScriptCore/JavaScriptCore.vcproj/testapi/testapi.vcproj"                       );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/testRegExp.vcproj                  $webkitdir/Source/JavaScriptCore/JavaScriptCore.vcproj/testRegExp/testRegExp.vcproj"                 );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/gtest-md.vcproj                    $webkitdir/Source/ThirdParty/gtest/msvc/gtest-md.vcproj"                                             );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/QTMovieWin.vcproj                  $webkitdir/Source/WebCore/WebCore.vcproj/QTMovieWin.vcproj"                                          );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/WebCore.vcproj                     $webkitdir/Source/WebCore/WebCore.vcproj/WebCore.vcproj"                                             );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory, added object dependency, change files a little
system("cp $fromdir/WebCoreGenerated.vcproj            $webkitdir/Source/WebCore/WebCore.vcproj/WebCoreGenerated.vcproj"                                    );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/WebCoreTestSupport.vcproj          $webkitdir/Source/WebCore/WebCore.vcproj/WebCoreTestSupport.vcproj"                                  );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/Interfaces.vcproj                  $webkitdir/Source/WebKit/win/WebKit.vcproj/Interfaces.vcproj"                                        );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/WebKit.vcproj                      $webkitdir/Source/WebKit/win/WebKit.vcproj/WebKit.vcproj"                                            );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/WebKitGUID.vcproj                  $webkitdir/Source/WebKit/win/WebKit.vcproj/WebKitGUID.vcproj"                                        );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/WebKit.sln                         $webkitdir/Source/WebKit/win/WebKit.vcproj/WebKit.sln"                                               );#added x64 projects
system("cp $fromdir/WebKit2.vcproj                     $webkitdir/Source/WebKit2/win/WebKit2.vcproj"                                                        );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/WebKit2Generated.vcproj            $webkitdir/Source/WebKit2/win/WebKit2Generated.vcproj"                                               );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/WebKit2WebProcess.vcproj           $webkitdir/Source/WebKit2/win/WebKit2WebProcess.vcproj"                                              );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/WTF.vcproj                         $webkitdir/Source/WTF/WTF.vcproj/WTF.vcproj"                                                         );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/WTFGenerated.vcproj                $webkitdir/Source/WTF/WTF.vcproj/WTFGenerated.vcproj"                                                );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/WinLauncherLauncher.vcproj         $webkitdir/Tools/WinLauncher/WinLauncherLauncher.vcproj"                                             );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/WinLauncher.vcproj                 $webkitdir/Tools/WinLauncher/WinLauncher.vcproj"                                                     );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/WebKitTestRunnerLauncher.vcproj    $webkitdir/Tools/WebKitTestRunner/win/WebKitTestRunnerLauncher.vcproj"                               );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/WebKitTestRunner.vcproj            $webkitdir/Tools/WebKitTestRunner/win/WebKitTestRunner.vcproj"                                       );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/WebKitLauncherWin.vcproj           $webkitdir/Tools/WebKitLauncherWin/WebKitLauncherWin.vcproj"                                         );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/TestWebKitAPIInjectedBundle.vcproj $webkitdir/Tools/TestWebKitAPI/win/TestWebKitAPIInjectedBundle.vcproj"                               );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/TestWebKitAPIGenerated.vcproj      $webkitdir/Tools/TestWebKitAPI/win/TestWebKitAPIGenerated.vcproj"                                    );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/TestWebKitAPI.vcproj               $webkitdir/Tools/TestWebKitAPI/win/TestWebKitAPI.vcproj"                                             );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/TestNetscapePlugin.vcproj          $webkitdir/Tools/DumpRenderTree/TestNetscapePlugIn/win/TestNetscapePlugin.vcproj"                    );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/record-memory-win.vcproj           $webkitdir/Tools/record-memory-win/record-memory-win.vcproj"                                         );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/MiniBrowserLauncher.vcproj         $webkitdir/Tools/MiniBrowser/MiniBrowserLauncher.vcproj"                                             );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/MiniBrowser.vcproj                 $webkitdir/Tools/MiniBrowser/MiniBrowser.vcproj"                                                     );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/InjectedBundleGenerated.vcproj     $webkitdir/Tools/WebKitTestRunner/win/InjectedBundleGenerated.vcproj"                                );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/InjectedBundle.vcproj              $webkitdir/Tools/WebKitTestRunner/win/InjectedBundle.vcproj"                                         );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/ImageDiffLauncher.vcproj           $webkitdir/Tools/DumpRenderTree/win/ImageDiffLauncher.vcproj"                                        );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/ImageDiff.vcproj                   $webkitdir/Tools/DumpRenderTree/win/ImageDiff.vcproj"                                                );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/DumpRenderTreeLauncher.vcproj      $webkitdir/Tools/DumpRenderTree/win/DumpRenderTreeLauncher.vcproj"                                   );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/DumpRenderTree.vcproj              $webkitdir/Tools/DumpRenderTree/win/DumpRenderTree.vcproj"                                           );#added x64 configuration, removed warning level and warnings as errors, added /MP, changed output directory
system("cp $fromdir/JavaScriptCore.def                 $webkitdir/Source/JavaScriptCore/JavaScriptCore.vcproj/JavaScriptCore/JavaScriptCore.def"            );#changed decorated names to x64 versions (a lot of work!)
system("cp $fromdir/WebKit2CFLite.def                  $webkitdir/Source/WebKit2/win/WebKit2CFLite.def"                                                     );#changed decorated names to x64 versions
system("cp $fromdir/PaintHooks.obj                     $webkitdir/Source/WebCore/plugins/win/PaintHooks.obj"                                                );#compiled assembly
system ("mkdir $webkitdir/WebKitBuild");

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
