unit Globals;

INTERFACE
{$J+}                      //typed constants
uses Windows, Messages, Graphics, SysUtils, Classes, SHfolder;

const aa1 : shortString = 'DNTSEQPGAVCMILYFKHWR';
      aa_array : array [0..20] of ansichar = ('X','D','N','T','S','E','Q','P','G','A','V',
                                          'C','M','I','L','Y','F','K','H','W','R');
      aa3 : AnsiString = 'XxxAspAsnThrSerGluGlnProGlyAlaValCysMetIleLeuTyrPheLysHisTrpArg';
      aminoacid : array [0..20] of String [3] = ('Xxx','Asp','Asn','Thr','Ser',
                                     'Glu','Gln','Pro','Gly','Ala','Val','Cys','Met',
                                     'Ile','Leu','Tyr','Phe','Lys','His','Trp','Arg');
      aa1Set : TSysCharSet = ['A','C'..'I','K'..'N','P'..'T','V', 'W', 'Y'];
      msText : array [1..3] of String [7] = ('Integer', 'Average', 'Monoiso');
      msBtnLbl : array [0..3] of String [3] = ('', 'In.', 'Av.', 'Mo.');
      singlePMut : AnsiString = 'ADAEAGAPASATAVCFCGCSCWCYDEDGDHDNDVDYEGEKEQEVFIFLFSFVGRGS' +
'GVHLHNHPHQHRHYIKILIMINIRISITIVKMKNKQKTLMLPLQLRLSLVLWMRMTMVNSNTNYPQPRPSPTQRRSRTRWSTSWSY';
      monthName : array [1..12] of String [3] = ('Jan','Feb','Mar','Apr','May',
                                  'Jun', 'Jul','Aug','Sep','Oct','Nov','Dec');
      massIonType : array [0..2] of string [3] = ('M', 'M-H', 'M+H');
      ionLabel : array [0..2] of string [3] = ('M-H','M', 'M+H');
      maxPepCol = 25;
    maxFrag = 10;
    msFragStr : array [1..maxFrag] of String [12] =  //a, b, b-NH3, b-H2O, c, x, y, y-NH3, y-H20, z
     ('-C1O2H1','-O1H1'{b},'-O1H4N1','-O2H3','-O1+N1H2'{c},'-H1+C1O1','H1'{y},
     '-N1H2','-O1H1','-N1H2');
      maxAA = 33;                     maxTerm = 12;
      maxLinks = 40;                  msmsMax = 2000;
      maxChains = 7;                  maxModRes = 32;
      maxEnzNum = 15;                 maxOKset = 16;
      maxAtom = 32;                   maxDBmodif = 40;
      atomTblMax = 24;                maxPepDaughter = 18;
      smallBuffSize = 12000;          largeBuffSize = 42000;
      glColNum = 16;                  digNameLen = 30;
      dbTpNum = 5;                    glDirCount = 10;
      max_seq_len = 10000;

      maxCleave = 4000;                        //# of saved information
      hugeBuffSize = 512000;
      maxPepMStable = 5000;                     //ms table in digest mass search
      xLinkMax = 20;          //number of entries in xLinkTbl
      maxMSMS = 500;
const
   maxScoreType = 2;
   ms_MSfileChange = wm_user + 101;  ms_daughterclose = wm_user + 102;
   ms_startFile    = wm_user + 103;  ms_pepMSsearch   = wm_user + 104;
   ms_autoLoadSeq  = wm_user + 105;  ms_saveAsFile    = wm_user + 106;
   ms_saveFile     = wm_user + 107;  ms_redraw        = wm_user + 108;
   ms_HilightSeq   = wm_user + 201;  ms_clearHilight  = wm_user + 202;
   ms_hilightMass  = wm_user + 203;  ms_hilight       = wm_user + 204;
   ms_copy2clip    = wm_user + 205;  ms_print         = wm_user + 206;
   ms_dotPlot      = wm_user + 301;  ms_export2Clip   = wm_user + 302;
   ms_calcPi       = wm_user + 303;  ms_massSearch    = wm_user + 304;
   ms_annotChange  = wm_user + 305;  ms_seqHighlight  = wm_user + 306;
   ms_motifHiLight = wm_user + 307;  ms_fontChange    = wm_user + 308;
   ms_GPinfo       = wm_user + 309;  ms_analMSlist    = wm_user + 310;
   ms_doCleavage   = wm_user + 311;  ms_calibrate     = wm_user + 312;
   ms_LineChange   = wm_user + 313;  ms_WebSequence   = wm_user + 314;
   ms_ReCalcLst    = wm_user + 315;  ms_redoBlast     = wm_user + 316;
   ms_copyAsGraph  = wm_user + 317;  ms_MsPrecisClose = wm_user + 318;
   ms_GraphClose   = wm_user + 319;  ms_CloseWin      = wm_user + 320;
   ms_Change       = wm_user + 321;  ms_showCoverage  = wm_user + 322;
   ms_CloseSSwin   = wm_user + 323;  ms_postStartup   = wm_user + 324;
   ms_AlignPepWin  = wm_user + 325;  ms_minimize      = wm_user + 326;
   ms_updInfo      = wm_user + 327;  ms_fileOpen      = wm_user + 328;
   ms_controller   = wm_user + 329;

   bit0 = 1;        bit7 = 128;       bit14 = 16384;         bit21 = $200000;    bit28 = $10000000;
   bit1 = 2;        bit8  = 256;      bit15 = 32768;         bit22 = $400000;    bit29 = $20000000;
   bit2 = 4;        bit9  = 512;      bit16 = $010000;       bit23 = $800000;    bit30 = $40000000;
   bit3 = 8;        bit10 = 1024;     bit17 = $020000;       bit24 = $1000000;   bit31 = $80000000;
   bit4 = 16;       bit11 = 2048;     bit18 = $040000;       bit25 = $2000000;   bit32 = $100000000;
   bit5 = 32;       bit12 = 4096;     bit19 = $080000;       bit26 = $4000000;
   bit6 = 64;       bit13 = 8192;     bit20 = $100000;       bit27 = $8000000;
   bitArray : array [0..31] of UInt64 = (1,2,4,8,16,32,64,128,256,512,1024,2048,4096,
                                  8192,16384,32768,65536,131072,262144,524288,1048576,
                                  2097152,4194304,8388608,16777216,33554432,67108864,
                                  134217728,268435456,536870912,1073741824,2147483648);
   preProCol = 5;                 txtCol = 6;
   HiLightNumCol : byte = 3;      numSortBy = 7;
//Colors:
   clLightGray = $E0E0E0;         clLightYellow = $90FFFF;      clOrange = $000099FF;
   levelCol : array [0..15] of tColor = (clRed, clBlue, $00F000, clFuchsia, $FFBF00,
                             clGreen, $00C0FF, clPurple, clRed, clBlue, $00F000,
                             clFuchsia, $FFBF00, clGreen, $00C0FF, clPurple);
   MSMScolor : array [0..11] of tColor = (clBlack, clGreen, clBlue, clTeal, $00E0C011,
                clOlive, clGray, clRed, clFuchsia, clPurple, $005BC0F7, clOrange);
//  orange $005BC0F7    Lighthblue $00F5B49C
   SSPenCol : array [0..3] of tColor = ($0000FF, $00804F, $1080DF,  $40E0C0);
   ColorHotTo = $00F9D2B2; //blue

   massTypeName : array [1..3] of string [8] = ('Integer', 'Average', 'Monoiso.');
   msTypeColor : array [1..2] of tColor = (clBlue, clRed);
   HydMS : double = 1.007825;                       //approx. mass of a hydrogen ave/mono
   protonMS : real = 1.00727647;
   hydrogenMS : array [1..3] of double = (1.0, 1.00794, 1.007825);  //exact mass of hydrogen

   EntrezWebStr = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
   SRSwebStr = 'http://srs.ebi.ac.uk/srsbin/cgi-bin/wgetz?-ascii+-e';
   maxSmallMS = 5000;
   noYesArr : array [0..1] of string [3] = ('no', 'yes');
   OffNumCol = 15;
   OfficeStyle : array [0..offNumCol - 1] of string = ('Blue', 'Olive', 'Silver',
                                   'XP', 'Luna', 'Obsidian', '2007Silver', 'Windows7',
                                   'Whidbey', 'Office2007','Vista','Terminal','2010Blue',
                                   '2010Silver','2010Black');
   HexNumArr : array [0..15] of ansiChar = ('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');

    RndColLst : array [0..14] of tColor = (clOrange, clRed, clBlue, clLime, clFuchsia,
                 clGreen, clNavy, ClTeal, clPurple, clAqua, clYellow, clMaroon,
                 clOlive, clGray, clFuchsia);
    ChargeCol : array [0..9] of tColor = (clFuchsia, clOrange, clLime, clGreen,
                        clOlive, clPurple, clMaroon, clRed, clYellow, clAqua);
    ChargeCstr : array [0..9] of string = ('clYellow', 'clOrange', 'clLime', 'clGreen',
                 'clOlive', 'clPurple', 'clMaroon', 'clRed', 'clFuchsia', 'clAqua');

      pHcH : array [0..40] of integer = (0, 1, 2, 2, 2, 3, 4, 5, 6, 7, 9, 11, 14, 17, 20, 24, 28, 33,
         39, 44, 50, 56, 61, 67, 72, 76, 80, 83, 86, 89, 91, 93, 94, 95, 96, 97, 98, 98, 98, 99, 100);
      YesNoS : array [0..1] of string [3] = ('Yes', 'No');
      PlusMinus : array [0..1] of string [1] = ('+', '-');
      lastPepListNdx = 3000;
      ColumnFragLbl : array [0..10] of string [4] = (' ', 'a','b','b-18','c','x','y',
                                                     'y-17','y-18','z', 'Res.');

type  seq           = array [1..max_seq_len] of byte;
      pSeq          = ^seq;
      tIntSeq       = array [1..max_seq_len] of longWord;
      tInt64Seq     = array [1..5000] of UInt64;
      tWordSeq      = array [1..max_seq_len] of word;
      str80         = string [80];
      str40         = string [40];
      str32         = string [32];
      str20         = string [20];
      str12         = string [12];
      str10         = string [10];
      str8          = string [8];
      str4          = string [4];
      str3          = string [3];
      str2          = string [2];
      fNameType     = String;
      aa_name1_type  = array [0..maxAA] of ansichar;           //aa_name_type
      aa_name3_type  = array [0..maxAA] of str3;
      aa_name_array  = array [0..maxAA] of str10;
      formula_array  = array [0..maxAA] of str20;
      atomArray      = array [0..maxAtom] of longint;
      aPctArray      = array [1..maxAtom] of real;
      aaRealArray    = array [0..20] of real;
      compos_array   = array [0..maxAA] of atomArray;
      tagType        = array [0..12] of byte;
      w2array        = array [1..2] of word;
      r5Array        = array [0..4] of real;
      upCharSet      = tSysCharSet; //tAnsiCharSet of 'A'..'Y';
      hugeBuff       = array [0..hugeBuffSize] of ansichar;
      pHugeBuff      = ^hugeBuff;
      largeBuff      = array [0..largeBuffSize] of ansichar;
      pLargeBuff     = ^largeBuff;
      smallBuff      = array [0..smallBuffSize] of ansichar;
      pSmallBuff     = ^smallBuff;
      colour_array   = array [1..glColNum] of longint;
      pComposition   = ^composition_array;
      composition_array = array [0..21] of integer;
      OK_typ         = array [1..maxOKset] of set of ansichar;
      massType       = array [1..3] of real;       {1=int, 2=ave, 3=mono}
      cleave_arr     = array [1..maxCleave] of smallint;
      tSimpleModRec = record
                        modPos : integer;
                        Name, formula : shortString;
                        ave, mono : real;
                        end;
      tSimpleMod = array [1..10, 1..6] of tSimpleModRec;  //0=count
      pSimpleMod = ^tSimpleMod;
      modres_type    = record
                         name, compStr : shortString;
                         mass : massType;          //real array 1=int, 2=ave, 3=mono
                         pos : integer;
                         terminal : byte;                 //1= N-term; 2 = C-term; 4 = variable
                        end;
      modResArray    = array [1..maxModRes] of modres_type;       // -> 1..32
      termResArray   = array [1..2] of modRes_type;
      termStrArray   = array [0..maxTerm] of str20;              {0..12}
      termType       = array [0..maxTerm] of modres_type;
            (*
        pSeq_record    = ^seq_record;
              seq_record     = record                                  //21.256
                                 sequence, mode : seq;
        //mode: bit 0,1,2 = hilight res.;3 = Underline;4 = modified; 5,6,7= chain number
                                 seqname, seqID : shortString;        //accession number
                                 start, maxseq, numChains, offset : integer;
                                 flags   : word;
        //bit 0 = modified res.; 1 = SSbridges
                                 modified  : modResArray;          //1..maxModRes 32 of modrestype
                                 terminals : termResArray;         //N- & C-terminals
                                 MultiLink : array [1..3] of word;
                                 chainList : array [1..maxChains + 1] of integer;     //8 chains total
                                 chainChr : string [maxChains + 1];
                                 changed   : boolean;
                                 colRList  : packed array [0..100] of smallInt;  //0=number of col.res.
                                 varMod : pSimpleMod;
                                 end;
      *)
      pep_rec_ptr    = ^peptide_rec;
      peptide_rec    = record
                         start, slut   : integer;
                         number, part  : integer;        //peptide number; number of partials
                         mol_wgt : massType;             //1=int, 2=ave, 3=mono
                         compos  : composition_array;
                         next, previous : pep_rec_ptr;
                         ssLnk1, ssLnk2 : pep_rec_ptr;
                         wExt : w2array;                   //-> cross-linking
                         modPos : packed array [0..15] of byte;   //set in peptide.updatepep
                                                           //[0] = count of mods
                         flags : packed array [0..3] of byte;
                         end;
      tPepIndex      = array [0..maxCleave] of pep_rec_ptr;
      pFile_record   = ^file_record;
      file_record    = record
                         filename : fNameType;               //string
                         no_of_seq, seq_chosen, file_type : integer;
                         fSize : longint;
                         end;
      tProtInfo    = record
                       MSav, MSmo : real;
                       compos : composition_array;
                       end;
      tPepInfo     = record
                       pepSeq, modifs : string;
                       msTh, msExp, delta, sumInt : real;
                       miss, b, y, totFrag : integer;
                       compos : composition_array;
                       end;
      tPepInfoArr  = array of tPepInfo;
      GlobalDefRec = record                              //glDef
                       lastSeqLoad, pHCalcValue : integer;
                       SeqWinX, SeqWinY, MainWinX, MainWinY,
                       gpRunCount, upgInfoCount : integer;
                       dspFont : String;
                       dspFSize, daughterFont, dspLdist : integer;    //font size(10), dspLdist(100)
                       end;
      AtomMassType = record
                       abbrStr : string [2 * maxAtom];             {2 x 32}
                       abbr : array [1..maxAtom] of str2;
                       name : array [1..maxAtom] of str12;
                       ave, mono : array [1..maxAtom] of real;
                       end;
      aaType = record
                 name1 : aa_name1_type;                {array 0..maxAA of ansichar}
                 name3 : aa_name3_type;                {array 0..maxAA of str3}
                 name : aa_name_array;                 {array 0..maxAA of str10}
                 mass : array [1..3, 0..maxAA] of real;  //int, ave, mono
                 intMass : array [2..3, 0..maxAA] of longInt; {mass * 1000}
                 aaStr1 : string [maxAA];              {string of 1-lett code}
                 aaStr3 : string [maxAA * 3];          {string of 3-lett code}
                 aaIndex : array [33..255] of byte;    {aaIndex[i] points to index of residue i}
                 Nterm, Cterm : termType;              {name and compos}
                 composStr : formula_array;            {array 0..maxAA of str20}
                 compos : compos_array;                {array 0..maxAA of atomArray}
                 atoms : atomMassType;
                 end;
      modifRecord = record                             {88 bytes}
                      name, formula, valResStr : string;
                      enabled, massOnly : boolean;
                      ave, mono: real;
                      validRes : upCharSet;            //has to be 'A'..'Y'
                      terminal : integer;                 //1= N-term; 2 = C-term
                      end;
      tModifRecArr = array [1..maxDBmodif] of modifRecord;
      pModifType = ^ModifType;
      ModifType = record
                    dBase : tModifRecArr;         {1..30 maxDBmodif; 3520 bytes}
                    shortFName : string;                //just file name
                    longFname : fNameType;             //full path file name
                    tableMax : integer;
                    end;

  tMSMStable = array [1..maxMSMS] of real;

  extOpType = record                                //used in peptide generation
         mode, loCount, hiCount : word;
         lowMS, hiMS : longint;
         end;
  linkResType = array [1..2] of integer;             //0=Acid;1=Amine;2=Sulfhydryl;
  atomDist = record
               aa : str2;
               nomMs, nIso, count, aCount : integer;
               realMs : real;
               freq : array [1..3] of real;
               end;
  atomDistArr = array [0..maxAtom] of atomDist;
  isoTypeArr = array [1..12000] of real;
  isotopeRec = record
                 monoMs, isoMax : real;
                 isotopes : isoTypeArr;
                 end;
    tMSRec =  record
                ms, int : real;
                end;
    msmsListType = record
                     mass : double;
                     id : String;
                     end;
    tSpecArray = array [1..maxSmallMS] of tMSRec;     //ms, int - mass; intensity - 5.000
    tMSMSpeaks = array of tMSRec;
    tMSMSrun = array of tMSMSpeaks;
    tMSspec = record
                parent : real;
                count, pCharge : integer;
                name : String;
                data : tSpecArray;       //1..5000
                end;
    pMSspec = ^tMSspec;
  tBox = record
           left, right, top, bottom : integer;
           end;
  SmallMSrec = record                           //used for multiple mass files
       mass, intensity : real;
       index : packed array [1..2] of word;        //name line ndx + file line ndx
       end;
  smSpecRec = record
       table  : array [1..maxSmallMS] of smallMSrec;
       msFileName : fNameType;
       msTitles : tStringList;
       listCount : integer;
       end;
  xMod = record
           pos : integer;
           mass : real;
           ModRes, newRes : AnsiChar;
           end;
  tMod5type = array [1..5] of xMod;
  tRangeRec = record
               low, hi : integer;
               end;
  glUserAAdefRec = record
               title : AnsiString;
               data : array [1..maxAA] of real;
               end;
  tRangeR = record
              hi, lo : real;
              end;
  tRangeI = record
              hi, lo : Integer;
              end;
const mgfMax = 100000;

var  appFile  : file_record;
     glDef : globalDefRec;
     workingDir,                //relative - contains current working files
     systemDir,                 //relative - system relevant files (mass etc)
     gpmaIniFile,               //relative - inifile
     baseDir, digestMSdir, glDbMsSearchFile : fNameType;
     glAppDir, glAllUserApp, glAllUserMyDoc, glMyDocDir : fNameType;

     glTempDir : string;
     glMassFile : string;
     aa : aaType;
     pep_decim : integer;          //2/4 decimals
     colours : colour_array;       //1..glColNum (16)
     pModifList, pFixModList : pModifType;  //global modification list
     glCompos : composition_Array;
     glPepPtr : pep_rec_ptr;
     glTransStr : fNameType;
     aa1Hash : array [0..255] of byte;     //hash table for calculating composition
     hilightArray : array [0..2, 1..4] of string;
     glLinkColor : array [0..4] of tColor;
     msgDummy : tMessage;                      //dummy message
     glOfficeStyle : integer;          // tToolBarStyle;
     glUserAAdat : glUserAAdefRec;
     glAutoLoadSeq : boolean;         //load sequence directly in SelASCII
     isWinNT : boolean;               //NT, Vista, Server2008, Win7, server2003, Win2000
     glAMTloaded : boolean;           // Atom Mass Table - value set if non-standard loaded
     glCovImport : ansiString;        //default '0 0 0 0 0'
     glDecimalIsComma : boolean;      //true if decimal = ','
     glErrorList : tStringList;

const glDefCol : colour_array = (clYellow, clLime, clAqua, clRed, clRed, clBlack, clRed,
           clBlue, clGreen, clMaroon, clBlue, clBlack, clBlue, clGreen, clPurple, clTeal);
   snMenu = 15;
  sModName : array [1..snMenu] of str20 = ('Phosphoryl', 'Sulfonyl', 'Oxide',
  'Hydroxide', 'Formyl', 'Methyl', 'Carboxyl', 'Acetyl', 'Biotinyl', 'Farnesyl',
  'Geranylgeranyl', 'Myristoyl', 'Palmitoyl', 'Stearoyl', 'Red. Cys');
  sModComp : array [1..snMenu] of str20 = ('P1O3H1', 'S1O3', 'O1', 'O1',
  'C1O1', 'C1H2', 'C1O2', 'C2H2O1', 'C10H14N2O2S1', 'C15H24', 'C20H32',
  'C14H26O1', 'C16H30O1', 'C18H34O1', 'H1');                          //formyl-methyl
  sModAccept : array [1..snMenu] of str20 = ('STY', 'Y', 'CM', 'PKDN', 'nMKDW', 'nKRDE',
  'DE', 'nK', 'nK', 'C', 'C', 'n','C', '', 'C');


IMPLEMENTATION
uses StrGeneral;
var i : integer;     osVerInfo: TOSVersionInfo;

{-----------------------------------------------------------------------------}

begin
  glAppDir := GetSpecialFolderPath (CSIDL_APPDATA);
  glAllUserApp := GetSpecialFolderPath (CSIDL_COMMON_APPDATA);
  glAllUserMyDoc := GetSpecialFolderPath (CSIDL_COMMON_DOCUMENTS);    //common
  glMyDocDir := GetSpecialFolderPath (CSIDL_PERSONAL);                //personal
  FillChar (glCompos, SizeOf (glCompos), 0);
  glMassFile := 'AA_MASS';
  FillChar (aa1Hash, SizeOf (aa1Hash), 0);
  FillChar (msgDummy, SizeOf (msgDummy), 0);
  FillChar (glUserAAdat, SizeOf (glUserAAdat), 0);
  for i := 1 to Length (aa1) do
    aa1Hash [Ord (aa1 [i])] := i;    //aa1Hash [Ord ('D')] = Pos (chr (SQ. sequence [i]), aa1)
  isWinNT := false;
  osVerInfo.dwOSVersionInfoSize := SizeOf (TOSVersionInfo);
  if GetVersionEx (osVerInfo) then
    if osVerInfo.dwPlatformId = VER_PLATFORM_WIN32_NT then
      isWinNT := true;
  glAutoLoadSeq := false;
  glAMTloaded := false;
end.

