"#VZh 2009-12-29 00:33
"First edition of gschem file format syntax highlighting

syn match   gschemErr "."
syn keyword gschemCommands contained v L G B V A T N U P C F
syn keyword gschemAttributes author comment description device documentation footprint graphical net netname numslots pinlabel pinnumber pinseq pintype refdes slot slotdef source symversion value model-name model
syn match   gschemAttrAssign "="

syn region gschemParenGroup matchgroup=gschemParen start="{" end="}" transparent fold
syn sync fromstart
set foldmethod=syntax

syn match   gschemY "-\=\d\+" contained
syn match   gschemX "-\=\d\+" contained skipwhite nextgroup=gschemY
syn match   gschemXY "-\=\d\+\s\=\-\=\d\+" contained skipwhite nextgroup=gschemXY contains=gschemX

"version (v):   type version fileformat_version
syn match   gschemvType "^v" contained skipwhite nextgroup=gschemvVersion contains=gschemCommands
syn match   gschemvVersion "\d\{8}" contained skipwhite nextgroup=gschemvFileformat_version
syn match   gschemvFileformat_version "\d\+$" contained
syn match   gschemv "^v\s\+\d\{8}\s\+\d\+$" transparent contains=gschemvType

"line (L):  type x1 y1 x2 y2 color width capstyle(0-2) dashstyle(0-4) dashlength(-1|\d) dashspace(-1|\d)
syn match   gschemLType "^L" contained skipwhite nextgroup=gschemLXY,gschemLFlags contains=gschemCommands
syn match   gschemLXY "\(-\=\d\+\s\+\)\{4}" contained skipwhite nextgroup=gschemLColor contains=gschemXY
syn match   gschemLColor "\([0-9]\|1[0-6]\)\s" contained skipwhite nextgroup=gschemLWidth
syn match   gschemLWidth "\d\+" contained skipwhite nextgroup=gschemLCapstyle
syn match   gschemLCapstyle "[0-2]" contained skipwhite nextgroup=gschemLDashstyle
syn match   gschemLDashstyle "[0-4]" contained skipwhite nextgroup=gschemLDashlength
syn match   gschemLDashlength "\(-1\|\d\+\)" contained skipwhite nextgroup=gschemLDashspace
syn match   gschemLDashspace "\(-1\|\d\+\)$" contained
syn match   gschemL "^L\s\+\(-\=\d\+\s\+\)\{4}\([0-9]\|1[0-6]\)\s\+\d\+\s\+[0-2]\s\+[0-4]\s\+\(-1\|\d\+\)\s\+\(-1\|\d\+\)$" transparent contains=gschemLType

"picture (G):   type x1 y1 width height angle mirrored(0-1) embedded(=0)
"   filename
"embedded picture (G):  type x1 y1 width height angle mirrored(0-1) embedded(=1)
"   filedata
"   .
"
"not embedded picture
syn match   gschemGNE "^G \(-\=\d\+\s\+\)\{4}\d\+\s\+[0-1]\s\+0\n.*$" transparent contains=gschemGType,gschemGNEFilename
"embedded picture
syn match   gschemGE "^G \(-\=\d\+\s\+\)\{4}\d\+\s\+[0-1]\s\+1\n.*$" transparent contains=gschemGType,gschemGEFilename
syn region  gschemGEFilename start="." end="^\.$" contained keepend contains=gschemGFiledata
syn region  gschemGFiledata start="\n" end="^\.$" contained keepend
syn match   gschemGNEFilename "^.\+$" contained
syn match   gschemGType "^G" contained skipwhite nextgroup=gschemGXY contains=gschemCommands
syn match   gschemGXY "\(-\=\d\+\s\+\)\{4}" contained skipwhite nextgroup=gschemGAngle contains=gschemXY
syn match   gschemGAngle "0\|90\|180\|270" contained skipwhite nextgroup=gschemGMirrored
syn match   gschemGMirrored "[0-1]" contained skipwhite nextgroup=gschemGNotEmbedded,gschemGEmbedded
syn match   gschemGNotEmbedded "0$" contained skipwhite
syn match   gschemGEmbedded "1$" contained skipwhite

"box (B):   type x y width height color width capstyle dashtype dashlength dashspace filltype fillwidth angle1 pitch1 angle2 pitch2
syn match   gschemBType "^B" contained skipwhite nextgroup=gschemBXY,gschemBFlags contains=gschemCommands
syn match   gschemBXY "\(-\=\d\+\s\+\)\{4}" contained skipwhite nextgroup=gschemBColor contains=gschemXY
syn match   gschemBColor "\([0-9]\|1[0-6]\)\s" contained skipwhite nextgroup=gschemBWidth
syn match   gschemBWidth "\d\+" contained skipwhite nextgroup=gschemBCapstyle
syn match   gschemBCapstyle "[0-2]" contained skipwhite nextgroup=gschemBDashstyle
syn match   gschemBDashstyle "[0-4]" contained skipwhite nextgroup=gschemBDashlength
syn match   gschemBDashlength "\(-1\|\d\+\)" contained skipwhite nextgroup=gschemBDashspace
syn match   gschemBDashspace "\(-1\|\d\+\)" contained skipwhite nextgroup=gschemBFilltype
syn match   gschemBFilltype "[0-4]" contained skipwhite nextgroup=gschemBFillwidth
syn match   gschemBFillwidth "\(-1\|\d\+\)" contained skipwhite nextgroup=gschemBAngle1
syn match   gschemBAngle1 "\(-1\|\d\+\)" contained skipwhite nextgroup=gschemBPitch1
syn match   gschemBPitch1 "\(-1\|\d\+\)" contained skipwhite nextgroup=gschemBAngle2
syn match   gschemBAngle2 "\(-1\|\d\+\)" contained skipwhite nextgroup=gschemBPitch2
syn match   gschemBPitch2 "\(-1\|\d\+\)$" contained
syn match   gschemB "^B\s\+\(-\=\d\+\s\+\)\{4}\([0-9]\|1[0-6]\)\s\+\d\+\s\+[0-2]\s\+[0-4]\(\s\+-1\|\s\+\d\+\)\{2}\s\+[0-4]\(\s\+-1\|\s\+\d\+\)\{5}$" transparent contains=gschemBType

"circle (V):    type x y radius color width capstyle dashtype dashlength dashspace filltype fillwidth angle1 pitch1 angle2 pitch2
syn match   gschemVType "^V" contained skipwhite nextgroup=gschemVXY,gschemVFlags contains=gschemCommands
syn match   gschemVXY "\(-\=\d\+\s\+\)\{2}" contained skipwhite nextgroup=gschemVRadius contains=gschemXY
syn match   gschemVRadius "\d\+" contained skipwhite nextgroup=gschemVColor
syn match   gschemVColor "\([0-9]\|1[0-6]\)\s" contained skipwhite nextgroup=gschemVWidth
syn match   gschemVWidth "\d\+" contained skipwhite nextgroup=gschemVCapstyle
syn match   gschemVCapstyle "[0-2]" contained skipwhite nextgroup=gschemVDashstyle
syn match   gschemVDashstyle "[0-4]" contained skipwhite nextgroup=gschemVDashlength
syn match   gschemVDashlength "\(-1\|\d\+\)" contained skipwhite nextgroup=gschemVDashspace
syn match   gschemVDashspace "\(-1\|\d\+\)" contained skipwhite nextgroup=gschemVFilltype
syn match   gschemVFilltype "[0-4]" contained skipwhite nextgroup=gschemVFillwidth
syn match   gschemVFillwidth "\(-1\|\d\+\)" contained skipwhite nextgroup=gschemVAngle1
syn match   gschemVAngle1 "\(-1\|\d\+\)" contained skipwhite nextgroup=gschemVPitch1
syn match   gschemVPitch1 "\(-1\|\d\+\)" contained skipwhite nextgroup=gschemVAngle2
syn match   gschemVAngle2 "\(-1\|\d\+\)" contained skipwhite nextgroup=gschemVPitch2
syn match   gschemVPitch2 "\(-1\|\d\+\)$" contained
syn match   gschemV "^V\s\+\(-\=\d\+\s\+\)\{3}\([0-9]\|1[0-6]\)\s\+\d\+\s\+[0-2]\s\+[0-4]\(\s\+-1\|\s\+\d\+\)\{2}\s\+[0-4]\(\s\+-1\|\s\+\d\+\)\{5}$" transparent contains=gschemVType

"arc (A):   type x y radius startangle sweepangle color width capstyle dashtype dashlength dashspace
syn match   gschemAType "^A" contained skipwhite nextgroup=gschemAXY,gschemAFlags contains=gschemCommands
syn match   gschemAXY "\(-\=\d\+\s\+\)\{2}" contained skipwhite nextgroup=gschemARadius contains=gschemXY
syn match   gschemARadius "\d\+" contained skipwhite nextgroup=gschemAStartangle
syn match   gschemAStartangle "\d\+" contained skipwhite nextgroup=gschemASweepangle
syn match   gschemASweepangle "\d\+" contained skipwhite nextgroup=gschemAColor
syn match   gschemAColor "\([0-9]\|1[0-6]\)\s" contained skipwhite nextgroup=gschemAWidth
syn match   gschemAWidth "\d\+" contained skipwhite nextgroup=gschemACapstyle
syn match   gschemACapstyle "[0-2]" contained skipwhite nextgroup=gschemADashstyle
syn match   gschemADashstyle "[0-4]" contained skipwhite nextgroup=gschemADashlength
syn match   gschemADashlength "\(-1\|\d\+\)" contained skipwhite nextgroup=gschemADashspace
syn match   gschemADashspace "\(-1\|\d\+\)$" contained skipwhite
syn match   gschemA "^A\s\+\(-\=\d\+\s\+\)\{5}\([0-9]\|1[0-6]\)\s\+\d\+\s\+[0-2]\s\+[0-4]\(\s\+-1\|\s\+\d\+\)\{2}$" transparent contains=gschemAType

"text (T):  type x y color size visibility show_name_value angle alignment num_lines
syn match   gschemTType "^T" contained skipwhite nextgroup=gschemTXY contains=gschemCommands
syn match   gschemTXY "\(-\=\d\+\s\+\)\{2}" contained skipwhite nextgroup=gschemTColor contains=gschemXY
syn match   gschemTColor "\([0-9]\|1[0-6]\)\s" contained skipwhite nextgroup=gschemTSize
syn match   gschemTSize "\([2-9]\|[1-9]\d\+\)\s" contained skipwhite nextgroup=gschemTVisibility
syn match   gschemTVisibility "[01]\s" contained skipwhite nextgroup=gschemTShow
syn match   gschemTShow "[012]\s" contained skipwhite nextgroup=gschemTAngle
syn match   gschemTAngle "0\|90\|180\|270" contained skipwhite nextgroup=gschemTAlignment
syn match   gschemTAlignment "[0-8]\s" contained skipwhite nextgroup=gschemTNumLines1,gschemTNumLines2,gschemTNumLines3,gschemTNumLines4,gschemTNumLines5,gschemTNumLines6,gschemTNumLines7,gschemTNumLines8,gschemTNumLines9
syn match   gschemTNumLines1 "1$" contained skipnl nextgroup=gschemTText1
syn match   gschemTNumLines2 "2$" contained skipnl nextgroup=gschemTText2
syn match   gschemTNumLines3 "3$" contained skipnl nextgroup=gschemTText3
syn match   gschemTNumLines4 "4$" contained skipnl nextgroup=gschemTText4
syn match   gschemTNumLines5 "5$" contained skipnl nextgroup=gschemTText5
syn match   gschemTNumLines6 "6$" contained skipnl nextgroup=gschemTText6
syn match   gschemTNumLines7 "7$" contained skipnl nextgroup=gschemTText7
syn match   gschemTNumLines8 "8$" contained skipnl nextgroup=gschemTText8
syn match   gschemTNumLines9 "9$" contained skipnl nextgroup=gschemTText9
syn match   gschemTText9 "\(^.*$\n\)\{9}" contained contains=gschemAttributes,gschemAttrAssign
syn match   gschemTText8 "\(^.*$\n\)\{8}" contained contains=gschemAttributes,gschemAttrAssign
syn match   gschemTText7 "\(^.*$\n\)\{7}" contained contains=gschemAttributes,gschemAttrAssign
syn match   gschemTText6 "\(^.*$\n\)\{6}" contained contains=gschemAttributes,gschemAttrAssign
syn match   gschemTText5 "\(^.*$\n\)\{5}" contained contains=gschemAttributes,gschemAttrAssign
syn match   gschemTText4 "\(^.*$\n\)\{4}" contained contains=gschemAttributes,gschemAttrAssign
syn match   gschemTText3 "\(^.*$\n\)\{3}" contained contains=gschemAttributes,gschemAttrAssign
syn match   gschemTText2 "\(^.*$\n\)\{2}" contained contains=gschemAttributes,gschemAttrAssign
syn match   gschemTText1 "^.*$" contained contains=gschemAttributes,gschemAttrAssign
syn match   gschemT1 "^T\s\+\(-\=\d\+\s\+\)\{2}\([0-9]\|1[0-6]\)\s\+\([2-9]\|[1-9]\d\+\)\s\+[01]\s\+[012]\s\+\d\+\s\+[0-8]\s\+\d\+$\n^.*$" contains=gschemTType
syn match   gschemT2 "^T\s\+\(-\=\d\+\s\+\)\{2}\([0-9]\|1[0-6]\)\s\+\([2-9]\|[1-9]\d\+\)\s\+[01]\s\+[012]\s\+\d\+\s\+[0-8]\s\+\d\+$\(\n^.*$\)\{2}" contains=gschemTType
syn match   gschemT3 "^T\s\+\(-\=\d\+\s\+\)\{2}\([0-9]\|1[0-6]\)\s\+\([2-9]\|[1-9]\d\+\)\s\+[01]\s\+[012]\s\+\d\+\s\+[0-8]\s\+\d\+$\(\n^.*$\)\{3}" contains=gschemTType
syn match   gschemT4 "^T\s\+\(-\=\d\+\s\+\)\{2}\([0-9]\|1[0-6]\)\s\+\([2-9]\|[1-9]\d\+\)\s\+[01]\s\+[012]\s\+\d\+\s\+[0-8]\s\+\d\+$\(\n^.*$\)\{4}" contains=gschemTType
syn match   gschemT5 "^T\s\+\(-\=\d\+\s\+\)\{2}\([0-9]\|1[0-6]\)\s\+\([2-9]\|[1-9]\d\+\)\s\+[01]\s\+[012]\s\+\d\+\s\+[0-8]\s\+\d\+$\(\n^.*$\)\{5}" contains=gschemTType
syn match   gschemT6 "^T\s\+\(-\=\d\+\s\+\)\{2}\([0-9]\|1[0-6]\)\s\+\([2-9]\|[1-9]\d\+\)\s\+[01]\s\+[012]\s\+\d\+\s\+[0-8]\s\+\d\+$\(\n^.*$\)\{6}" contains=gschemTType
syn match   gschemT7 "^T\s\+\(-\=\d\+\s\+\)\{2}\([0-9]\|1[0-6]\)\s\+\([2-9]\|[1-9]\d\+\)\s\+[01]\s\+[012]\s\+\d\+\s\+[0-8]\s\+\d\+$\(\n^.*$\)\{7}" contains=gschemTType
syn match   gschemT8 "^T\s\+\(-\=\d\+\s\+\)\{2}\([0-9]\|1[0-6]\)\s\+\([2-9]\|[1-9]\d\+\)\s\+[01]\s\+[012]\s\+\d\+\s\+[0-8]\s\+\d\+$\(\n^.*$\)\{8}" contains=gschemTType
syn match   gschemT9 "^T\s\+\(-\=\d\+\s\+\)\{2}\([0-9]\|1[0-6]\)\s\+\([2-9]\|[1-9]\d\+\)\s\+[01]\s\+[012]\s\+\d\+\s\+[0-8]\s\+\d\+$\(\n^.*$\)\{9}" contains=gschemTType

"net (N):   type x1 y1 x2 y2 color
syn match   gschemNType "^N" contained skipwhite nextgroup=gschemNXY contains=gschemCommands
syn match   gschemNXY "\(-\=\d\+\s\+\)\{4}" contained skipwhite nextgroup=gschemNColor contains=gschemXY
syn match   gschemNColor "\([0-9]\|1[0-6]\)$" contained
syn match   gschemN "^N\s\+\(-\=\d\+\s\+\)\{4}\([0-9]\|1[0-6]\)$" contains=gschemNType

"bus (U):   type x1 y1 x2 y2 color ripperdir
syn match   gschemUType "^U" contained skipwhite nextgroup=gschemUXY contains=gschemCommands
syn match   gschemUXY "\(-\=\d\+\s\+\)\{4}" contained skipwhite nextgroup=gschemUColor contains=gschemXY
syn match   gschemUColor "\([0-9]\|1[0-6]\)\s" contained skipwhite nextgroup=gschemURipperdir
syn match   gschemURipperdir "\(0\|-\=1\)$" contained
syn match   gschemU "^U\s\+\(-\=\d\+\s\+\)\{4}\([0-9]\|1[0-6]\)\s\+\(0\|-\=1\)$" contains=gschemUType

"pin (P):   type x1 y1 x2 y2 color pintype whichend
syn match   gschemPType "^P" contained skipwhite nextgroup=gschemPXY contains=gschemCommands
syn match   gschemPXY "\(-\=\d\+\s\+\)\{4}" contained skipwhite nextgroup=gschemPColor contains=gschemXY
syn match   gschemPColor "\([0-9]\|1[0-6]\)\s" contained skipwhite nextgroup=gschemPPintype
syn match   gschemPPintype "[01]\s" contained skipwhite nextgroup=gschemPWhichend
syn match   gschemPWhichend "[01]$" contained
syn match   gschemP "^P\s\+\(-\=\d\+\s\+\)\{4}\([0-9]\|1[0-6]\)\(\s\+[01]\)\{2}$" contains=gschemPType

"component (C): type x y selectable angle mirror basename
"
"embedded component (C):    type x y selectable angle mirror EMBEDDEDbasename
"[
"...
"]
syn match   gschemCType "^C" contained skipwhite nextgroup=gschemCXY contains=gschemCommands
syn match   gschemCXY "\(-\=\d\+\s\+\)\{2}" contained skipwhite nextgroup=gschemCSelectable contains=gschemXY
syn match   gschemCSelectable "[01]\s" contained skipwhite nextgroup=gschemCAngle
syn match   gschemCAngle "0\|90\|180\|270" contained skipwhite nextgroup=gschemCMirror
syn match   gschemCMirror "[01]\s" contained skipwhite nextgroup=gschemCBasename,gschemCEmbedded
syn match   gschemCBasename "\S\+.sym$" contained skipnl nextgroup=gschemCParen
syn match   gschemCEmbedded "EMBEDDED" contained skipwhite nextgroup=gschemCBasename
syn match   gschemC "^C\s\+\(-\=\d\+\s\+\)\{2}[01]\s\+\d\+\s\+[01]\s\+\S\+.sym\(\n\[\_.*\]\)\=$" contains=gschemCType transparent
syn region gschemCParen matchgroup=gschemParen start="\[" end="\]" contained contains=TOP

"font (F):  type character width flag
syn match   gschemFType "^F" contained skipwhite nextgroup=gschemFCharacter contains=gschemCommands
syn match   gschemFCharacter "\S\s" contained skipwhite nextgroup=gschemFWidth
syn match   gschemFWidth "\d\+" contained skipwhite nextgroup=gschemFFlag
syn match   gschemFFlag "[01]\=$" contained
syn match   gschemF "^F\s\+\S\s\+\d\+\s*\(\s[01]\)\=$" contains=gschemFType

" clusters
syn cluster gschemColor contains=
      \ gschemLColor,
      \ gschemBColor,
      \ gschemVColor,
      \ gschemAColor,
      \ gschemTColor,
      \ gschemNColor,
      \ gschemUColor,
      \ gschemPColor

" colors
" FIXME
hi gschemColor guibg=#aabbcc

hi link gschemErr Error

hi link gschemAttributes    Special
hi link gschemAttrAssign    Delimiter

hi link gschemX Number
hi link gschemY Special
" FIXME
hi gschemXY     guibg=#F0F0F0

hi link gschemCommands      Identifier
hi link gschemParen         Delimiter
hi link gschemWidth         Number
hi link gschemNumber        Number
hi link gschemStyle         SpecialChar
hi link gschemLength        Float
" FIXME
"hi link gschemAngle        Special
hi gschemAngle              guifg=Orange
hi link gschemString        Label
hi link gschemCharacter     Character

hi link gschemvVersion      Constant
hi link gschemvFileformat_version       Number

hi link gschemLWidth        gschemWidth
hi link gschemBWidth        gschemWidth
hi link gschemVWidth        gschemWidth
hi link gschemAWidth        gschemWidth
hi link gschemFWidth        gschemWidth

hi link gschemLCapstyle     gschemStyle
hi link gschemBCapstyle     gschemStyle
hi link gschemVCapstyle     gschemStyle
hi link gschemACapstyle     gschemStyle

hi link gschemLDashstyle    gschemStyle
hi link gschemBDashstyle    gschemStyle
hi link gschemVDashstyle    gschemStyle
hi link gschemADashstyle    gschemStyle

hi link gschemLDashlength   gschemLength
hi link gschemBDashlength   gschemLength
hi link gschemVDashlength   gschemLength
hi link gschemADashlength   gschemLength

hi link gschemLDashspace    gschemLength
hi link gschemBDashspace    gschemLength
hi link gschemVDashspace    gschemLength
hi link gschemADashspace    gschemLength

hi link gschemGAngle        gschemAngle
hi link gschemBAngle1       gschemAngle
hi link gschemBAngle2       gschemAngle
hi link gschemVAngle1       gschemAngle
hi link gschemVAngle2       gschemAngle
hi link gschemAStartangle   gschemAngle
hi link gschemASweepangle   gschemAngle
hi link gschemTAngle        gschemAngle
hi link gschemCAngle        gschemAngle

hi link gschemGMirrored     gschemStyle
hi link gschemCMirror       gschemStyle

hi link gschemGNotEmbedded  gschemStyle
hi link gschemGEmbedded     gschemStyle

hi link gschemGNEFilename   gschemString
hi link gschemGEFilename    gschemString

hi link gschemGFiledata     gschemCharacter

hi link gschemBFilltype     gschemStyle
hi link gschemVFilltype     gschemStyle

hi link gschemBFillwidth    gschemWidth
hi link gschemVFillwidth    gschemWidth

hi link gschemBPitch1       gschemLength
hi link gschemBPitch2       gschemLength
hi link gschemVPitch1       gschemLength
hi link gschemVPitch2       gschemLength

hi link gschemVRadius       gschemLength
hi link gschemARadius       gschemLength


hi link gschemTSize         gschemLength
hi link gschemTVisibility   gschemStyle
hi link gschemTShow         gschemStyle
hi link gschemTAlignment    gschemStyle
hi link gschemTNumLines1    gschemNumber
hi link gschemTNumLines2    gschemNumber
hi link gschemTNumLines3    gschemNumber
hi link gschemTNumLines4    gschemNumber
hi link gschemTNumLines5    gschemNumber
hi link gschemTNumLines6    gschemNumber
hi link gschemTNumLines7    gschemNumber
hi link gschemTNumLines8    gschemNumber
hi link gschemTNumLines9    gschemNumber
hi link gschemTText1        gschemString
hi link gschemTText2        gschemString
hi link gschemTText3        gschemString
hi link gschemTText4        gschemString
hi link gschemTText5        gschemString
hi link gschemTText6        gschemString
hi link gschemTText7        gschemString
hi link gschemTText8        gschemString
hi link gschemTText9        gschemString

hi link gschemURipperdir    gschemStyle

hi link gschemPPintype      gschemStyle
hi link gschemPWhichend     gschemStyle

hi link gschemCSelectable   gschemStyle
hi link gschemCBasename     gschemString
hi link gschemCEmbedded     gschemStyle

hi link gschemFCharacter    gschemCharacter
hi link gschemFFlag         gschemStyle
