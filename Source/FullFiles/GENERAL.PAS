unit General;

//General routines for GPMAW v. 3.0 and later

INTERFACE

uses Windows, Messages, Globals, SysUtils, StdCtrls, Printers, Dialogs, Graphics,
     forms, Classes, ComCtrls, clipbrd, Menus, {StrGeneral, StrHlpr, }advstyleif,
     controls, AdvSmoothMessageDialog, IdHTTP, AdvCombo, System.UITypes, System.Types,
     AdvMetroDlgs, AdvMetroForm, AdvMetroTaskDialog, {MetroDlg,} AdvMenus;

type tParamsType = (pmBullBreese, pmMeekTime, pmGRAVYvalue, pmHydrofobicityEisenberg,
     pmHFBA_Solomon, pmTFA_Solomon, pmHPLC_Meek21, pmHPLC_Meek74,
     pmKyteDoolittleHydropathy, pmHoppWoodsHydrophilicity);
const paramsName : array [0..9] of string = ('Hydrophobicity Bull & Breese', 'HPLC index Meek',
       'Hydrophobicity Gravy', 'Hydrophobicity Eisenberg', 'HPLC HFBA Solomon',
       'HPLC TFA Solomon', 'HPLC Meek 2.1', 'HPLC Meek 7.4', 'Hydropathity Kyte & Doolittle',
       'Hydrophilicity Hopp & Woods');
const StMaxFileLen  = 260;     dot : ansichar = '.';   comma : ansichar = ',';
      bb_array : array [0..20] of integer = (0, 610, 890, 290, 420, 510, 970, -170,
       810, 610, -750, 360, -660, -1450, -1650, -1430, -1520, 460, 690, -1200, 690);

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
Procedure InitSeqRecord (var SQ : seq_record; pFR : pFile_record);
Procedure ClearSimpleMod (var smp : tSimpleMod);
Procedure InitModResType (var modRes : ModRes_Type);
Procedure CopySeqRec (source : seq_record; var dest : seq_record);
Procedure InitGlAppfile (s : fNameType; n : integer);
Function FastATitle (sq : seq_record) : string;
Function Mr_real (var SQ : seq_record; start, slut, index : integer) : real;
Function Mr_peptide (const S : String; index : integer; trmMS : real) : real;
Function MrResidue (mode : integer; res : ansichar) : real;    Overload;
Function MrResidue (mode : integer; res : char) : real;        Overload;
Function Mr_Alt_Pep (const S : AnsiString;const Laa : aaType; index : integer; trmMS : real) : real;
Function SeqCountRes (SQ : seq_record; start, slut, residue : integer) : integer;
Procedure CnvComposStr (compS : str20;var cp : atomArray);     Overload;
Procedure CnvComposStr (compS : string;var cp : atomArray);    Overload;
Procedure AtomArr2CompStr (cp : atomArray; var compS : string);
Procedure ComposStr2Mass (compS : shortString;var masses : massType);    Overload;
Procedure ComposStr2Mass (compS : string;var masses : massType);    Overload;
Procedure ComposStr2AveMono (compS : string;var ave, mo : real);
Function ComposStr2DefMS (compS : str20; mode : integer) : real;    //1=integer; 2=average 3=mono
Function SetGetAtomComp (res : ansichar; atom : str2;num : integer; setVal : boolean) : integer;
Function AtomMass (atom : string) : real;
//Function Bull_breeze (var SQ : seq_record; start, slut : integer) : longint;
Function IsoPoint (var SQ : seq_record; start, slut : integer; accur, xpKa : real;
                       xNum : byte; report : boolean; ssState, termModifs : byte) : real;  overload;
Function IsoPoint (var SQ : seq_record; start, slut : integer; accur, xpKa : real;
                         xNum : byte; report : boolean; ssState : byte) : real;            overload;
Function HPLC_time (var SQ : seq_record; start, slut : integer; mass : real;pep : ShortString) : real; overload;
Function HPLC_time (mass : real;pep : String) : real;            overload;
//Function MeekTime (var SQ : seq_record; start, slut : integer; mass : real;pep : ShortString) : longint;
//Function GRAVYvalue (var SQ : seq_record; start, slut : integer) : real;
Function PepParams (var SQ : seq_record; start, slut, mode: integer; pep : ShortString) : real;
Function IsotopeDist (comp: composition_array;var pepFreq : isotopeRec;
                                                          allAtoms : atomArray) : integer;
Function Peptide_charge (var SQ : seq_record; start, slut : integer; calcCys : boolean) : real;
Function ExtCoeff (const cp : composition_array; nm : integer; oxCys : boolean; mode : byte) : longint;
Function Ext214Coeff (const cp : composition_array) : integer;      overload;
Function Ext214Coeff (pepSQ : String) : integer;                overload;
Function Ext205Coeff (const cp : composition_array; oxCys : boolean) : integer; overload;
Function Ext205Coeff (pepSQ : String; oxCys : boolean) : integer;           overload;
Function PepString (SQ : pSeq_record; start, slut, resType : integer) : shortString;    overload;
Function PepLString (SQ : pSeq_record; start, slut, maxL : integer) : String;
Function AbbrevPepStr (SQ : pSeq_record; start, slut, resType, limit : integer; ins : str8) : shortString;
Function PepLimStr (SQ : pSeq_Record; first, last, rType, limit : integer; inst : str8) : AnsiString;
Function Residue3 (position : byte) : str3;
Function Residue4 (position : byte) : str4;
Function Res2Nam (pSeq : pSeq_record; num : integer) : string;
Function ResToNam (lSeq : Seq_record; num : integer) : str12;
Function ResidueString (pS : pSeq_record; res : word) : str12;
Function Seq2NumS (pS : pSeq_record; position, form : integer) : str10;
Function SqModResOK (pS : pSeq_record) : boolean;
Procedure RemoveSeqMod (var pSeq : pSeq_Record;loc : integer;var ssCount : integer);
Procedure RemoveSeqRes (var pSeq : pSeq_Record;first, last : integer);
Procedure String2Seq (var seq : seq_record; s : AnsiString);       overload;
Procedure String2Seq (var seq : seq_record; s : String);           overload;
Function Seq2String (SQ : seq; first, last : integer) : AnsiString;   overload;
Function Seq2StringSt (SQ : seq; first, last : integer) : String;       overload;
Function String2Mass (s : AnsiString; mode : integer) : real;
Function CleanSeqString (SeqS : AnsiString) : AnsiString;
Function FindPepInSeq (pSeq : pSeq_record;start : integer;pep : shortString;
                                            var pos1, pos2 : integer) : boolean;
Procedure SortModResList (var sequence : seq_record);
Procedure GetProtInfo (pSeq : pSeq_record;red : boolean;var protInfo : tProtInfo);
Function Str2SeqName (const s : string; from, limit : integer) : shortString;
Function InclBackslash (const S : string) : string;
//printer related functions
Procedure SetUpPrint (hdl : tHandle;var prRec : printer_record);
Procedure PrintLine (const s : AnsiString; linInc, offset : integer;
                                        var prRec : printer_record);   overload;
Procedure PrintLine (const s : String; linInc, offset : integer;
                                        var prRec : printer_record);   overload;
Procedure PrintLineF (const s : AnsiString; linInc, offset : integer;
                                   var prRec : printer_record;sty : tFontStyles);
Procedure PrintPageNum (var prRec : printer_record);
Procedure EndPrintPage (var prRec : printer_record);
Function PrintLineX (const s : AnsiString; linInc, offset, mode : integer;
                                          var prRec : printer_record) : integer;
Procedure PrintHeader (var prRec : printer_record; pSeq : pSeq_record; ti : str40);
Procedure PrintHLine (var prRec : printer_record);
Procedure SetPrintSize (var prRec : printer_record; size : integer);
//End printer functions
Procedure Composition (var seq : seq_record; var comp : composition_array; start, slut : integer);
Procedure PeptideCompos (s : String; var comp : composition_array);
Procedure AddCompStr2AtomArr (compS : string; var atoms : atomArray;mult : integer);
Procedure GetAtomComp (var seq : seq_record; comp : composition_array;
                       var atoms : atomArray; const first, last : integer);
Procedure CalcAtoms (pSeq : pSeq_record;var allAtoms : atomArray; var atomPct : aPctArray;
                         const compos : composition_array);
Procedure AtomCompPep (pep : AnsiString;terms : termResArray;
                         var comp : composition_array;var allAtoms : atomArray);
Function AtomCompStr (allAtoms : atomArray) : AnsiString;
Procedure MakeHilightList (var seq_rec : seq_record; ac : string; col, mode : byte);
Function FillFileCombo (const sName : fNameType;box : tComboBox;first : str12;select : integer) : integer;   overload;
Function FillFileCombo (const sName : fNameType;box : tAdvComboBox;first : str12;select : integer) : integer;   overload;
Function GetResMass (msType, residue : integer) : real;
Function IsCleaveDefOK (clStr : string) : boolean;
Function CheckCleaveDef (var OK : OK_typ; clStr : string) : integer;
Procedure CalcCleave (var clPos : integer; pSEQ : pSeq_record; clInput : string; modif : boolean);
Function ChSet2Str (chSet : upCharSet) : str20;
Procedure ResStr2Set (S : shortString;var resSet : upCharSet);   overload;
Procedure ResStr2Set (S : String;var resSet : upCharSet);        overload;
Procedure ResStr2Set (S : String;var resSet : upCharSet;mySet : string);        overload;
Function CopyFromPosS (s : AnsiString; ps : integer) : AnsiString;
function AddSum (first, num : longint) : longint;
Function Check4Res (pSeq : pSeq_record; first, last : integer; res : byte) : boolean;
Function AutoSizeForm (f : tFont; height : integer) : integer;
Function CysInfoStr (aaFile : aaType) : str40;
Procedure FillSearchLimitBox (data : tDigestSearchData;list : tStrings);
Function FillMenuFile (var m : tPopUpMenu; dir, filter : String; count : integer) : integer;
{----WEB related functions-------------------------------------------------------------------------}
Function InetConnected : boolean;
Function DelTag (s : ansiString; x : integer) : ansiString;
Function DelHTML (s : string) : string;
Function Skip2Line (line : AnsiString;strLst : tStringList; count : integer; reverse : boolean) : integer;
procedure ParseWebNCBI (var txt, seqDat : tStringList; single : boolean);
Function CountGenPept (const seqDat : tStringList) : integer;
procedure ParseWebSRS (var txt, seqDat : tStringList);
Procedure SetupProxy (var myProxy : TIdHTTP);
Procedure CheckRun (const S : string);
Function Color2RTF (col : tColor) : string;
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
            '§§Otherwise GPMAW will not function optimally', mtError, [mbOK], 0);
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

Procedure InitSeqRecord (var SQ : seq_record; pFR : pFile_record);
var i{, j} : integer;
begin
  if pFR <> nil then
  begin
    pFR^.filename := '';
    FillChar (pFR^, SizeOf (pFR^), 0);
  end;
  SQ.seqID := '';
//  for i := 1 to 10 do
//    for j := 1 to 6 do
//    begin
//      SQ.simple^ [i,j].Name := '';
//      SQ.simple^ [i,j].formula := '';
//      SQ.simple^ [i,j].modPos := 0;
//      SQ.simple^ [i,j].ave := 0;
//      SQ.simple^ [i,j].mono := 0;
//    end;
  FillChar (SQ.sequence, SizeOf (SQ.sequence), 0);
  FillChar (SQ.mode, SizeOf (SQ.mode), 0);
  FillChar (SQ.SSbridges, SizeOf (SQ.SSbridges), 0);
  FillChar (SQ.colRList, SizeOf (SQ.colRList), 0);
  FillChar (SQ.chainList, SizeOf (SQ.chainList), 0);
  FillChar (SQ.MultiLink, SizeOf (SQ.MultiLink), 0);
  for i := 1 to MaxModRes do
    with SQ.modified [i] do
    begin
      name := '';
      compStr := '';
      FillChar (mass, SizeOf (mass), 0);
      pKa := 0;
      pos := 0;
      charge := 0;
      terminal := 0;
    end;
  FillChar (SQ.cleaveList, SizeOf (SQ.cleaveList), 0);
  SQ.offset := 0;
  SQ.maxseq := 0;
  SQ.start := 1;
  SQ.numChains := 1;
  SQ.terminals [1] := aa.Nterm [0];
  SQ.terminals [2] := aa.Cterm [0];
  SQ.chainChr := 'abcdefgh';
  SQ.varMod := nil;                     //???????
end;

{-----------------------------------------------------------------------------}

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

Procedure CopySeqRec (source : seq_record; var dest : seq_record);
begin
  dest := source;
  new (dest.varMod);
  dest.varMod := nil;   //source.simple^;
end;

{-----------------------------------------------------------------------------}

Procedure InitGlAppfile (s : fNameType; n : integer);
begin
  appFile := Default (file_record);
  appFile.filename := s;
  appFile.seq_chosen := n;
  appFile.fSize := GetFileSize (s);
end;

{-----------------------------------------------------------------------------}

Function FastATitle (sq : seq_record) : string;
const sep : array [1..3] of char = (' ', '|', ';');
var n : integer;
begin
  result := '';
  if sq.maxSeq > 0 then
  begin
    n := Ord (glDef.advanced and bit14 = bit14)  + Ord (glDef.advanced and bit15 = bit15) * 2;
    if (n = 0) or (Length (sq.seqID) = 0) then
      result := '>' + sq.seqName + #13#10
    else result := '>' + sq.seqID + sep [n] + sq.seqName + #13#10;
  end;
end;

{-----------------------------------------------------------------------------}

Function Mr_real (var SQ : seq_record;  start, slut, index : integer) : real;
{calculates the molecular mass of sequence from 'start' to 'slut' - without water!}
{index  1 : integer;   2 : average;   3 : mono}

var  i, j : integer;              molweight, addMS : real;
begin
  molweight := 0.0;
  if (start <= 0) or (slut > SQ.maxseq) or (SQ.maxSeq <= 0) or (slut < start) or
     (SQ.maxseq > max_Seq_Len) then
  begin
    result := 0.0;
    Exit;
  end;
  if SQ.flags and 1 = 1 then                            //modified residues
    for i := start to slut do
    begin
      if SQ.sequence [i] in [33..255] then
        molweight := molweight + aa.mass [index, aa.aaIndex [SQ.sequence [i]]];
      if SQ.mode [i] and 16 = 16 then                   //modified
      begin
        j := 0;
        repeat
          Inc (j)
        until (SQ.modified [j].pos = i) or (j >= maxModRes);
        addMS := SQ.modified [j].mass [index];
        if (j <= maxModRes) then                       //modif in range
        begin
          molweight := molweight + addMS;
//subtract 'H' if reduces state and Cys is modified
          if (SQ.sequence [i] = Ord ('C')) and (glSSstate = 1) then
            molweight := molweight - HydrogenMS [index];
        end;
      end;
    end
  else for i := start to slut do
    if SQ.sequence [i] in [33..255] then
      molweight := molweight + aa.mass [index, aa.aaIndex [SQ.sequence [i]]];
  if start = 1 then                                 //use protein N-term index
    molweight := molweight + SQ.terminals [1].mass [index]
  else molweight := molweight + aa.Nterm [0].mass [index];   //use default
  if slut = SQ.maxSeq then                          //use protein C-term index
    molweight := molweight + SQ.terminals [2].mass [index]
  else molweight := molweight + aa.Cterm [0].mass [index];   //use default
  result := molweight;
end;

{-----------------------------------------------------------------------------}

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

Function SeqCountRes (SQ : seq_record; start, slut, residue : integer) : integer;
var i : integer;
begin
  result := 0;
  for i := 1 to SQ.maxSeq do
    if SQ.sequence [i] = residue then
      Inc (result);
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

Function IsoPoint (var SQ : seq_record; start, slut : integer; accur, xpKa : real;
                         xNum : byte; report : boolean; ssState : byte) : real;

begin
  result := IsoPoint (SQ, start, slut, accur, xpKa, xNum, report, ssState, 0);
end;

{-----------------------------------------------------------------------------}

Function IsoPoint (var SQ : seq_record; start, slut : integer; accur, xpKa : real;
                         xNum : byte; report : boolean; ssState, termModifs : byte) : real;
{ssState: 0 = SS; 1 : SH}             {aa1 = 'DNTSEQPGAVCMILYFKHWR';}
{mode: 1 - Skoog & Wichman, 1986; 2 - free aa1991; 3 - Rickard, Strohl & Nielsen, 1991}
//xNum = number of extra negative charges (phosphorylation)
const maxIteration = 200;
type  turn = array [1..maxIteration] of real;
var compos : composition_array;      N, modCount : integer;
    test_pH, ch : turn;              chargeError : boolean;
    factor, diff, sum : real;
    pKaMod : array [1..maxModRes] of real;
Procedure ChangepKa (bywhat : real);
var i : integer;
begin
  for i := 1 to 4 do
  begin
    pKa_Lys [i] := pKa_Lys [i] + byWhat;
    pKa_Arg [i] := pKa_Arg [i] + byWhat;
    pKa_Asp [i] := pKa_Asp [i] - byWhat;
    pKa_Glu [i] := pKa_Glu [i] - byWhat;
    pKa_His [i] := pKa_His [i] + byWhat;
  end;
end;

Function FindSingleCharge (mode : integer) : real;
begin
  result := 0;
  if (TermModifs and 1) <> 1 then
    result := pKaN_term [System.Pos (AnsiChar (SQ.sequence [start]), aa1)] [mode] + 3;
  if (TermModifs and 2) <> 2 then
    result := pKaC_term [System.Pos (AnsiChar (SQ.sequence [slut]), aa1)] [mode] - 3;
  if compos [1] > 0 then
    result := pKa_asp [mode] - 3;
  if compos [5] > 0 then
    result := pKa_glu [mode] - 3;
  if compos [17] > 0 then
    result := pKa_Lys [mode] + 3;
  if compos [18] > 0 then
    result := pKa_his [mode] + 3;
  if compos [20] > 0 then
    result := pKa_arg [mode] + 3;
end;

Function Charge (pK_value, pH : real; positive : boolean) : double;
var alpha : double;
begin
  result := 0.0;
  if Abs (pH - pK_Value) > 50 then
    chargeError := true
  else begin
    try
      alpha := exp (2.3026 * (pH - pK_value));
      if positive then
        result := 1 / (1 + alpha)
      else result := alpha / (1 + alpha);
    except
      on E:eOverflow do
      begin
        result := 0.0;
        chargeError := true;
      end;
    end;
  end;
end;

Procedure FindCharge (test, startVal : real; mode : integer);
var i, x : integer;
begin
  sum := startVal;
  if (TermModifs and 1) <> 1 then
    sum := sum + Charge (pKaN_term [System.Pos (AnsiChar (SQ.sequence [start]), aa1)] [mode], test, true);
  if (TermModifs and 2) <> 2 then
    sum := sum - Charge (pKaC_term [System.Pos (AnsiChar (SQ.sequence [slut]), aa1)] [mode], test, false);
  if mode = 4 then                              //user-defined pKa
    for i := 1 to 20 do
    begin
      x := System.Pos (aa1 [i], aa.aaStr1) - 1;          //aastr1 is 1-based; pKaVal [x] is 0-based
      if (compos [i] > 0) and (aa.pKaCharge [x] <> 0) then
        sum := sum + (compos [i] * Charge (aa.pKaVal [x], test, (aa.pKaCharge [x] > 0))
                * aa.pKaCharge [x]);
    end
  else begin
    sum := sum + compos [17] * Charge (pKa_lys [mode], test, true);
    sum := sum + compos [20] * Charge (pKa_arg [mode], test, true);
    sum := sum - compos [15] * Charge (pKa_tyr [mode], test, false);
    sum := sum + compos [18] * Charge (pKa_his [mode], test, true);
    sum := sum - compos [1] * Charge (pKa_asp [mode], test, false);
    sum := sum - compos [5] * Charge (pKa_glu [mode], test, false);
    if ssState > 0 then                                            //reduced cys
      sum := sum - compos [11] * Charge (pKa_cys [mode], test, false);
  end;
//look for internal terminals (e.g. multichain protein)
  if (SQ.numChains > 1) and (slut - start > 3) then
    for i := start + 1 to slut - 1 do
      if SQ.sequence [i] = Ord ('-') then
      begin
        sum := sum + Charge (pKaN_term [System.Pos (AnsiChar (SQ.sequence [i + 1]), aa1)] [mode], test, true);
        sum := sum - Charge (pKaC_term [System.Pos (AnsiChar (SQ.sequence [i - 1]), aa1)] [mode], test, false);
      end;
  if xNum > 0 then                                         //extra negative charges
    sum := sum - xNum * Charge (xpKa, test, false);
  if (modCount > 0) then                                     //modified charged residues
    for i := 1 to modCount do
      if pKaMod [i] > 0 then
        sum := sum + Charge (pKaMod [i], test, true)
      else sum := sum - Charge (pKaMod [i], test, false);
  ch [N] := sum;
end;

Procedure FindPI (start : double; mode : integer);
begin
  chargeError := false;
  N := 1;   test_pH [N] := 0.0;
  FindCharge (test_pH [N], start, mode);
  N := 2;   test_pH [N] := 14.0;
  FindCharge (test_pH [N], start, mode);
  repeat
    Inc (N);
    if ch [N - 1] <> ch [N - 2] then
      factor := (test_pH [N - 1] - test_pH [N - 2]) / (ch [N - 1] - ch [N - 2])
    else factor := 1;
    test_pH [N] := test_pH [N - 1] - (ch [N - 1] * factor);
    FindCharge (test_pH [N], start,mode);
    diff := abs (ch [N] - ch [N - 1]);
  until (diff <= accur) or (N >= maxIteration);
end;

var i, j, chCount : integer;
begin
  result := 0.0;
  if (start <= 0) or (slut <= 0) then
    Exit;
  if start = slut then           //i.e. single residue
    result := pIsingleAA [System.Pos (AnsiChar (SQ.sequence [slut]), aa1)]
  else
  begin
    Composition (SQ, compos, start, slut);
    chCount := Ord ((TermModifs and 1) <> 1) + Ord ((TermModifs and 2) <> 2);   //# of charged res.
    chCount := chCount + Compos [1] + Compos [5] + Compos [17] + Compos [18] + Compos [20];
    if chCount = 0 then
      Exit
    else if chCount = 1 then
      result := FindSingleCharge (glDef.advanced and 3)
    else
    begin
      modCount := 0;
      FillChar (pKaMod, SizeOf (pKaMod), 0);
      for i := start to slut do
        if (SQ.mode [i] and bit4) = bit4 then           //modified residue
          for j := 1 to maxModRes do
            if (SQ.modified [j].pos = i) and (Abs (SQ.modified [j].charge) = 1) then
              pKaMod [FInc (modCount)] := SQ.modified [j].pKa * SQ.modified [j].charge;
      FindPI (0.0, (glDef.advanced and 3) + 1);
      result := test_pH [N];
      if chargeError or (test_pH [N] < -2.0) then
      begin
        FindPI (-1.0, (glDef.advanced and 3) + 1);
        result := test_pH [N];
        if chargeError or (test_pH [N] < -2.0) then
        begin
          FindPI (-0.55, (glDef.advanced and 3) + 1);
          result := test_pH [N];
          if chargeError or (test_pH [N] < -2.0) then
          begin
            ChangepKa (0.1);
            FindPI (1.11, (glDef.advanced and 3) + 1);
            result := test_pH [N];
            if chargeError then
            begin
              if report then
                MyMsgDlg ('Error in pI calculation! §0.0 values are not defined', mtError, [mbOK], 0);
              result := 0.0;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{-----------------------------------------------------------------------------}

Function HPLC_time (var SQ : seq_record; start, slut : integer; mass : real;
                                                      pep : ShortString) : real;
//pep is only different from '' if specific peptide is tested
var  T, S, ka : real;         i : integer;
     seq_char : array [1..max_seq_len] of ansichar absolute SQ.sequence;

begin
  with glHPLCparam do
    if (slut - start) < 400 then
    begin
      ka := 0;
      if mass > 0 then
        S := P * ln (mass) - Q
      else begin
        result := 0.0;
        Exit;
      end;
      if (pep = '') then
      begin
        for i := start to slut do
          if SQ.sequence [i] in [65..90] then
            ka := ka + glHPLCret [System.Pos (seq_char [i], aa1)]
      end else
        for i := start to slut do
          if pep [i] in [#65..#90] then
            ka := ka + glHPLCret [System.Pos (pep [i], aa1)];
      ka := abs (ka);
      if ka > 0.01 then
        ka := exp (E * exp (ln (ka) * 2 / 3) + (G / ka) + F)
      else ka := 0;
      T :=  (ln (1 + b * S * (T0 * ka - DT))) / (b * S) + T0 + DT;
    end else
      T := 0;
  HPLC_time := T;
end;

{-----------------------------------------------------------------------------}

Function HPLC_time (mass : real; pep : String) : real;
//pep is only different from '' if specific peptide is tested
var  T, S, ka : real;         i : integer;

begin
  result := 0.0;
  with glHPLCparam do
    if (mass > 0) and (pep <> '') then
    begin
      ka := 0;
      S := P * ln (mass) - Q;
      for i := 1 to Length (pep) do
        if ansiChar (pep [i]) in [#65..#90] then
          ka := ka + glHPLCret [System.Pos (ansiChar (pep [i]), aa1)];
      ka := Abs (ka);
      if ka > 0.01 then
        ka := exp (E * exp (ln (ka) * 2 / 3) + (G / ka) + F)
      else ka := 0;
      T :=  (ln (1 + b * S * (T0 * ka - DT))) / (b * S) + T0 + DT;
      result := T;
    end;
end;

{-----------------------------------------------------------------------------}
//
//Function MeekTime (var SQ : seq_record; start, slut : integer; mass : real;
//                                                     pep : ShortString) : longint;
//const  meek : array [0..20] of longint = (390, -168, -96, 90, -222, -450, -150, 480,
//               -30, -6, 198, -132, 426, 708, 600, 492, 834, -192, 48, 1086, -270);
//var i : integer;       seq_char : array [1..max_seq_len] of ansichar absolute SQ;
//begin
//  result := -24 + 414;    //N-term + C-term
//  if pep = '' then
//    for i := start to slut do
//      result := result + meek [System.pos (seq_char [i], aa1)]
//  else for i := start to slut do
//      result := result + meek [System.pos (pep [i], aa1)]
//end;
//
//{-----------------------------------------------------------------------------}
//
//Function Bull_breeze (var SQ : seq_record; start, slut : integer) : longint;
//
//var  i : integer;      seq_char : array [1..max_seq_len] of ansichar absolute SQ;
//begin
//  result := 0;
//  for i := start to slut do
//    result := result + bb_array [System.Pos (seq_char [i], aa1)];   //should be /1000
//end;
//
//{-----------------------------------------------------------------------------}
//
//Function GRAVYvalue (var SQ : seq_record; start, slut : integer) : real;
//const gravy : array [0..20] of integer = (0, -35, -35, -7, -8, -35, -35,
//                      -16, -4, 18, 42, 25, 19, 45, 38, -13, 28, -39, -32, -9, -45);
//var i, n : integer;    seq_char : array [1..max_seq_len] of ansichar absolute SQ;
//begin
//  n := 0;                                     //'DNTSEQPGAVCMILYFKHWR'
//  for i := start to slut do
//    n := n + gravy [System.pos (seq_char [i], aa1)];
//  result := (n / 10) / (slut - start + 1);
//end;
//
//{-----------------------------------------------------------------------------}
//
//Function HydrofobicityEisenberg (var SQ : seq_record; start, slut : integer;
//                                                     pep : ShortString) : real;
//const Eisen : array [0..20] of real = (0, -0.9, -0.78, -0.05, 0.12, -0.74, -0.85, 0.12,
//        0.48, 0.62, 1.08, 0.29, 0.64, 1.38, 1.06, 0.26, 1.19, -1.5, -0.4, 0.81, -2.53);
//var i : integer;    seq_char : array [1..max_seq_len] of ansichar absolute SQ;
//begin
//  result := 0;
//  if pep = '' then                                  //'DNTSEQPGAVCMILYFKHWR'
//    for i := start to slut do
//      result := result + eisen [System.pos (seq_char [i], aa1)]
//    else for i := start to slut do
//      result := result + eisen [System.pos (pep [i], aa1)];
//end;
//
//{-----------------------------------------------------------------------------}
//
//Function HFBA_Solomon (var SQ : seq_record; start, slut : integer;
//                                                     pep : ShortString) : real;
//const HFBA : array [0..20] of real = (0, -2.8, -2.8, 1.1, -3.5, -7.5, 1.8, 5.6, -2.3,
//                   3.9, 2.1, -14.3, 4.1, 11.0, 15.0, 3.8, 14.7, -2.5, 2.0, 17.8, 3.2);
//var i : integer;    seq_char : array [1..max_seq_len] of ansichar absolute SQ;
//begin
//  result := 0;
//  if pep = '' then                                  //'DNTSEQPGAVCMILYFKHWR'
//    for i := start to slut do
//      result := result + HFBA [System.pos (seq_char [i], aa1)]
//    else for i := start to slut do
//      result := result + HFBA [System.pos (pep [i], aa1)];
//end;
//
//{-----------------------------------------------------------------------------}
//
//Function TFA_Solomon (var SQ : seq_record; start, slut : integer;
//                                                     pep : ShortString) : real;
//const TFA : array [0..20] of real = (0, -2.9, -5.7, 0.8, -4.1, -7.1, -0.3, 5.1, -1.2,
//                   7.3, 3.5, -9.2, 5.6, 6.6, 20.0, 5.9, 19.2, -3.7, -2.1, 16.3,-3.6);
//var i : integer;    seq_char : array [1..max_seq_len] of ansichar absolute SQ;
//begin
//  result := 0;
//  if pep = '' then                                  //'DNTSEQPGAVCMILYFKHWR'
//    for i := start to slut do
//      result := result + TFA [System.pos (seq_char [i], aa1)]
//    else for i := start to slut do
//      result := result + TFA [System.pos (pep [i], aa1)];
//end;
//
//{-----------------------------------------------------------------------------}
//
//Function HPLC_Meek21 (var SQ : seq_record; start, slut : integer;
//                                                     pep : ShortString) : real;
//const M21 : array [0..20] of real = (0, -2.8, -1.6, 1.5, -3.7, -7.5, -2.5, 8.0, -0.5,
//                 -0.1, 3.3, -2.2, 7.1, 11.8, 10.0, 8.2, 13.9, -3.2, 0.8, 18.1, -4.5);
//var i : integer;    seq_char : array [1..max_seq_len] of ansichar absolute SQ;
//begin
//  result := 0;
//  if pep = '' then                                  //'DNTSEQPGAVCMILYFKHWR'
//    for i := start to slut do
//      result := result + M21 [System.pos (seq_char [i], aa1)]
//    else for i := start to slut do
//      result := result + M21 [System.pos (pep [i], aa1)];
//end;
//
//{-----------------------------------------------------------------------------}
//
//Function HPLC_Meek74 (var SQ : seq_record; start, slut : integer;
//                                                     pep : ShortString) : real;
//const M21 : array [0..20] of real = (0, -8.2, 0.8, 2.7, 1.2, -16.9, -4.8, 6.1, 0, 0.5,
//                          2.7, -6.8, 4.8, 13.9, 8.8, 6.1, 13.2, 0.1, -3.5, 14.9, 0.8);
//var i : integer;    seq_char : array [1..max_seq_len] of ansichar absolute SQ;
//begin
//  result := 0;
//  if pep = '' then                                  //'DNTSEQPGAVCMILYFKHWR'
//    for i := start to slut do
//      result := result + M21 [System.pos (seq_char [i], aa1)]
//    else for i := start to slut do
//      result := result + M21 [System.pos (pep [i], aa1)];
//end;
//
//{-----------------------------------------------------------------------------}
//
//Function KyteDoolittleHydropathy (var SQ : seq_record; start, slut : integer;
//                                                     pep : ShortString) : real;
//const Hyd : array [0..20] of real = (0, -3.5, -3.5, -0.7, -0.8, -3.5, -3.5, -1.6, -0.4,
//                          1.8, 4.2, 2.5, 1.9, 4.5, 3.8, -1.3, 2.8, -3.9, -3.2, -0.9, -4.5);
//var i : integer;    seq_char : array [1..max_seq_len] of ansichar absolute SQ;
//begin
//  result := 0;
//  if pep = '' then                                  //'DNTSEQPGAVCMILYFKHWR'
//    for i := start to slut do
//      result := result + Hyd [System.pos (seq_char [i], aa1)]
//    else for i := start to slut do
//      result := result + Hyd [System.pos (pep [i], aa1)];
//end;
//
//{-----------------------------------------------------------------------------}
//
//Function HoppWoodsHydrophilicity (var SQ : seq_record; start, slut : integer;
//                                                     pep : ShortString) : real;
//const Hyd : array [0..20] of real = (0, 3.0, 0.2, -0.4, 0.3, 3.0, 0.2, 0.0, 0.0, -0.5,
//                          -1.5, -1.0, -1.3, -1.8, -1.8, -2.3, -2.5, 3.0, -0.5, -3.4, 3.0);
//var i : integer;    seq_char : array [1..max_seq_len] of ansichar absolute SQ;
//begin
//  result := 0;
//  if pep = '' then                                  //'DNTSEQPGAVCMILYFKHWR'
//    for i := start to slut do
//      result := result + Hyd [System.pos (seq_char [i], aa1)]
//    else for i := start to slut do
//      result := result + Hyd [System.pos (pep [i], aa1)];
//end;
//
{-----------------------------------------------------------------------------}

Function PepParams (var SQ : seq_record; start, slut, mode: integer;  pep : ShortString) : real;

const params : array [0..9, 0..20] of real = (
    (0, 0.61, 0.89, 0.29, 0.42, 0.51, 0.97, -0.17, 0.81, 0.61, -0.75, 0.36, -0.66,   //B&B
                  -1.450, -1.65, -1.43, -1.52, 0.46, 0.690, -1.200, 0.690),
    (390, -168, -96, 90, -222, -450, -150, 480, -30, -6, 198, -132, 426, 708, 600,   //Meek
                                                 492, 834, -192, 48, 1086, -270),
    (0, -35, -35, -7, -8, -35, -35, -16, -4, 18, 42, 25, 19, 45, 38, -13, 28, -39,   //Gravy
                                                                   -32, -9, -45),
    (0, -0.9, -0.78, -0.05, 0.12, -0.74, -0.85, 0.12, 0.48, 0.62, 1.08, 0.29, 0.64,  //HydrofobicityEisenberg
                                1.38, 1.06, 0.26, 1.19, -1.5, -0.4, 0.81, -2.53),
    (0, -2.8, -2.8, 1.1, -3.5, -7.5, 1.8, 5.6, -2.3, 3.9, 2.1, -14.3, 4.1, 11.0,     //HFBA_Solomon
                                          15.0, 3.8, 14.7, -2.5, 2.0, 17.8, 3.2),
    (0, -2.9, -5.7, 0.8, -4.1, -7.1, -0.3, 5.1, -1.2, 7.3, 3.5, -9.2, 5.6, 6.6,      //TFA Solomon
                                         20.0, 5.9, 19.2, -3.7, -2.1, 16.3,-3.6),
    (0, -2.8, -1.6, 1.5, -3.7, -7.5, -2.5, 8.0, -0.5, -0.1, 3.3, -2.2, 7.1, 11.8,    //HPLC_Meek21
                                         10.0, 8.2, 13.9, -3.2, 0.8, 18.1, -4.5),
    (0, -8.2, 0.8, 2.7, 1.2, -16.9, -4.8, 6.1, 0, 0.5, 2.7, -6.8, 4.8, 13.9, 8.8,    //HPLC_Meek74
                                                6.1, 13.2, 0.1, -3.5, 14.9, 0.8),
    (0, -3.5, -3.5, -0.7, -0.8, -3.5, -3.5, -1.6, -0.4, 1.8, 4.2, 2.5, 1.9, 4.5,     //Hydrophacity Kyte Doolittle
                                        3.8, -1.3, 2.8, -3.9, -3.2, -0.9, -4.5),
    (0, 3.0, 0.2, -0.4, 0.3, 3.0, 0.2, 0.0, 0.0, -0.5, -1.5, -1.0, -1.3, -1.8,       //HoppWoodsHydrophilicity
                                        -1.8, -2.3, -2.5, 3.0, -0.5, -3.4, 3.0));

var i : integer;    seq_char : array [1..max_seq_len] of ansichar absolute SQ;
begin
  result := Params [Ord (mode), 0];
  if pep = '' then                                  //'DNTSEQPGAVCMILYFKHWR'
    for i := start to slut do
      result := result + params [Ord (mode), System.pos (seq_char [i], aa1)]
    else for i := start to slut do
      result := result + Params [Ord (mode), System.pos (pep [i], aa1)];
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

Function Peptide_charge (var SQ : seq_record; start, slut : integer; calcCys : boolean) : real;
{const  charge_arr : array [0..20] of integer = (0, -1, 0, 0, 0, -1, 0, 0, 0, 0, 0,
                                                0, 0, 0, 0, 0, 0, 1, 1, 0, 1);}
var pImode, i, n : integer;          compos : composition_array;

Function ChargeOfRes (charge : integer; pKa : real) : real;
var pHDiff : integer;
begin
  result := charge;
  pHDiff := Round (pKa * 10) - (glDef.pHCalcValue * 10) + 20;
  if pHDiff <= 0 then
    pHDiff := 0;
  if pHDiff >= 40 then
    pHDiff := 40;
  if pHDiff in [0..40] then
    if charge = -1 then                           //acidic charge
      result := - (100 - pHcH [pHDiff]) / 100
    else result := (pHcH [pHDiff]) / 100;
end;

begin
  pImode := (glDef.advanced and 3) + 1;
  Composition (SQ, compos, start, slut);
  result := ChargeOfRes (1, pKaN_term [aa1Hash [SQ. sequence [start]]][pImode]);
  result := result + ChargeOfRes (-1, pKaC_term [aa1Hash [SQ. sequence [slut]]][pImode]);
  if pImode = 4 then                              //user-defined pKa
    for i := 1 to 20 do
    begin
      n := system.Pos (aa1 [i], aa.aaStr1) - 1;          //aastr1 is 1-based; pKaVal [n] is 0-based
      if (compos [i] > 0) and (aa.pKaCharge [n] <> 0) then
        result := result + compos [i] * ChargeOfRes (aa.pKaCharge [n], aa.pKaVal [n]);
    end
  else begin
    result := result + compos [1] * ChargeOfRes (-1, pKa_Asp [pImode]);
    result := result + compos [5] * ChargeOfRes (-1, pKa_Glu [pImode]);
    result := result + compos [15] * ChargeOfRes (-1, pKa_Tyr [pImode]);
    result := result + compos [18] * ChargeOfRes (1, pKa_His [pImode]);
    result := result + compos [17] * ChargeOfRes (1, pKa_Lys [pImode]);
    result := result + compos [20] * ChargeOfRes (1, pKa_Arg [pImode]);
    if calcCys then
      result := result + compos [11] * ChargeOfRes (-1, pKa_Cys [pImode]);
  end;
end;

{-----------------------------------------------------------------------------}

Function ExtCoeff (const cp : composition_array; nm : integer; oxCys : boolean; mode : byte) : longint;
{W = 5690; Y = 1280; C = 120}   {276nm, 278nm, 279nm, 280nm, 282nm}
const ec : array [1..3, 1..5] of integer = ((5400, 5600, 5660, 5690, 5600),
           (1450, 1400, 1345, 1280, 1200), (145, 127, 120, 120, 100));
begin
  if (mode and 1) = 0 then               //von Hippel
    ExtCoeff := cp [Pos ('W', aa1)] * ec [1, nm] + cp [Pos ('Y', aa1)] * ec [2, nm]
              + Ord (oxCys) * (cp [Pos ('C', aa1)] div 2) * ec [3, nm]
  else if (mode and 1) = 1 then          //Page et al
    ExtCoeff := cp [Pos ('W', aa1)] * 5500 + cp [Pos ('Y', aa1)] * 1490
                              + Ord (oxCys) * (cp [Pos ('C', aa1)] div 2) * 125
  else ExtCoeff := 1;
end;

{-----------------------------------------------------------------------------}

Function Ext214Coeff (const cp : composition_array) : integer;
//('X','D','N','T','S','E','Q','P','G','A','V','C','M','I','L','Y','F','K','H','W','R')
const exc : array [0..20] of integer = (0, 58, 136, 41, 34, 78, 142, 2675, 21, 32, 43,
              225, 980, 45, 45, 5375, 5200, 41, 5125, 29050, 102);    //C=11
var i, count : integer;
begin
  count := 0;
  result := 0;
  for i := 1 to 20 do
  begin
    Inc (count, cp [i]);
    result := result + exc [i] * cp [i];
  end;
  result := result + (count - 1) * 923;           //ext coeff for peptide bond
end;

{-----------------------------------------------------------------------------}

Function Ext214Coeff (pepSQ : String) : integer;
//('X','D','N','T','S','E','Q','P','G','A','V','C','M','I','L','Y','F','K','H','W','R')
const exc : array [0..20] of integer = (0, 58, 136, 41, 34, 78, 142, 2675, 21, 32, 43,
              225, 980, 45, 45, 5375, 5200, 41, 5125, 29050, 102);    //C=11
var i : integer;
begin
  result := 0;
  if pepSQ <> '' then                         //calculate based on sequence
  begin
    result := (Length (pepSQ) - 1) * 923;    //ext coeff for peptide bond
    for i := 1 to Length (pepSQ) do
      result := result + exc [System.Pos (pepSQ [i], aa1)];
    if pepSQ [1] = 'P' then
      result := result - 2675 + 30;            //Nterm Pro only absorbs 30
  end;
end;

{-----------------------------------------------------------------------------}

Function Ext205Coeff (const cp : composition_array; oxCys : boolean) : integer;
//('X','D','N','T','S','E','Q','P','G','A','V','C','M','I','L','Y','F','K','H','W','R')
const exc : array [0..20] of integer = (0, 0, 400, 0, 0, 0, 400, 0, 0, 0, 0,
                       690, 1830, 0, 0, 6080, 8600, 0, 5200, 20400, 1350);    //C=11
var i, count : integer;
begin
  count := 0;                                 //count = length
  result := 0;
  for i := 1 to 20 do
  begin
    Inc (count, cp [i]);
    result := result + exc [i] * cp [i];
  end;
  if oxCys then
    result := result + (cp [11] div 2) * 820; //add extra for cystine if disulfide bridge (oxidized)
  result := result + (count - 1) * 2780;       //ext coeff for peptide bond
end;

{-----------------------------------------------------------------------------}

Function Ext205Coeff (pepSQ : String; oxCys : boolean) : integer;
var cp2 : composition_array;
begin
  result := 0;
  if pepSQ = '' then                         //calculate based on sequence
    Exit;
  PeptideCompos (pepSQ, cp2);
  result := Ext205Coeff (cp2, oxCys);
end;

{-----------------------------------------------------------------------------}

Function PepString (SQ : pSeq_record; start, slut, resType : integer) : shortString;
var i : integer;
begin
  start := Max (start, 1);
  slut := Min (slut, SQ^.maxSeq);
  result := '';
  if resType = 1 then                            {1 = 1-letter code; 3 = 3-letter code}
  begin
    slut := Min (slut, start + 254);
    for i := start to slut do
      result := result + AnsiChar (SQ^.sequence [i]);
  end else begin
    slut := Min (slut, start + 58);
    for i := start to slut do
      result := result + Residue4 (SQ^.sequence [i]);
  end;
end;

{-----------------------------------------------------------------------------}

Function PepLString (SQ : pSeq_record; start, slut, maxL : integer) : String;
var i : integer;
begin
  start := Max (start, 1);
  slut := Min (slut, SQ^.maxSeq);
  if maxL > 0 then
    slut := Min (slut, start + maxL - 1);
  result := '';
  for i := start to slut do
    result := result + Char (SQ^.sequence [i]);
end;

{-----------------------------------------------------------------------------}

Function AbbrevPepStr (SQ : pSeq_record; start, slut, resType, limit : integer; ins : str8) : shortString;
var lim, halfLim : integer;                {limit is # characters}
begin
  if resType <> 1 then
    lim := limit div 3
  else lim := limit;
  halflim := (lim div 2) - 1;
  if (slut - start + 1) <= lim then
    result := PepString (sq, start, slut, resType)
  else result := PepString (sq, start, start + halfLim, resType) + ins +
                                  PepString (sq, slut - halfLim, slut, resType);
end;

{-----------------------------------------------------------------------------}

Function PepLimStr (SQ : pSeq_Record; first, last, rType, limit : integer; inst : str8) : AnsiString;
var lim, i : integer;
function AddRes (SQ : pSeq_record; x, rType : integer) : AnsiString;
begin
  if rType = 1 then
    if (x >= 1) and (x <= SQ^.maxseq) then
      result := AnsiChar (SQ^.sequence [x])
    else result := ' '
  else if (x >= 1) and (x <= SQ^.maxseq) then
      result := Residue4 (SQ^.sequence [x])
    else result := '    ';
end;
begin
  result := '';
  for i := first - 2 to first - 1 do
    result := result + AddRes (SQ, i, rType);
  if rType = 1 then
    lim := limit - 6
  else lim := (limit - 10) div 4;
  result := result + ' ';
  result := result + AbbrevPepStr (SQ, first, last, rType, lim, inst);
  result := result + ' ';
  for i := last + 1 to last + 2 do
    result := result + AddRes (SQ, i, rType);
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

Function Res2Nam (pSeq : pSeq_record; num : integer) : string;
begin
  result := aa.name3 [aa.aaIndex [pSeq^.sequence [num]]] + IntToAnsiStr (num);
end;

{-----------------------------------------------------------------------------}

Function ResToNam (lSeq : Seq_record; num : integer) : str12;
begin
  result := aa.name3 [aa.aaIndex [lSeq.sequence [num]]] + IntToAnsiStr (num);
end;

{-----------------------------------------------------------------------------}

Function ResidueString (pS : pSeq_record; res : word) : str12;
var j : integer;      tmp : AnsiString;        acid : AnsiChar;
begin
  acid := AnsiChar (pS^.sequence [res]);
  if System.Pos (acid, aa1) > 0 then
    tmp := Copy (aa3, System.Pos (acid, aa1) * 3 + 1, 3)
  else tmp := 'Xxx';
  if pS^.numChains > 1 then
  begin
    j := 1;
    while (res > pS^.chainList [j]) and (j < pS^.numChains) do
      Inc (j);
    ResidueString := tmp + IntToAnsiStr (res - pS^.chainList [j]) + pS^.chainChr [j];
  end else
    ResidueString := tmp + Seq2NumS (pS, res, 0);
end;

{-----------------------------------------------------------------------------}

Function Seq2NumS (pS : pSeq_record; position, form : integer) : str10;
var chain : integer;
Function SeqNum (position : integer) : integer;
begin
  if pS^.offset <> 0 then
  begin
    result := position + pS^.offset;
    if result <= 0 then
      Dec (result);
  end else result := position;
end;
begin
  if pS.numChains > 1 then
  begin
    chain := pS.mode [position] shr 5 + 1;
    position := position - pS.chainList [chain];
  end else chain := 1;
  if form = 0 then
    result := IntToAnsiStr (SeqNum (position))
  else result := Int2StrF (SeqNum (position), form);
  if pS.numChains > 1 then
    result := result + pS.chainChr [chain];
end;

{-----------------------------------------------------------------------------}

Function SqModResOK (pS : pSeq_record) : boolean;
begin
  if pS^.modified [maxModRes].pos > 0 then     //last position in array is taken
    result := false
  else result := true;
end;

{-----------------------------------------------------------------------------}

Procedure RemoveSeqMod (var pSeq : pSeq_Record;loc : integer;var ssCount : integer);
var j, k : integer;
begin
  for j := 1 to maxModRes do
    if pSeq^.modified [j].pos = loc then
    begin
      for k := j to maxModRes - 1 do
        pSeq^.modified [k] := pSeq^.modified [k + 1];
      FillChar (pSeq^.modified [maxModRes], SizeOf (modRes_Type), 0);
      Break;
    end;
  for j := 1 to ssCount do
    if (pSeq^.SSbridges [1, j] = loc) or (pSeq^.SSbridges [2, j] = loc) then
    begin
      for k := j to ssCount - 1 do
      begin
        pSeq^.SSbridges [1, k] := pSeq^.SSbridges [1, k + 1];
        pSeq^.SSbridges [2, k] := pSeq^.SSbridges [2, k + 1];
      end;
      pSeq^.SSbridges [1, ssCount] := 0;
      pSeq^.SSbridges [2, ssCount] := 0;
      Dec (ssCount);
      Break;
    end;
end;

{-----------------------------------------------------------------------------}

Procedure RemoveSeqRes (var pSeq : pSeq_Record;first, last : integer);
var i : integer;
begin
  with pSeq^ do
    if first = last then
    begin
      Move (sequence [first + 1], sequence [first], maxSeq - first);
      Move (mode [first + 1], mode [first], maxSeq - first);
      sequence [maxSeq] := 0;
      Dec (maxSeq);
      for i := 1 to maxLinks do
      begin
        if SSbridges [1, i] > first then
          Dec (SSbridges [1, i]);
        if SSbridges [2, i] > first then
          Dec (SSbridges [2, i]);
      end;
      for i := 1 to maxModRes do
        if modified [i].pos > first then
          Dec (modified [i].pos);
      pSeq^.changed := true;
    end;
end;

{-----------------------------------------------------------------------------}

Procedure String2Seq (var seq : seq_record; s : AnsiString);
var i : integer;
begin
  s := Trim (s);
  for i := 1 to Length (s) do
    seq.sequence [i] := Byte (s [i]);
  seq.maxseq := Length (s);
end;

{-----------------------------------------------------------------------------}

Procedure String2Seq (var seq : seq_record; s : String);
var i : integer;
begin
  s := Trim (s);
  for i := 1 to Length (s) do
    seq.sequence [i] := Byte (s [i]);
  seq.maxseq := Length (s);
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

Function FindPepInSeq (pSeq : pSeq_record;start : integer;pep : shortString;
                                            var pos1, pos2 : integer) : boolean;
//find the first occurrence of pep in pSeq^sequence starting from position start
var i, j : integer;
begin
  result := false;
  i := start - 1;
  Pos1 := 0;
  pos2 := 0;
  repeat
    Inc (i);
    if pep [1] = AnsiChar (pSeq^.sequence [i]) then
    begin
      result := true;
      for j := 2 to Length (pep) do
        if pep [j] <> AnsiChar (pSeq^.sequence [i + j - 1]) then
        begin
          result := false;
          break;
        end;
    end;
    if result then
    begin
      pos1 := i;
      pos2 := i + length (pep) - 1;
    end;
  until result or (i >= pSeq^.maxseq - Length (pep) + 1);
end;

{-----------------------------------------------------------------------------}

Procedure SortModResList (var sequence : seq_record);

var i, j, k, highest : integer;
begin
  with sequence do
  begin
    highest := maxModres;
    while (modified [highest].pos = 0) and (highest > 1) do
      Dec (highest);
    for i := highest downto 1 do
      if modified [i].pos = 0 then
      begin
        ExchangeStructs (modified [i], modified [highest], SizeOf (modRes_type));
        Dec (highest);
      end;
    if highest >= 2 then
      for i := highest downto 2 do
        for j := 1 to i - 1 do
          if (modified [i].pos > 0) and (modified [j].pos > modified [i].pos) then
            ExchangeStructs (modified [j], modified [i], SizeOf (modRes_type));
    if modified [1].pos > 0 then flags := flags or 1
    else flags := flags and not 1;
  end;
  if sequence.varMod <> nil then
    with sequence do
    begin
      for i := 1 to 9 do
        for j := i + 1 to 10 do
          if varMod^ [1, i].modPos > varMod^ [1, j].modPos then
            for k := 1 to 6 do
              ExchangeStructs (varMod^ [k, i], varMod^ [k, j], SizeOf (tSimpleModRec));
    end;
end;

{-----------------------------------------------------------------------------}

Procedure GetProtInfo (pSeq : pSeq_Record;red : boolean;var protInfo : tProtInfo);
var i : integer;
begin
  with protInfo do
  begin
    Composition (pSeq^, compos, pSeq^.start, pSeq^.maxSeq);
    msAv := Mr_real (pSeq^, pSeq^.start, pSeq^.maxSeq, 2);
    msMo := Mr_real (pSeq^, pSeq^.start, pSeq^.maxSeq, 3);
    gravy := PepParams (pSeq^, pSeq^.start, pSeq^.maxSeq, 2, '');
//    gravy := GRAVYvalue (pSeq^, pSeq^.start, pSeq^.maxSeq);
    ext280 [0] := ExtCoeff (compos, 4, true, 1);       //oxidized; 1=Page 0=von Hippel
    ext280 [1] := ExtCoeff (compos, 4, false, 1);      //reduced
    ext205 [0] := Ext205Coeff (compos, true);      //oxidized
    ext205 [1] := Ext205Coeff (compos, false);     //reduced
    for i := 1 to 3 do
    begin
      glDef.advanced := i - 1;
      pI [i, 0] := isoPoint (pSeq^, pSeq^.start, pSeq^.maxSeq, 0.00005, 0.0, 0, true, 0, 0);
      pI [i, 1] := isoPoint (pSeq^, pSeq^.start, pSeq^.maxSeq, 0.00005, 0.0, 0, true, 1, 0);
    end;
  end;
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

{=============================================================================}

Procedure SetUpPrint (hdl : tHandle;var prRec : printer_record);
var off : integer;
begin
  with prRec do
  begin
    xResol := GetDeviceCaps (hdl, LOGPIXELSX);                         {pixels/inch}
    yResol := GetDeviceCaps (hdl, LOGPIXELSY);
    off := GetDeviceCaps (hdl, PHYSICALOFFSETY);
    lMargin := xResol div 5 * 2;                                       {= 1/2" cm}
    tbMargin := yResol div 5;
    tbMargin := Max (tbMargin, off + yResol div 20);
    lh6 := (yResol div 6);
    lh4 := (yResol div 4);     {line height 1/6" and 1/4"}
    lh10 := yResol div 10;
    linY := 0;
    pageNum := 1;
  end;
end;

{-----------------------------------------------------------------------------}

Procedure PrintLine (const s : AnsiString; linInc, offset : integer; var prRec : printer_record);
begin
  PrintLine (String (s), linInc, offset, prRec);
end;

{-----------------------------------------------------------------------------}

Procedure PrintLine (const s : String; linInc, offset : integer; var prRec : printer_record);
var mode : word;
begin
  with prRec do
  begin
    Inc (linY, linInc);
    if linY >= printer.PageHeight - tbMargin then
    begin
      linY := tbMargin;
      mode := GetTextAlign (printer.canvas.handle);
      PrintPageNum (prRec);
      if not printer.Aborted then
        printer.NewPage;
      SetTextAlign (printer.canvas.handle, mode);
    end;
    if not printer.Aborted then
      printer.Canvas.TextOut (lmargin + offset, linY, s);
  end;
end;

{-----------------------------------------------------------------------------}

Procedure PrintLineF (const s : AnsiString; linInc, offset : integer; var prRec : printer_record;sty : tFontStyles);
begin
  Printer.Canvas.Font.Style := sty;
  PrintLine (s, linInc, offset, prRec);
  Printer.Canvas.Font.Style := [];
end;

{-----------------------------------------------------------------------------}

Procedure PrintPageNum (var prRec : printer_record);
var fSize : integer;
begin
  with printer do
  begin
    fSize := printer.canvas.font.size;
    printer.canvas.font.size := 7;
    printer.Canvas.TextOut (printer.pageWidth div 2, printer.pageHeight -
                (prRec.tbMargin div 2), 'page ' + IntToStr (prRec.pageNum));
    Inc (prRec.pageNum);
    printer.canvas.font.size := fSize;
  end;
end;

{-----------------------------------------------------------------------------}

Procedure EndPrintPage (var prRec : printer_record);
begin
  PrintPageNum (prRec);
  if not Printer.Aborted then
    Printer.EndDoc;
  Printer.title := '';
end;

{-----------------------------------------------------------------------------}

Function PrintLineX (const s : AnsiString; linInc, offset, mode : integer;
                                          var prRec : printer_record) : integer;
begin
  if mode = 1 then
    Printer.Canvas.Font.Style := [fsBold];
  PrintLine (s, linInc, offset, prRec);
  result := prRec.lmargin + offset + printer.Canvas.TextWidth (s);
  if mode = 1 then
    Printer.Canvas.Font.Style := [];
end;

{-----------------------------------------------------------------------------}

Procedure PrintHeader (var prRec : printer_record; pSeq : pSeq_record; ti : str40);
var line : String;
begin
  with printer do
  begin
    canvas.font.name := 'Arial';
    canvas.Font.Style := [];
    SetBkMode (canvas.handle, opaque);
    canvas.brush.color := clWhite;
    SetTextAlign (handle, ta_left or ta_top);
    canvas.font.size := 12;
    PrintLine (ti, 0, (PageWidth - canvas.TextWidth (ti)- prRec.lMargin) div 2, prRec);
    canvas.font.size := 10;
    line := pgmNameS + ' ' + verName;
    PrintLine (line, 0, 0, prRec);
    line := '[' + DateToStr (Date) + ']';
    PrintLine (line, 0, PageWidth - canvas.TextWidth (line) - prRec.lMargin, prRec);
    canvas.font.size := 11;
    if pSeq <> nil then
      if pSeq^.seqID <> '' then
        line := 'Sequence: [' + pSeq^.seqID + '] ' + pSeq^.seqName
      else line := 'Sequence: ' + pSeq^.seqName;
    if pSeq <> nil then
      PrintLine (line, canvas.TextHeight ('X') * 3 div 2, 0, prRec);
    Inc (prRec.linY, canvas.TextHeight ('X') div 2);
    canvas.font.size := 10;
  end;
end;

{-----------------------------------------------------------------------------}

Procedure PrintHLine (var prRec : printer_record);
begin
  Inc (prRec.linY, prRec.lh4);
  Printer.Canvas.Pen.width := prRec.yResol div 100;
  Printer.Canvas.MoveTo (prRec.lMargin, prRec.linY);
  if not Printer.Aborted then
    Printer.Canvas.LineTo (Printer.PageWidth, prRec.linY);
end;

{-----------------------------------------------------------------------------}

Procedure SetPrintSize (var prRec : printer_record; size : integer);
begin
  Printer.Canvas.Font.Size := size;
  prRec.ch1w := Printer.Canvas.TextWidth ('X');
  prRec.ch3w := Printer.Canvas.TextWidth ('Xxx');
  prRec.ch4w := Printer.Canvas.TextWidth ('Xxx-');
  prRec.ch1h := Printer.Canvas.TextHeight ('Xy');
end;

{-----------------------------------------------------------------------------}

Procedure Composition (var seq : seq_record; var comp : composition_array; start, slut : integer);
//calculate composition in comp. Unusual residues are placed in comp [0]
var  i : integer;
begin
  FillChar (comp, SizeOf (comp), 0);
  for i := start to slut do
    if seq.sequence [i] <> Ord ('-') then
      Inc (comp [aa1Hash [seq.sequence [i]]]);
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

Procedure GetAtomComp (var seq : seq_record; comp : composition_array;
                       var atoms : atomArray; const first, last : integer);
var res, i, j : integer;        compN : atomArray;
Procedure AddAtoms (var Acomp, newAcomp : atomArray; modifier : integer);
var i : integer;
begin
  for i := 1 to maxAtom do
    Inc (Acomp [i], newAcomp [i] * modifier);
end;
begin
  FillChar (Atoms, SizeOf (Atoms), 0);
  if first = seq.start then
    CnvComposStr (seq.terminals [1].compStr, compN)
  else CnvComposStr ('H1', compN);
  AddAtoms (atoms, compN, 1);
  if last = seq.maxseq then
    CnvComposStr (seq.terminals [2].compStr, compN)
  else CnvComposStr ('H1O1', compN);
  AddAtoms (atoms, compN, 1);
//  if (seq.numChains > 1) and (first = Seq.start) and (last = seq.maxseq) then
  for i := first to last do
    if Seq.sequence [i] = Ord ('-') then
    begin
      AddCompStr2AtomArr (aa.Nterm [0].compStr, atoms, 1);
      AddCompStr2AtomArr (aa.Cterm [0].compStr, atoms, 1);
    end;
  for i := 1 to 20 do                     // add atoms from residue composition
  begin
    res := System.Pos (aa_array [i], aa.aastr1) - 1;
    for j := 1 to maxAtom do
      atoms [j] := atoms [j] + comp [i] * aa.compos [res][j];
  end;
  if comp [0] > 0 then                    // has unusual residue
    for i := first to last do
    begin
      res := System.Pos (AnsiChar (seq.sequence [i]), aa.aaStr1) - 1;
      if (res > 0) and (aa1hash [seq.sequence [i]] = 0) then
      begin
        compN := aa.Compos [res];
        AddAtoms (atoms, compN, 1);
      end;
    end;
  if (seq.flags and bit0) <> 0 then       // has modified residues
    for i := 1 to maxModRes do
      if IntInRange (seq.modified [i].pos, first, last) = 0 then
        AddCompStr2AtomArr (seq.modified [i].compStr, atoms, 1);
  if glSSstate = 1 then                   //cys as SH
    for i := first to last do
      if (seq.sequence [i] = Ord ('C')) and ((seq.mode [i] and bit4) <> 0) then
        Dec (atoms [2]);
end;

{-----------------------------------------------------------------------------}

Procedure CalcAtoms (pSeq : pSeq_record;var allAtoms : atomArray; var atomPct : aPctArray;
                         const compos : composition_array);
var i : integer;
begin
  GetAtomComp (pSeq^, compos, allAtoms, pSeq^.start, pSeq^.maxSeq);
  FillChar (atomPct, SizeOf (atomPct), 0);
  for i := 1 to maxAtom do
    allAtoms [0] := allAtoms [0] + allAtoms [i];
  for i := 1 to maxAtom do
    if (allAtoms [i] > 0) and (allAtoms [0] > 0) then
      AtomPct [i]:= allAtoms [i] / allAtoms [0] * 100.0;
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

Procedure MakeHilightList (var seq_rec : seq_record; ac : string; col, mode : byte);
//mode: 1: invert seq; 2: L/I, 4: K/Q
var i, SL, last : integer;        invert : string;        searchSeq : seq;
procedure SetColorMode (chkS : string);
var i, j, k : integer;
begin
  i := 0;
  while i < last do
  begin
    Inc (i);
    while (searchSeq [i] <> Ord (chkS [1])) and (i <= seq_rec.maxSeq) do
      Inc (i);
    if i <= last then
    begin
      j := 1;
      while (j <= SL) and ((searchSeq [i + j - 1] = Ord (chkS [j])) or (chkS [j] = '?'))  do
       Inc (j);
      if (Length (chkS) = 3) and (chkS [1] = 'N') and (chkS [2] = '?') and
                                        CharInSet (chkS [3], ['T','S','C']) then
        if searchSeq [i + 1] = Ord ('P') then
          j := 1;
      if j = SL + 1 then
        for k := i to (i + SL - 1) do
          seq_rec.mode [k] := seq_rec.mode [k] or col;
    end;
  end;
end;
Procedure ReplaceRes (doIt : boolean; res1, res2 : Char);
var i : integer;            //replace res1 with res1 in sequence and search string
begin
  if not doIt then
    Exit;
  for i := 1 to seq_rec.maxseq do
    if searchSeq [i] = Ord (res2) then
      searchSeq [i] := Ord (res1);
  for i := 1 to SL do
    if ac [i] = res2 then
      ac [i] := res1;
end;
begin
  SL := Length (ac);
  last := seq_rec.maxSeq - SL + 1;
  searchSeq := seq_rec.sequence;
  ReplaceRes ((mode and 2) = 2, 'L', 'I');
  ReplaceRes ((mode and 4) = 4, 'K', 'Q');
  ReplaceRes ((mode and 8) = 8, 'F', 'M');
  SetColorMode (ac);
  if (mode and 1) = 1 then            //invert sequence
    if (SL <> 3) or (ac [2] <> '?') then
    begin
      invert := '';
      for i := SL downto 1 do
        invert := invert + ac [i];
      SetColorMode (invert);
    end;
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

{-----------------------------------------------------------------------------}

Function IsCleaveDefOK (clStr : string) : boolean;
var s20 : string;            i : integer;        OK : OK_typ;
begin
  result := true;
  if pos (';', clStr) = 0 then        {single definition}
    result := (CheckCleaveDef (OK, clStr) > 0)
  else                                               {double definition}
    for i := 1 to WordCount (clStr, '; ') do
    begin
      s20 := ExtractWord (i, clStr, '; ');
      if result then
        if (Length (s20) > 1) then
          result := (CheckCleaveDef (OK, s20) > 0)
        else result := false;
    end;
end;

{-----------------------------------------------------------------------------}

Function CheckCleaveDef (var OK : OK_typ; clStr : string) : integer;

var i, position, clPos : integer;      notOK : OK_typ;
    OKset : set of AnsiChar;
begin
  OKset := [];
  for i := 1 to maxAA do
    OKset := OKset + [aa.name1 [i]];
  for i := 1 to maxOKset do
  begin
    OK [i] := [];
    notOK [i] := [];
  end;
  i := 1;
  while not CharInSet (clStr [i], ['/','\',',','-']) and (i < Length (clStr)) do
    Inc (i);
  position := 1;
  clPos := 0;
  repeat
    if clStr [i] = '-' then
    begin
      clPos := position;
      Inc (position);
    end else
      if clStr [i] = ',' then Inc (position);
    if CharInSet (clStr [i], ['/','\']) and CharInSet (clStr [i + 1], (OKset + ['?'])) then
    begin
      Inc (i);
      if clStr [i - 1] = '/' then
        OK [position] := OK [position] + [clStr [i]]
      else notOK [position] := notOK [position] + [clStr [i]]
    end;
    Inc (i);
  until i > Length (clStr);
  if clPos = 0 then clPos := position;
  for i := 1 to maxOKset do
    if OK [i] = [] then
    begin
      OK [i] := OKset;
      OK [i] := OK [i] - notOK [i];
    end else
      if CharInSet ('?', OK [i]) then
        OK [i] := OKset;
  if (OK [1] = OKset) and (OK [2] = OKset) then
    result := 0
  else result := clPos;
end;

{=============================================================================}

Procedure CalcCleave (var clPos : integer; pSEQ : pSeq_record; clInput : string; modif : boolean);

Procedure SortList (var list : cleave_Arr; var maxList : integer);
var i, j : integer;
begin
  for i := 1 to maxList - 1 do
    for j := i + 1 to maxList do
      if list [j] < list [i] then
        ExchangeStructs (list [j], list [i], SizeOf (smallInt));
  for i := 1 to maxList - 1 do
    if list [i] = list [i + 1] then
      for j := i + 1 to maxList do
        list [j] := list [j + 1];
  While (list [maxList] = 0) and (maxList > 1) do
    Dec (maxList);
end;

Procedure MakeClList (clStr : string; clearList : boolean);
var i, j, residue : integer;      OK : OK_typ;        quit : boolean;
begin
  clPos := CheckCleaveDef (OK, clStr);
  if clPos = 0 then
  begin
    MyMsgDlg ('Error in cleavage definition! §' + clStr , mtError, [mbOK], 0);
    Exit;
  end;
  if clearList then
    FillChar (pSEQ^.cleaveList, SizeOf (pSEQ^.cleaveList), 0);
  i := 1;
  while (pSEQ^.cleaveList [i] > 0) and (i < maxCleave) do
    Inc (i);
  residue := 1{ + pSEQ^.offset};
  repeat
    quit := false;
    repeat
      if pSEQ^.sequence [residue] = Ord ('-') then
        quit := true;
      if not quit and (AnsiChar (pSEQ^.sequence [residue]) in OK [1]) and
         ((pSeq^.mode [residue] and bit4 = 0) or not modif) then
      begin
        j := 2;
        quit := true;
        repeat
          if residue + j - 1 > pSEQ^.maxSeq then     //#88='X'
            quit := CharInSet (#88, OK [j])     // if not (#88 in OK [j]) then quit = false
          else
            if not (AnsiChar (pSEQ^.sequence [residue + j - 1]) in OK [j]) then
              quit := false;
          Inc (j);
        until not quit or (j > maxOKset);
      end;
      Inc (residue);
    until quit or (residue > pSEQ^.maxSeq);
    if quit then                         //conditions for OK_set 1..maxOKset are met
    begin
      if pSEQ^.sequence [residue - 1] = Ord ('-') then    //?
        pSEQ^.cleaveList [i] := residue - 1               //+ clPos - 2;
      else
        if (residue - 1 <= pSEQ^.maxSeq) then
          pSEQ^.cleaveList [i] := residue + clPos - 2;
      Inc (i);
    end;
  until (i >= maxCleave - 1) or (residue > pSEQ^.maxSeq);
  if i >= maxCleave - 1 then
    MyMsgDlg ('Maximum number of peptides exceeded!', mtError, [mbOK], 0);
  if (i = 1) or (pSEQ^.cleaveList [i - 1] <> pSEQ^.maxSeq) then
    pSEQ^.cleaveList [i] := pSEQ^.maxSeq
  else Dec (i);
  clPos := i;
end;

var s20 : string;            i : integer;
begin
  if pos (';', clInput) = 0 then              {single definition}
    MakeClList (clInput, true)
  else begin                                  {double definition}
    s20 := ExtractWord (1, clInput, '; ');
    MakeClList (s20, true);
    for i := 2 to WordCount (clInput, '; ') do
    begin
      s20 := ExtractWord (i, clInput, '; ');
      if Length (s20) > 1 then
        MakeClList (s20, false);
    end;
    SortList (pSeq^.cleaveList, clPos);
  end;
end;

{-----------------------------------------------------------------------------}

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

Function Check4Res (pSeq : pSeq_record; first, last : integer; res : byte) : boolean;
var i : integer;
begin
  result := false;
  if (first > 0) and (last <= pSeq^.maxSeq) then
    for i := first to last do
      if pSeq^.sequence [i] = res then
      begin
        result := true;
        break;
      end;
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

Procedure FillSearchLimitBox (data : tDigestSearchData;list : tStrings);
begin
  with data, list do
  begin
    Clear;
    Add (Format ('Mass range :%4d-%3d kDa', [low, high]));
    if glDef.disp and bit14 = bit14 then
      Add (Format ('Precision : %5.0f ppm', [precision * 10000]))
    else Add (Format ('Precision :%7.4f%%', [precision]));
    Add (Format ('Minimum   : %4.2f Da', [minPrc]));
    Add (Format ('MonoMass < : %4d Da', [MonoMSpoint]));
    Add (Format ('Overlaps  :%2d', [overlap]));
    Add (Format ('Min. hits :%3d', [minHits]));
    Add (Format ('Mass type : %s', [ionLabel [ionType]]));
  end;
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

{----WEB related functions-------------------------------------------------------------------------}

Function InetConnected : boolean;

Function FuncAvail (_dllName, _funcName : String; var _p : pointer) : boolean;
var _lib : tHandle;
begin
  result := false;
  if LoadLibrary (pChar (_dllname)) = 0 then
    Exit;
  _lib := GetModuleHandle (pChar (_dllname));
  if _lib <> 0 then
  begin
    _p := GetProcAddress (_lib, pChar (_funcName));
    if _p <> nil then
      Result := true;
  end;
end;
var InetIsOffline : function (dwFlags : dWord) : bool; stdcall;
begin
  if FuncAvail ('URL.DLL', 'InetIsOffline', @InetIsOffline) then
    result := not InetIsOffline (0)
  else result := false;
end;

{-----------------------------------------------------------------------------}

Function DelTag (s : ansiString; x : integer) : ansiString;
var y : integer;
begin
  y := x;
  if x > 0 then
    repeat
      Inc (y)
    until (s [y] = '>') or (y >= Length (s));
  if (y > x) and (y <= Length (s)) then
    result := StrStDeleteL (s, x, y - x + 1)
  else result := '';
end;

{-----------------------------------------------------------------------------}

Function DelHTML (s : string) : string;
var i : integer;        a : boolean;
begin
  a := true;
  result := '';
  for i := 1 to Length (s) do
  begin
    if s [i] = '<' then
      a := false;
    if s [i] = '>' then
      a := true;
    if a and (s [i] <> '>') then
      result := result + s [i];
  end;
end;

{-----------------------------------------------------------------------------}

Function Skip2Line (line : AnsiString;strLst : tStringList; count : integer; reverse : boolean) : integer;
var len : integer;
begin
  result := count;
  len := Length (line);
  if reverse and (count > 0) then
  begin
    while (result > 1) and (Copy (strLst [result], 1, len) <> line) do
      Dec (result)
  end else
    while (result < strLst.Count - 12) and (Copy (strLst [result], 1, len) <> line) do
      Inc (result);
end;

{-----------------------------------------------------------------------------}

procedure ParseWebNCBI (var txt, seqDat : tStringList; single : boolean);
var x, i : integer;            st : String;
    s2 : str4;                                   
begin
  seqDat.Clear;
  for i := 0 to txt.count - 3 do
  begin
    st := txt [i];
    s2 := AnsiString (copy (st, 1, 2));
    if (s2 <> '["') and (s2 <> '&n'){ and (s2 <> '//') }then
    begin
      repeat
        x := Pos ('<', st);
        if x > 0 then
          st := DelTag (AnsiString (st), x);            //primitive web tag removal
      until x = 0;
      if not ((seqDat.Count < 10) and (Copy (st, 1, 5) = 'Comme')) then
        SeqDat.Add (st);
    end;
  end;
end;

{-----------------------------------------------------------------------------}

Function CountGenPept (const seqDat : tStringList) : integer;
var i : integer;
begin
  result := 0;
  for i := 0 to seqDat.Count - 5 do
    if (seqDat [i] <> '') and (seqDat [i][1] = 'D') and
                         (copy (seqDat.strings [i], 1, 10) = 'DEFINITION') then
      Inc (result);
end;

{-----------------------------------------------------------------------------}

procedure ParseWebSRS (var txt, seqDat : tStringList);
var i : integer;
begin
  if Pos ('ID', txt [0]) > 0 then          //-> swiss-prot record
    for i := 0 to txt.Count - 1 do
    begin
      while Pos ('<', txt [i]) > 0 do
        txt [i] := DelTag (AnsiString (txt [i]), Pos ('<', txt [i]));
      if Length (txt [i]) > 1 then
        seqDat.Add (txt [i]);
      if Copy (txt [i], 1, 2) = '//' then
        Break;
    end;
end;

{-----------------------------------------------------------------------------}

Procedure SetupProxy (var myProxy : TIdHTTP);
begin
  with myProxy.ProxyParams do
  begin
    ProxyPort := glProxySet.port;
    ProxyServer := glProxySet.serverName;
    BasicAuthentication := glProxySet.BasicAuth;
    if not glProxySet.noPassWord then
    begin
      ProxyPassword := glProxySet.password;
      ProxyUsername := glProxySet.userName;
    end;
  end;
end;

{-----------------------------------------------------------------------------}

Procedure CheckRun (const S : string);
var f : textFile;
const name = 'gpBlastCheck.txt';
begin
  if debugValue = 0 then
    Exit;
  if S = 'NEW' then
  begin
    if FileExists (workingdir + name) then
      DeleteFile (workingdir + name);
    AssignFile (f, workingdir + name);
try
    ReWrite (f);
    WriteLn (f, 'New');
except
  on EInOutError do
    MyMsgDlg ('Error in runcontrol file creation', mtError, [mbOK], 0);
end;
    CloseFile (f);
  end else begin
    AssignFile (f, workingDir + name);
    Append (f);
    WriteLn (f, s);
    CloseFile (f);
  end;
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

Function Color2RTF (col : tColor) : string;
begin
  result := Format ('\red%d\green%d\blue%d;', [GetRvalue (col),GetGvalue (col),GetBvalue (col)]);
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
