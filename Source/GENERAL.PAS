unit General;

INTERFACE

uses Windows, Messages, Globals, SysUtils, StdCtrls, Printers, Dialogs, Graphics,
     forms, Classes, ComCtrls, clipbrd, Menus, advstyleif,
     controls, AdvSmoothMessageDialog, IdHTTP, AdvCombo, System.UITypes, System.Types,
     AdvMetroDlgs, AdvMetroForm, AdvMetroTaskDialog, AdvMenus;

const StMaxFileLen  = 260;     dot : ansichar = '.';   comma : ansichar = ',';

Function InsertNL (s : string) : string;           //replaces § with newLine
Function MyMsgDlg (const msg : string; dlgType : tMsgDlgType; Buttons : tMsgDlgButtons;
                                                           HelpCtx: longint) : Integer;
//Various functions
Function IntToAnsiStr (x : integer; width: integer = 0) : Ansistring;
Function Int2StrF (L : longint; f : byte) : ShortString;
Function Int2StrF0 (L : longint; f : byte) : str20;
Function Real2Str (R : real; f1, f2 : byte) : string;
Function Str2Real (S : shortString; default : real) : real;         overload;
Function Str2Real (S : String; default : real) : real;              overload;
Function Str2Long (const S : shortString; default : longint) : longint;   overload;
Function Str2Long (const S : string; default : longint) : longint;  overload;
Function Str2Word (const S : string; var i : word) : boolean;
Function Max (i, j : integer) : integer;
Function Min (i, j : integer) : integer;
Function RMin (i, j : real) : real;
Function RMax (i, j : real) : real;
Function FInc (var i : integer) : integer;
Function FDec (var i : integer) : integer;
Function FIncB (var i : byte) : byte;
Procedure SetRect (var rct : tRect; l, t, r, b : integer);
Procedure ExchangeWord (var i, j : word);
Procedure ExchangeInt (var i, j : integer);
Procedure ExchangeReal (var i, j : real);
procedure ExchangeStructs (var I, J; Size : Integer);
Function BitIsSet (x, b : integer) : boolean;
Function SetClearBit (var x : integer; bitNo : integer; setBit : boolean) : integer;  Overload;
Function SetClearBit (var x : byte; bitNo : byte; setBit : boolean) : byte;     Overload;
Function SetClearBitW (var x : word; bitNo : integer; setBit : boolean) : integer;
Function IntInRange (check, low, high : integer) : integer;
Function RealInRange (check, low, high : real) : integer;
Function CopyRight (s : String; first : integer) : String;
Procedure WaitClockTicks (n : dword);
Function SysMilliTime : longint;
Function HalfColor (col : tColor) : tColor;
Function ExtractFileLine (fName : String; n : integer) : shortString;
Procedure CopyStr2Clip (s : String); overload;
Procedure CopyStr2Clip (s : AnsiString); overload;
Procedure CopyStr2Clip (s : ShortString); overload;
Function GetStrFromClip (var s : AnsiString) : integer; overload;
Function GetStrFromClip (var s : String) : integer; overload;
Function GetWStrFromClip (var s : String) : integer;
Function OverlapRange (x1, x2, y1, y2 : integer) : boolean;
Function CommaIsComma (display : boolean) : boolean;
Function DateStringToDate (st : String) : tDateTime;
Function HasNoOverlap (lo1, hi1, lo2, hi2 : integer) : boolean;
//sequence related functions
Procedure ClearSimpleMod (var smp : tSimpleMod);
Procedure InitModResType (var modRes : ModRes_Type);
Procedure InitGlAppfile (s : fNameType; n : integer);
Function Mr_peptide (const S : String; index : integer; trmMS : real) : real;
Function MrResidue (mode : integer; res : ansichar) : real;    Overload;
Function MrResidue (mode : integer; res : char) : real;        Overload;
Function Mr_Alt_Pep (const S : AnsiString;const Laa : aaType; index : integer; trmMS : real) : real;
Procedure CnvComposStr (compS : str20;var cp : atomArray);     Overload;
Procedure CnvComposStr (compS : string;var cp : atomArray);    Overload;
Procedure AtomArr2CompStr (cp : atomArray; var compS : string);
Procedure ComposStr2Mass (compS : shortString;var masses : massType);    Overload;
Procedure ComposStr2Mass (compS : string;var masses : massType);    Overload;
Procedure ComposStr2AveMono (compS : string;var ave, mo : real);
Function ComposStr2DefMS (compS : str20; mode : integer) : real;    //1=integer; 2=average 3=mono
Function SetGetAtomComp (res : ansichar; atom : str2;num : integer; setVal : boolean) : integer;
Function AtomMass (atom : string) : real;
Function IsotopeDist (comp: composition_array;var pepFreq : isotopeRec;
                                                          allAtoms : atomArray) : integer;
Function Residue3 (position : byte) : str3;
Function Residue4 (position : byte) : str4;
Function Seq2String (SQ : seq; first, last : integer) : AnsiString;   overload;
Function Seq2StringSt (SQ : seq; first, last : integer) : String;       overload;
Function String2Mass (s : AnsiString; mode : integer) : real;
Function CleanSeqString (SeqS : AnsiString) : AnsiString;
Function Str2SeqName (const s : string; from, limit : integer) : shortString;
Function InclBackslash (const S : string) : string;
Procedure PeptideCompos (s : String; var comp : composition_array);
Procedure AddCompStr2AtomArr (compS : string; var atoms : atomArray;mult : integer);
Procedure AtomCompPep (pep : AnsiString;terms : termResArray;
                         var comp : composition_array;var allAtoms : atomArray);
Function AtomCompStr (allAtoms : atomArray) : AnsiString;
Function FillFileCombo (const sName : fNameType;box : tComboBox;first : str12;select : integer) : integer;   overload;
Function FillFileCombo (const sName : fNameType;box : tAdvComboBox;first : str12;select : integer) : integer;   overload;
Function GetResMass (msType, residue : integer) : real;
Function ChSet2Str (chSet : upCharSet) : str20;
Procedure ResStr2Set (S : shortString;var resSet : upCharSet);   overload;
Procedure ResStr2Set (S : String;var resSet : upCharSet);        overload;
Procedure ResStr2Set (S : String;var resSet : upCharSet;mySet : string);        overload;
Function CopyFromPosS (s : AnsiString; ps : integer) : AnsiString;
function AddSum (first, num : longint) : longint;
Function AutoSizeForm (f : tFont; height : integer) : integer;
Function CysInfoStr (aaFile : aaType) : str40;
Function FillMenuFile (var m : tPopUpMenu; dir, filter : String; count : integer) : integer;
//keyboard functions
function CtrlDown : Boolean;
function ShiftDown : Boolean;
function AltDown : Boolean;
//various
procedure QuickSort (var List: array of Double; iLo, iHi: Integer);
Function Deconvolute (var spec : tSpecArray; count : integer; msDelta : real) : integer;
procedure OpenPopMenuPop (var menu : tAdvPopUpMenu; fltr : string; Clck : tNotifyEvent);

IMPLEMENTATION
uses io_unit, StrGeneral;
{-----------------------------------------------------------------------------}

Function InsertNL (s : string) : string;           //replaces § with newLine
var i : integer;
begin
  result := '';
  for i := 1 to Length (s) do
    if s [i] = '§' then
      result := result + #13#10
    else result := result + s [i];
end;
{============Dialog functions================================================}

//mtWarning, mtError, mtInformation, mtConfirmation, mtCustom,
//mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore, mbAll, mbNoToAll, mbYesToAll, mbHelp, mbClose
Function MyMsgDlg (const msg : string; dlgType : tMsgDlgType; Buttons : tMsgDlgButtons;
                                                           HelpCtx: longint) : Integer;
begin
  MessageDlg (msg, dlgType, buttons, helpCtx);
end;

{=============================================================================}

Function IntToAnsiStr (x : integer; width: integer = 0) : Ansistring;
begin
  Str (x : width, result);
end;

{-----------------------------------------------------------------------------}

Function Int2StrF (L : longint; f : byte) : ShortString;
begin
  Str (L : f, result);
end;

{-----------------------------------------------------------------------------}

Function Int2StrF0 (L : longint; f : byte) : str20;
var temp : str20;    i : integer;
begin
  Str (L : f, temp);
  for i := 1 to Length (temp) do
    if temp [i] = ' ' then temp [i] := '0';
  Int2StrF0 := temp;
end;

{-----------------------------------------------------------------------------}

Function Real2Str (R : real; f1, f2 : byte) : string;
var temp : string;
begin
  Str (R : f1 : f2, temp);
  Real2Str := temp;
end;

{-----------------------------------------------------------------------------}

Function Str2Real (S : shortString; default : real) : real;
var code, i: integer;   tst : real;
begin
  if (System.Pos (dot, s) = 0) and (System.Pos (comma, s) > 0) then
    for i := 1 to Length (s) do
      if s [i] = comma then
        s [i] := dot;
  Val (S, tst, code);
  if code = 0 then
    result := tst
  else result := default;
end;

{-----------------------------------------------------------------------------}

Function Str2Real (S : String; default : real) : real;
var code, i: integer;   tst : real;
begin
  if (System.Pos ('.', s) = 0) and (System.Pos (',', s) = 1) then
    for i := 1 to Length (s) do
      if s [i] = ',' then
        s [i] := '.';
  Val (S, tst, code);
  if code = 0 then
    result := tst
  else result := default;
end;

{-----------------------------------------------------------------------------}

Function Str2Long (const S : shortString; default : longint) : longint;
var code : integer;   tst : longint;       ss : shortString;
begin
  ss := TrimS (s);
  Val (ss, tst, code);
  if code = 0 then
    result := tst
  else result := default;
end;

{-----------------------------------------------------------------------------}

Function Str2Long (const S : string; default : longint) : longint;
var code : integer;   tst : longint;       ss : string;
begin
  ss := SysUtils.Trim (s);
  Val (ss, tst, code);
  if code = 0 then
    result := tst
  else result := default;
end;

{-----------------------------------------------------------------------------}

function Str2Word (const S : String; var I : Word) : Boolean;
var  ec : Integer;         {-Convert a string to a word.}
begin
  ec := Str2Long (S, 0);
  if (ec >= 0) and (ec < 65535) then
  begin
    i := ec;
    result := true;
  end else result := false;
end;

{-----------------------------------------------------------------------------}

Function Max (i, j : integer) : integer;
begin
  if i > j then result := i
  else result := j;
end;

{-----------------------------------------------------------------------------}

Function Min (i, j : integer) : integer;
begin
  if i < j then result := i
  else result := j;
end;

{-----------------------------------------------------------------------------}

Function RMin (i, j : real) : real;
begin
  if i < j then result := i
  else result := j;
end;

{-----------------------------------------------------------------------------}

Function RMax (i, j : real) : real;
begin
  if i > j then result := i
  else result := j;
end;

{-----------------------------------------------------------------------------}

Function FInc (var i : integer) : integer;
begin
  Inc (i);
  result := i;
end;

{-----------------------------------------------------------------------------}

Function FDec (var i : integer) : integer;
begin
  Dec (i);
  result := i;
end;

{-----------------------------------------------------------------------------}

Function FIncB (var i : byte) : byte;
begin
  Inc (i);
  result := i;
end;

{-----------------------------------------------------------------------------}

Procedure SetRect ( var rct : tRect; l, t, r, b : integer);
begin
  rct.left := l;
  rct.top := t;
  rct.right := r;
  rct.bottom := b;
end;

{-----------------------------------------------------------------------------}

Procedure ExchangeWord (var i, j : word);
var tmp : word;
begin
  tmp := i;
  i := j;
  j := tmp;
end;

{-----------------------------------------------------------------------------}

Procedure ExchangeInt (var i, j : integer);
var tmp : integer;
begin
  tmp := i;
  i := j;
  j := tmp;
end;

{-----------------------------------------------------------------------------}

Procedure ExchangeReal (var i, j : real);
var tmp : real;
begin
  tmp := i;
  i := j;
  j := tmp;
end;

{-----------------------------------------------------------------------------}

procedure ExchangeStructs (var I, J; Size : Integer);
var pTemp: TBytes;
begin
  if Size <= 0 then
    Exit;
  SetLength(pTemp, Size);
  Move(I, pTemp[0], Length(pTemp));
  Move(J, I, Length(pTemp));
  Move(pTemp[0], J, Length(pTemp));
end;

{-----------------------------------------------------------------------------}

Function BitIsSet (x, b : integer) : boolean;
begin
  result := false;
  if (b < 0) or (b > 15) then
    Exit;
  if x and (1 shl b) > 0 then
    result := true;
end;

{-----------------------------------------------------------------------------}

Function SetClearBit (var x : integer; bitNo : integer; setBit : boolean) : integer;
begin
  result := x;
  if (bitNo < bit0) or (bitNo >= bit32) then
    exit;
  if setBit then
    result := x or bitNo
  else result := x and not bitNo;
end;

{-----------------------------------------------------------------------------}

Function SetClearBit (var x : byte; bitNo : byte; setBit : boolean) : byte;
begin
  result := x;
  if (bitNo < bit0) or (bitNo >= bit32) then
    exit;
  if setBit then
    result := x or bitNo
  else result := x and not bitNo;
end;

{-----------------------------------------------------------------------------}

Function SetClearBitW (var x : word; bitNo : integer; setBit : boolean) : integer;
begin
  result := x;
  if (bitNo >= bit0) and (bitNo <= bit15) then
    if setBit then
      result := x or bitNo
    else result := x and not bitNo;
end;

{-----------------------------------------------------------------------------}

Function IntInRange (check, low, high : integer) : integer;
begin
  if check < low then result := -1               //too low
  else if check <= high then result := 0         //in range
  else result := 1;                              //too high
end;

{-----------------------------------------------------------------------------}

Function RealInRange (check, low, high : real) : integer;
begin
  if check < low then result := -1               //too low
  else if check <= high then result := 0         //in range
  else result := 1;                              //too high
end;

{-----------------------------------------------------------------------------}

Function CopyRight (s : String; first : integer) : String;
//copies from position first to end of string
begin
  if (First > Length(S)) or (First < 1) or (S = '') then
    Result := ''
  else Result := Copy (S, First, Length(S) - first + 1);
end;

{-----------------------------------------------------------------------------}

Procedure WaitClockTicks (n : dword);
var count : dword;
begin
  count := GetTickCount;
  repeat
    application.processMessages;
  until GetTickCount > count + n * 56;     {tick = 54.925 -> n + fraction of tick}
end;

{-----------------------------------------------------------------------------}

Function SysMilliTime : longint;
var SystemTime: TSystemTime;
begin
  GetLocalTime (SystemTime);
  with SystemTime do
    Result := wHour * 3600000 + wMinute * 60000 + wSecond * 1000 + wMilliSeconds;
end;

{-----------------------------------------------------------------------------}

Function HalfColor (col : tColor) : tColor;     //returns a darker hue of input
begin
  result := ((col and $FF0000) div 2) and $FF0000 +
            ((col and $FF00) div 2) and $FF00 + ((col and $FF) div 2) and $FF;
end;

{-----------------------------------------------------------------------------}

Procedure CopyStr2Clip (s : String); overload;
var  pc : pChar;                n : integer;
begin
  n := Length (s) * 2 + 100;
  GetMem (pc, n);
  StrPCopy (pc, s);
  ClipBoard.SetTextBuf (pc);
  FreeMem (pc, n);
end;

{-----------------------------------------------------------------------------}

Procedure CopyStr2Clip (s : AnsiString);
var  ws : string;
begin
  ws := s;
  CopyStr2Clip (ws);
end;

{-----------------------------------------------------------------------------}

Procedure CopyStr2Clip (s : ShortString);
var  pc : pChar;        ws : string;
begin
  GetMem (pc, 4000);
  ws := string (s);
  StrPCopy (pc, ws);
  ClipBoard.SetTextBuf (pc);
  FreeMem (pc, 4000);
end;

{-----------------------------------------------------------------------------}

Function GetStrFromClip (var s : AnsiString) : integer;
begin
  if ClipBoard.HasFormat (CF_TEXT) then
  begin
    s := AnsiString (ClipBoard.AsText);
    result := Length (s);
  end else result := 0;
end;

{-----------------------------------------------------------------------------}

Function GetStrFromClip (var s : String) : integer;
begin
  if ClipBoard.HasFormat (CF_TEXT) then
  begin
    s := ClipBoard.AsText;
    result := Length (s);
  end else result := 0;
end;

{-----------------------------------------------------------------------------}

Function GetWStrFromClip (var s : String) : integer;
begin
  if ClipBoard.HasFormat (CF_TEXT) then
  begin
    s := ClipBoard.AsText;
    result := Length (s);
  end else result := 0;
end;

{-----------------------------------------------------------------------------}

Function ExtractFileLine (fName : String; n : integer) : shortString;
var f : textFile;    i : integer;       s : shortString;
begin
  result := '';
  assignFile (f, fName);
  reset (f);
  i := 0;
try
  repeat
    ReadLn (f, s);
    Inc (i);
  until (i = n) or EOF (f);
finally
  if i = n then
    result := s;
  CloseFile (f);
end;
end;

{-----------------------------------------------------------------------------}

Function OverlapRange (x1, x2, y1, y2 : integer) : boolean;
begin
  if (x1 > y2) or (x2 < y1) then
    result := false
  else result := true;
end;

{-----------------------------------------------------------------------------}

Function CommaIsComma (display : boolean) : boolean;
var s : AnsiString;          r : real;
begin
  r := 1.00;
  s := AnsiString (Format ('%4.2f', [r]));
  if s [2] = ',' then
    result := true
  else result := false;
  if result and display then
    MyMsgDlg ('Your computer has been set up for using comma "," as decimal separator§' +
            'Please change this to "." in§' + 'Control Panel -> Regional and Language Options'+
            '§§Otherwise De Novo Sequecer will not funcion optimally', mtError, [mbOK], 0);
end;

{-----------------------------------------------------------------------------}

Function DateStringToDate (st : String) : tDateTime;
//dd/mm/yy -> datetime
var d, m, y : word;         i : integer;
begin
  result := 0;
  for i := 1 to Length (st) do
    if (not CharInSet (st [i], ['0'..'9', '/'])) or (WordCountL (st, '/') < 2)  then
      result := 0
    else
    begin
      d := Str2Long (ExtractWord (1, st, '/'), 0);
      m := Str2Long (ExtractWord (2, st, '/'), 0);
      y := Str2Long (ExtractWord (3, st, '/'), 0);
      if (y > 50) and (y < 100) then
        y := y + 1900
      else y := y + 2000;
      result := EncodeDate (y, m, d);
    end;
end;

{-----------------------------------------------------------------------------}

Function HasNoOverlap (lo1, hi1, lo2, hi2 : integer) : boolean;
//checks whether lo1, hi1 overlaps with lo2, hi2 (eg does two peptides 1 and 2 overlap
begin
  result := true;
  if (IntInRange (lo1, lo2, hi2) = 0)  or (IntInRange (hi1, lo2, hi2) = 0) or
      (IntInRange (lo2, lo1, hi1) = 0) or (IntInRange (hi2, lo1, hi1) = 0) then
    result := false;
end;

{=============================================================================}

Procedure ClearSimpleMod (var smp : tSimpleMod);
var i, j : integer;
begin
  for i := 1 to 10 do
    for j := 1 to 6 do
    begin
      smp [i, j].name := '';
      smp [i, j].formula := '';
      smp [i, j].ave := 0;
      smp [i, j].mono := 0;
      smp [i, j].modPos := 0;
    end;
end;


{-----------------------------------------------------------------------------}

Procedure InitModResType (var modRes : ModRes_Type);
begin
  modRes.name := '';
  modRes.compStr := '';
  FillChar (modRes, SizeOf (modRes), 0);
end;

{-----------------------------------------------------------------------------}

Procedure InitGlAppfile (s : fNameType; n : integer);
begin
  appFile := Default (file_record);
  appFile.filename := s;
  appFile.seq_chosen := n;
  appFile.fSize := GetFileSize (s);
end;


Function Mr_peptide (const S : String; index : integer; trmMS : real) : real;
{calculate the mass of the peptide in string S; trmMS = mass of terminals}
var  i : integer;              molweight : real;        //index = (2 ave)(3 mono)
begin
  molweight := 0.0;
  for i := 1 to Length (S) do
    if CharInSet (S [i], [#33..#255]) then
      molweight := molweight + aa.mass [index, aa.aaIndex [Ord (S [i])]];
  result := molweight + trmMS;;
end;

{-----------------------------------------------------------------------------}

Function MrResidue (mode : integer; res : ansichar) : real;
begin
  if res in [#33..#255] then
    result := aa.mass [mode, aa.aaIndex [Ord (res)]]
  else result := 0.0;
end;

{-----------------------------------------------------------------------------}

Function MrResidue (mode : integer; res : char) : real;
begin
  if AnsiChar (res) in [#33..#255] then
    result := aa.mass [mode, aa.aaIndex [Ord (res)]]
  else result := 0.0;
end;

{-----------------------------------------------------------------------------}

Function Mr_Alt_Pep (const S : AnsiString;const Laa : aaType; index : integer; trmMS : real) : real;
//calculate the mass of the peptide in string S; trmMS = mass of terminals
var  i : integer;              molweight : real;
begin
  molweight := 0.0;
  for i := 1 to Length (S) do
    if S [i] in [#33..#255] then
      molweight := molweight + Laa.mass [index, Laa.aaIndex [Ord (S [i])]];
  result := molweight + trmMS;;
end;

{-----------------------------------------------------------------------------}

Procedure CnvComposStr (compS : str20;var cp : atomArray);
var compS1, compS2 : Str20;    cpA, cpB : atomArray;    x : cardinal;

Procedure Convert (cpS : str20; var cpA : atomArray);
var i, j, x, k : integer;    s2, s3 : shortString;
begin
  FillChar (cpA, SizeOf (cpA), 0);
  i := 0;
  while i < Length (cpS) do
  begin
    s2 := '';
    while (cpS [i + 1] in [#65..#122]) do
    begin
      Inc (i);
      if (Length (s2) < 2) then
        s2 := s2 + cpS [i];
    end;
    s3 := '';
    while not (cpS [i + 1] in ['0'..'9']) and (i < Length (cpS)) do
      Inc (i);
    while (cpS [i + 1] in ['0'..'9']) and (i < Length (cpS)) do
    begin
      Inc (i);
      if (Length (s3) < 4) then
        s3 := s3 + cpS [i];
    end;
    while not (cpS [i + 1] in [#65..#122]) and (i < Length (cpS)) do Inc (i);
    x := Str2Long (s3, 0);
    j := 0;
    for k := 1 to maxAtom do
      if s2 = aa.atoms.abbr [k] then
        j := k;
    if j in [1..maxAtom] then
      cpA [j] := x;
  end;
end;

begin
  compS := TrimS (compS);
  compS1 := '';
  compS2 := '';
  if compS [1] = '-' then
  begin
    if StrChPosS (compS, '+', x) then
    begin
      compS2 := Copy (compS, 2, x - 1);                      {string to subtract}
      compS1 := Copy (compS, x + 1, Length (compS) - x);     {string to add}
    end else compS2 := Copy (comps, 2, Length (compS) - 1);
  end else
    if compS [1] = '+' then
      compS1 := Copy (compS, 2, Length (compS) - 1)
    else compS1 := compS;
  Convert (compS1, cpA);
  Convert (compS2, cpB);
  for x := 0 to maxAtom do
    cp [x] := cpA [x] - cpB [x];
end;

{-----------------------------------------------------------------------------}

Procedure CnvComposStr (compS : string;var cp : atomArray);
var compS1, compS2 : String;    cpA, cpB : atomArray;    x : cardinal;

Procedure Convert (cpS : string; var cpA : atomArray);
var i, j, x, k : integer;    s2, s3 : String;
begin
  FillChar (cpA, SizeOf (cpA), 0);
  i := 0;
  while i < Length (cpS) do
  begin
    s2 := '';
    while (i < Length (cpS)) and (CharInSet (cpS [i + 1], ['A'..'z'])) do
    begin
      Inc (i);
      if (Length (s2) < 2) then
        s2 := s2 + cpS [i];
    end;
    s3 := '';
    while (i < Length (cpS)) and not CharInSet (cpS [i + 1], ['0'..'9']) do
      Inc (i);
    while  (i < Length (cpS)) and CharInSet (cpS [i + 1], ['0'..'9']) do
    begin
      Inc (i);
      if (Length (s3) < 4) then
        s3 := s3 + cpS [i];
    end;
    while (i < Length (cpS)) and not CharInSet((cpS [i + 1]), ['A'..'z']) do Inc (i);
    x := Str2Long (s3, 0);
    j := 0;
    for k := 1 to maxAtom do
      if s2 = aa.atoms.abbr [k] then
        j := k;
    if j in [1..maxAtom] then
      cpA [j] := x;
  end;
end;

begin
  compS := Trim (compS);
  compS1 := '';
  compS2 := '';
  if compS <> '' then
    if compS [1] = '-' then
    begin
      if StrChPos (compS, '+', x) then
      begin
        compS2 := Copy (compS, 2, x - 1);                      //string to subtract
        compS1 := Copy (compS, x + 1, Length (compS) - integer (x));     //string to add
      end else compS2 := Copy (comps, 2, Length (compS) - 1);
    end else
      if compS [1] = '+' then
        compS1 := Copy (compS, 2, Length (compS) - 1)
      else compS1 := compS;
  Convert (compS1, cpA);
  Convert (compS2, cpB);
  for x := 0 to maxAtom do
    cp [x] := cpA [x] - cpB [x];
end;

{-----------------------------------------------------------------------------}

Procedure ComposStr2Mass (compS : shortString;var masses : massType);   {array 1..3 of real}
var cpA : atomArray;        j : integer;
begin
  CnvComposStr (compS, cpA);
  FillChar (masses, SizeOf (masses), 0);
  for j := 1 to maxAtom do
    if cpA [j] <> 0 then
    begin
      masses [2] := masses [2] + cpA [j] * aa.atoms.ave [j];
      masses [3] := masses [3] + cpA [j] * aa.atoms.mono [j];
    end;
  masses [1] := Round (masses [3]);
end;

{-----------------------------------------------------------------------------}

Procedure ComposStr2Mass (compS : String;var masses : massType);   {array 1..3 of real}
begin
  ComposStr2Mass (shortString (compS), masses);
end;

{-----------------------------------------------------------------------------}

Procedure ComposStr2AveMono (compS : string;var ave, mo : real);
var mass : massType;
begin
  ComposStr2Mass (compS, mass);
  ave := mass [2];
  mo := mass [3];
end;

{-----------------------------------------------------------------------------}

Function ComposStr2DefMS (compS : str20; mode : integer) : real;
var mass : massType;     //mass 1 =  integer; 2 ave   3  mono
begin
  ComposStr2Mass (compS, mass);
  if mode in [1..3] then
    result := mass [mode]
  else result := mass [3];           //monoisotopic
end;

{-----------------------------------------------------------------------------}

Procedure AtomArr2CompStr (cp : atomArray; var compS : string);
var i, n : integer;       s1, s2 : string;
begin
  s1 := '-';
  s2 := '';
  for i := 1 to atomTblMax do
  begin
    n := cp [i];
    if (n <> 0) and (aa.atoms.abbr [i] <> '') then
      begin
        if n < 0 then
          s1 := s1 + aa.atoms.abbr [i] + IntToStr (Abs (n))
        else s2 := s2 + aa.atoms.abbr [i] + IntToStr (n);
//        Amass := Amass + aa.atoms.ave [i] * n;
//        Mmass := Mmass + aa.atoms.Mono [i] * n;
      end;
  end;
  if s1 <> '-' then
    if s2 <> '' then
      compS := s1 + '+' + s2
    else compS := s1
  else compS := s2;
end;

{-----------------------------------------------------------------------------}

Function SetGetAtomComp (res : ansichar; atom : str2;num : integer; setVal : boolean) : integer;
var i, cysPos, index  : integer;
begin
  cysPos := aa.aaIndex [Ord (Res)];
  index := 0;
  result := -1;
  for i := 1 to maxAtom do
    if aa.atoms.abbr [i] = atom then
      index := i;
  if (cysPos in [1..maxAA]) and (index in [1..maxAtom]) then
  begin
    if setVal then                              {set 'num' value}
      Inc (aa.compos [cysPos, index], num);
    num := aa.compos [cysPos, index];      {get number of atoms of type 'atom'}
    result := num;
  end;
end;

{-----------------------------------------------------------------------------}

Function AtomMass (atom : string) : real;
begin
  result := 0;
  for var I := 1 to maxAtom do
    if String (aa.atoms.abbr [i]) = atom then
      result := aa.atoms.mono [i];
end;
{-----------------------------------------------------------------------------}

Function IsotopeDist (comp: composition_array;var pepFreq : isotopeRec;
                                                         allAtoms : atomArray) : integer;
var dist : atomDistArr;             freq, frAux, fr : isoTypeArr;
    i, i2, j, k, nMax, nMax2, mMax : integer;               {mw : real;}
begin
  result := -1;                                  //dist file not found
  if LoadAtomDist (dist) then
  begin
    result := 0;                                 //= OK
    pepFreq.MonoMS := 0.0;
    for i := 1 to maxAtom do               //count number of atoms
      if (dist [i].aa <> '') then
        for j := 1 to maxAtom do
          if dist [i].aa = aa.atoms.abbr [j] then
          begin
            dist [i].count := allAtoms [j];
            pepFreq.MonoMS := pepFreq.MonoMS + allAtoms [j] * aa.atoms.mono [j];
            AllAtoms [j] := 0;
          end;
    for i := 1 to maxAtom do
      if allAtoms [i] > 0 then
      begin
        pepFreq.MonoMS := pepFreq.MonoMS + allAtoms [i] * aa.atoms.mono [i];
        result := 1;                                 //hetero atom found
      end;
    FillChar (fr, SizeOf (fr), 0);
    FillChar (freq, SizeOf (freq), 0);
    freq [1] := 1.0;
    nMax := 1;
    mMax := 0;
    for k := 1 to maxAtom do
    begin
      for i := 1 to dist [k].aCount do
        fr [i] := dist [k].freq [i];
      for j := 1 to dist [k].count do
      begin
        frAux := freq;
        nMax2 := nMax;
        mMax := mMax + dist [k].nomMs + dist [k].aCount - 1;  //aNum := aCount
        nMax := nMax + dist [k].aCount - 1;
        for i := 1 to nMax do
          freq [i] := 0.0;
        for i2 := 1 to nMax2 do
          for i := 1 to dist [k].aCount do
            freq [i2 + i -1] := freq [i2 + i - 1] + frAux [i2] * fr [i];
      end;                  //freq contains the isotopic frequency distribution of
    end;                    //from mass "mMin"
    i := 1;
    pepFreq.isoMax := freq [i];                        //find largest isotope
    while freq [FInc (i)] > pepFreq.isoMax do
      pepFreq.isoMax := freq [i];
    pepFreq.isotopes := freq;
  end;
end;

{-----------------------------------------------------------------------------}

Function Residue3 (position : byte) : str3;
var x : byte;
begin
  x := aa.aaIndex [position];
  if x > 0 then
    result := aa.name3 [x]
  else result := 'Xxx';
end;


{-----------------------------------------------------------------------------}

Function Residue4 (position : byte) : str4;
begin
  result := Residue3 (position) + '-';
end;

{-----------------------------------------------------------------------------}

Function Seq2String (SQ : seq; first, last : integer) : AnsiString;
var i : integer;
begin
  result := '';
  for i := first to last do
    result := result + AnsiChar (SQ [i]);
end;

{-----------------------------------------------------------------------------}

Function Seq2StringSt (SQ : seq; first, last : integer) : String;        overload;
var i : integer;
begin
  result := '';
  first := Max (1, first);
  last := Min (last, max_seq_len);
  for i := first to last do
    result := result + Char (SQ [i]);
end;

{-----------------------------------------------------------------------------}

Function String2Mass (s : AnsiString; mode : integer) : real;
{calculates the molecular mass of sequence in string}   {index 1 : integer; 2 : average; 3 : mono}
var  i : integer;
begin
  result := 0.0;
  for i := 1 to Length (s) do
    if s [i] in ['A'..'Y'] then
      result := result + aa.mass [mode, aa.aaIndex [Ord (s [i])]];
end;

{-----------------------------------------------------------------------------}

Function CleanSeqString (SeqS : AnsiString) : AnsiString;
var i : integer;
begin
  Result := '';
  for i := 1 to Length (SeqS) do
    if CharInSet (SeqS [i], ['A'..'Y']) then
      result := result + SeqS [i];
end;

{-----------------------------------------------------------------------------}
Function Str2SeqName (const s : string; from, limit : integer) : shortString;
begin
  Result := ShortString (Copy (s, from, limit));
end;

{-----------------------------------------------------------------------------}

Function InclBackslash (const S : string) : string;
begin
  result := IncludeTrailingBackslash (s);
end;

{-----------------------------------------------------------------------------}

Procedure PeptideCompos (s : String; var comp : composition_array);
var  i : integer;
begin
  FillChar (comp, SizeOf (comp), 0);
  for i := 1 to Length (s) do
    if s [i] <> '-' then
      Inc (comp [aa1Hash [Ord (AnsiChar (s [i]))]]);
end;

{-----------------------------------------------------------------------------}

Procedure AddCompStr2AtomArr (compS : string; var atoms : atomArray;mult : integer);
var compN : atomArray;   i : integer;
begin
  CnvComposStr (compS, compN);
  for i := 1 to maxAtom do
    Inc (atoms [i], compN [i] * mult);
end;

{-----------------------------------------------------------------------------}

Procedure AtomCompPep (pep : AnsiString;terms : termResArray;
                         var comp : composition_array;var allAtoms : atomArray);
var i, j, res : integer;            compN, compC : atomArray;
begin
  FillChar (allAtoms, SizeOf (allAtoms), 0);
  PeptideCompos (pep, comp);
  CnvComposStr (terms [1].compStr, compN);
  CnvComposStr (terms [2].compStr, compC);
  for i := 1 to 20 do                     // add atoms from residue composition
  begin
    res := System.Pos (aa_array [i], aa.aastr1) - 1;
    for j := 1 to maxAtom do
      Inc (allAtoms [j], comp [i] * aa.compos [res][j]);
  end;
  for j := 1 to maxAtom do
    Inc (allAtoms [j], compN [j] + compC [j]);
end;

{-----------------------------------------------------------------------------}

Function AtomCompStr (allAtoms : atomArray) : AnsiString;
var i : integer;
begin
  result := '';
  with aa.atoms do
    for i := 1 to maxAtom do
      if allAtoms [i] > 0 then
        result := result + ' ' + abbr [i] + IntToAnsiStr (allAtoms [i]);
end;

{-----------------------------------------------------------------------------}

Function FillFileCombo (const sName : fNameType;box : tComboBox;first : str12;select : integer) : integer;
var mySearch : tSearchRec;         findResult : integer;
begin
  Box.Items.Clear;
  if first <> '' then
    Box.Items.Add (first);
  findResult := Findfirst (sName, faAnyFile, mySearch);
  try
    while findResult = 0 do
    begin
      Box.Items.Add (mySearch.name);
      findResult := FindNext (mySearch);
    end;
  finally
    SysUtils.FindClose (mySearch);
  end;
  box.ItemIndex := select;
  result := Ord (box.items.count = 0) * 4;
end;

{-----------------------------------------------------------------------------}

Function FillFileCombo (const sName : fNameType;box : tAdvComboBox;first : str12;select : integer) : integer;
var mySearch : tSearchRec;         findResult : integer;
begin
  Box.Items.Clear;
  if first <> '' then
    Box.Items.Add (first);
  findResult := Findfirst (sName, faAnyFile, mySearch);
  try
    while findResult = 0 do
    begin
      Box.Items.Add (mySearch.name);
      findResult := FindNext (mySearch);
    end;
  finally
    SysUtils.FindClose (mySearch);
  end;
  box.ItemIndex := select;
  result := Ord (box.items.count = 0) * 4;
end;

{-----------------------------------------------------------------------------}

Function GetResMass (msType, residue : integer) : real;
begin
  if (msType in [1..3]) and (residue in [33..255]) then
    result := aa.mass [msType, aa.aaIndex [residue]]
  else result := 0.0;
end;

{=============================================================================}

Function ChSet2Str (chSet : upCharSet) : str20;
var S : str40;           i : integer;
begin
  S :='';
  for i := 65 to 90 do
    if (AnsiChar (i) in chSet) and (Length (S) < 20) then
      S := S + AnsiChar (i);
  result := S;
end;

{-----------------------------------------------------------------------------}

Procedure ResStr2Set (S : ShortString;var resSet : tSysCharSet);
var i : integer;
begin
  resSet := [];
  if S = '' then
    resSet := aa1Set
  else for i := 1 to Length (S) do
    if (UpCase (S [i]) in aa1Set) then
      resSet := resSet + [UpCase (S [i])];
end;

{-----------------------------------------------------------------------------}

Procedure ResStr2Set (S : String;var resSet : tSysCharSet);
var i : integer;
begin
  resSet := [];
  if S = '' then
    resSet := aa1Set
  else for i := 1 to Length (S) do
    if CharInSet (UpCase (S [i]), aa1Set) then
      resSet := resSet + [UpCase (S [i])];
end;

{-----------------------------------------------------------------------------}

Procedure ResStr2Set (S : String;var resSet : upCharSet;mySet : string);
begin
  resSet := [];
  if S = '' then
    resSet := aa1Set
  else for var i := 1 to Length (S) do
    if Pos (UpCase (S [i]), mySet) > 0 then
      resSet := resSet + [UpCase (S [i])];
end;

{-----------------------------------------------------------------------------}

Function CopyFromPosS (s : AnsiString; ps : integer) : AnsiString;
begin
  if (s = '') or (ps < 1) then
    result := ''
  else result := Copy (s, ps, Length (s) - ps + 1);
end;

{-----------------------------------------------------------------------------}

Function AddSum (first, num : longint) : longint;
var i : integer;
begin
  result := first;
  if num >= 1 then
    for i := 1 to num do
      result := result + (first - i);
end;

{-----------------------------------------------------------------------------}

Function AutoSizeForm (f : tFont; height : integer) : integer;
{$ifndef win32} var h : longint; {$endif}
begin
{$ifdef win32}
  result := (height * f.PixelsPerInch) div 96;
{$else}
  h := height;
  h := (h * f.PixelsPerInch) div 96;
  result := h;
{$endif}
end;

{-----------------------------------------------------------------------------}

Function CysInfoStr (aaFile : aaType) : str40;
var ms : integer;
begin
  ms := Round (aaFile.mass [2, aaFile.aaIndex [Ord ('C')]]);
  case ms of
    102 : Result := 'Cys is oxidized (SS)';
    103 : Result := 'Cys is reduced (SH)';
    else Result := 'Cys is modified';
  end;
  result := result + ' - ' + IntToAnsiStr (ms) + ' Da.';
end;

{-----------------------------------------------------------------------------}
Function FillMenuFile (var m : tPopUpMenu; dir, filter : String; count : integer) : integer;
var SearchRec: TSearchRec;
begin
  result := 0;
  if FindFirst (dir  + '*.' + filter, faAnyFile, SearchRec) = 0 then
  begin
    m.Items [result].Caption := '&1  ' + (JustFileName (SearchRec.Name));
    While (FindNext (searchRec) = 0) and (result < (count - 1)) do
    begin
      Inc (result);
      m.Items [result].Caption := Format ('&%d  ',
                                  [result + 1]) + (JustFileName (SearchRec.Name));
    end;
    Inc (result);
  end;
  SysUtils.FindClose (SearchRec);
end;

{----Keyboard functions------------------------------------------------}
function CtrlDown : Boolean;
var State : TKeyboardState;
begin
  GetKeyboardState (State) ;
  Result := ((State [vk_Control] and 128) <> 0) ;
end;

function ShiftDown : Boolean;
var State : TKeyboardState;
begin
  GetKeyboardState (State) ;
  Result := ((State [vk_Shift] and 128) <> 0) ;
end;

function AltDown : Boolean;
var State : TKeyboardState;
begin
  GetKeyboardState (State) ;
  Result := ((State [vk_Menu] and 128) <> 0) ;
end;

{-----------------------------------------------------------------------------}
procedure QuickSort (var List: array of Double; iLo, iHi: Integer) ;
var Lo, Hi : integer;               T, Mid : Double;
begin
  Lo := iLo;
  Hi := iHi;
  Mid:= List [(Lo + Hi) div 2];
  repeat
    while List [Lo] < Mid do Inc (Lo) ;
    while List [Hi] > Mid do Dec (Hi) ;
    if Lo <= Hi then
    begin
      T := List [Lo];
      List [Lo] := List [Hi];
      List [Hi] := T;
      Inc (Lo);
      Dec(Hi);
    end;
  until Lo > Hi;
  if Hi > iLo then QuickSort (List, iLo, Hi);
  if Lo < iHi then QuickSort (List, Lo, iHi);
end;

{-----------------------------------------------------------------------------}

type tPeak = record
               intens : real;
               num : integer;
             end;
const isotope : array [1..4] of real = (1.00727647, 1.00727647 / 2, 1.00727647 / 3, 1.00727647 / 4);


Function Deconvolute (var spec : tSpecArray; count : integer; msDelta : real) : integer;
var my, baseMS, m : real;
    i, j, k, n, isoCount, charge, res, tempCount, deconCount : integer;
    Iso : array [1..5, 1..4] of tPeak;          //[isotope #, charge]
    combined : array [1..4] of real;
    tempSP : tSpecArray;                            tmpInt : real;
    deconPks : array [1..100] of integer;           tmpPk : tMSRec;

Function GetIntens (n : integer) : real;
begin             //combined intensity if both second and third isotope is present and 1 > 2
  result := 0.0;
  if (iso [1, n].num > 0) and (iso [2, n].num > 0) and (iso [1, n].Intens > iso [2, n].Intens) then
    result := iso [1, n].Intens + iso [2, n].Intens;
end;

Function LoopBack (ch, n : integer; var res : integer; yInt : real) : integer;
var i : integer;
begin
  res := 0;
  for i := 1 to 3 do                   //test three previous peaks
    if (n > i) and (Abs (baseMS - spec [n - i].ms - isotope [ch]) < msDelta) and
                                            (spec [n - i].int > (yInt * 0.4)) then
    begin
      res := n - i;
      yInt := spec [n - i].int;        //->look for the largest peak
    end;
  result := res;
end;

Function Decon (num : integer) : boolean;
var i : integer;
begin
  result := false;
  for i := 1 to DeconCount do
    if num = deconPks [i] then
      result := true;
end;

Function AddResetIntens (y : real; pkNum: integer) : real;
begin
  if (pkNum > 0) and (pkNum < maxSmallMS) then
  begin
    result := y + spec [pkNum].int;     //combine isotopes
    spec [pkNum].int := 0;              //reset spectrum peak
  end else result := 0;
end;

begin
  FillChar (deconPks, SizeOf (deconPks), 0);
  DeconCount := 0;
  repeat
    my := 0.1;                            //set to not zero  - peak intensity
    n := 0;
    for i := 1 to count do              //find largest peak
      if not Decon (i) and (spec [i].int > my) then
      begin
        my := spec [i].int;
        n := i;                         //largest peak = n
      end;
    Inc (deconCount);
    deconPks [deconCount] := n;
    if (n > 0) and (n < count) then
    begin
      baseMS := spec [n].ms;                //mass of highest peak
      FillChar (iso , SizeOf (iso), 0);
      isoCount := 0;
      while (n + isoCount < count) and (spec [n + isoCount].ms - baseMS < isotope [1] * 4.1) do
        Inc (isoCount);                 //number of potential isotopes
      if isoCount >= 2 then             //peaks found within isotope window - at least 2
        for k := 1 to 4 do              //isotope peak #
          for i := 1 to 4 do            //isotope charge
            for j := 1 to isoCount do   //test this peak
              if Abs (spec [n + j].ms - baseMS - isotope [i] * k) < msDelta then   //isotope found
                if spec [n + j].int > iso [k, i].Intens  then
                begin
                  iso [k, i].Intens := spec [n + j].int;
                  iso [k, i].num := n + j;
                end;
      for i := 1 to 4 do                    //calc isotope intensity for ch=1,2,3,4
        combined [i] := GetIntens (i);
      charge := 1;
      for i := 2 to 4 do                    //2 -> max charge
        if combined [charge] < combined [i] then
          charge := i;
      if combined [charge] > 1 then                    //isotope peaks found
      begin
        tmpInt := spec [n].int;
        spec [n].int := 0.0;                           //reset highest peak
        my := AddResetIntens (my, iso [1, charge].num);
        my := AddResetIntens (my, iso [2, charge].num);
        my := AddResetIntens (my, iso [3, charge].num);
        if iso [4, charge].intens > 0.1 then
          my := AddResetIntens (my, iso [4, charge].num);
        M := baseMS * charge;               //approximate mass
        if (M > 1400) and (LoopBack (charge, n, res, tmpInt) > 0) then    //loop back for isotopes
        begin
          n := res;                   //new base mass
          baseMS := spec [n].ms;
          tmpInt := spec [n].int;
          my := AddResetIntens (my , n);
          if LoopBack (charge, n, res, tmpInt) > 0 then     //loopback twice
          begin
            n := res;                 //new base mass
            baseMS := spec [n].ms;
            tmpInt := spec [n].int;
            my := AddResetIntens (my , n);
            if (M > 2800) and (LoopBack (charge, n, res, tmpInt) > 0) then    //loop back 3 times if ms > 2800
            begin
              n := res;                 //new base mass
              baseMS := spec [n].ms;
              my := AddResetIntens (my , n);
            end;
          end;
        end;
        spec [n].int := my;                                         //intensity
        spec [n].ms := (baseMS - isotope [1]) * charge + isotope [1];  //mass
        for i := 1 to deconCount - 1 do                        //has another charge state been found?
          if Abs (spec [n].ms - spec [deconPks [i]].ms) < msDelta then
          begin
            spec [deconPks [i]].int := spec [deconPks [i]].int + spec [n].int;
            spec [n].int := 0;
          end;
      end;
    end;
  until (n = 0) or (deconCount >= 50);
//sort spec
  FillChar (tempSp, SizeOf (tempSp), 0);
  tempCount := 0;
  for i := 1 to count do                             //transfer to temporary spectrum
    if spec [i].int > 0.1 then                       //only peaks w. intens. > 0
      tempSp [FInc (tempCount)] := spec [i];
  for i := 1 to tempCount - 1 do                     //do bubble sort
    for j := i + 1 to tempCount do
      if tempSp [i].ms > tempSp [j].ms then
      begin
        tmpPk := tempSp [i];
        tempSp [i] := tempSp [j];
        tempSp [j] := tmpPk;
      end;
  spec := tempSp;
  result := tempCount;
end;

{-----------------------------------------------------------------------------}

procedure OpenPopMenuPop (var menu : tAdvPopUpMenu; fltr : string; Clck : tNotifyEvent);
var rec : tSearchRec;         count : integer;         mItem : tMenuItem;
begin
  count := -1;
  if menu.Items.Count = 0 then                      //no menu present
    if FindFirst (systemDir + fltr, faAnyFile, rec) = 0 then
    begin
      repeat
        mItem := tMenuItem.Create (menu);
        mItem.Caption := JustFileName (rec.name);
        mItem.Tag := FInc (count);
        mItem.OnClick := clck;
        menu.Items.Add (mItem);
      until (FindNext (rec) <> 0) or (count >= 10);
      FindClose (rec);
    end;
end;

{-----------------------------------------------------------------------------}

end.
