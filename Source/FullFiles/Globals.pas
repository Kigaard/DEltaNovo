unit Globals;                   {Global variables for GPMAW v. 13.0}

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
      pepColHeader : array [1..maxPepCol] of string [12] = ('   M2H+  ','   M3H+  ',
                    '   Mass  ','    MH+  ','From-To ',' HPLC ','  B&&B ','  Ch ',      //8
                    '  pI  ', '   M­H   ', '   M4H+  ', '   M2H­  ', ' Add.Mass ',     //13
                    ' Alt.MS  ', '   M5H+  ', '   M6H+  ', '   M7H+  ', '   M8H+  ',   //18
                    '  Av/Mo  ', '   M3H­  ', '   M4H­  ', '   M5H­  ', '   User  ',
                    ' Ext 214 ', ' Ext 205 ');
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

      pgmNameL : string = 'General Protein/Mass Analysis';
      verName : String = '13.01a';
      verNameInt = 1300;
      verDate: String = '28/08/21';        //-> has to be in dd/mm/yy format
      max_seq_len = 10000;
{$IFDEF WIN64}
      pgmNameS : string = 'GPMAW64';
{$ELSE}
      pgmNameS : string = 'GPMAW32';
{$ENDIF}
      maxCleave = 4000;                        //# of saved information
      hugeBuffSize = 512000;
      maxPepMStable = 5000;                     //ms table in digest mass search
      GlSelSeqMsg = 'You have to select a sequence window before using this function';
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

   SortBy : array [1..numSortBy] of String [12] =
                ('Number','Mass', 'HPLC', 'B & B', 'Charge', 'pI', 'Sequence');
   massTypeName : array [1..3] of string [8] = ('Integer', 'Average', 'Monoiso.');
   msTypeColor : array [1..2] of tColor = (clBlue, clRed);
   HydMS : double = 1.007825;                       //approx. mass of a hydrogen ave/mono
   protonMS : real = 1.00727647;
   hydrogenMS : array [1..3] of double = (1.0, 1.00794, 1.007825);  //exact mass of hydrogen
   pITypeText : array [1..4] of String = ('Skoog & Wichman', 'Free aa', 'Rickard, Strohl & Nielsen', '');
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

type pIaa = array [1..4] of real;
//1 - Skoog & Wichman, 1986; 2 - free aa1991; 3 - Rickard, Strohl & Nielsen, 1991
//position is aa1
const pKaN_term : array [0..20] of pIaa = ((9.5, 9.51, 8.08, 8.08), (9.8, 9.85, 8.6, 8.6), {D}
{NTS}             (8.8, 8.82, 7.3, 7.3), (9.1, 9.10, 8.2, 8.2), (9.2, 9.18, 7.3, 7.3),
{EQP}             (9.7, 9.57, 8.2, 8.2), (9.1, 9.13, 7.7, 7.7), (10.6, 10.62, 9.0, 9.0),
{GAV}             (9.8, 9.78, 8.2, 8.2), (9.9, 9.87, 8.2, 8.2), (9.7, 9.68, 8.2, 8.2),
{CMI}             (10.8, 10.40, 7.3, 7.3), (9.3, 9.24, 9.2, 9.2), (9.8, 9.72, 8.2, 8.2),
{LYF}             (9.7, 9.67, 8.2, 8.2), (9.1, 9.11, 7.7, 7.7), (9.2, 9.21, 7.7, 7.7),
{KHW}             (9.0, 9.06, 7.7, 7.7), (9.2, 9.18, 8.2, 8.2), (9.4, 9.42, 8.2, 8.2),
{R}               (9.0, 9.02, 8.2, 8.2));
      pKaC_term : array [0..20] of pIaa = ((2.2, 2.21, 3.13, 3.13), (2.1, 2.02, 2.75, 2.75),
{NTS}             (2.1, 2.06, 2.75, 2.75), (2.1, 2.09, 3.2, 3.2), (2.2, 2.20, 3.2, 3.2),
{EQP}             (2.2, 2.15, 3.2, 3.2), (2.2, 2.17, 3.2, 3.2), (2.0, 1.98, 3.2, 3.2),
{GAV}             (2.4, 2.35, 3.2, 3.2), (2.4, 2.34, 3.2, 3.2), (2.3, 2.30, 3.2, 3.2),
{CMI}             (1.7, 1.93, 2.75, 2.75), (2.1, 2.28, 3.2, 3.2), (2.3, 2.34, 3.2, 3.2),
{LYF}             (2.3, 2.35, 3.2, 3.2), (2.2, 2.20, 3.2, 3.2), (2.2, 2.37, 3.2, 3.2),
{KHW}             (2.2, 2.17, 3.2, 3.2), (1.8, 1.79, 3.2, 3.2), (2.4, 2.40, 3.2, 3.2),
{R}               (2.2, 1.91, 3.2, 3.2));
      //first value of N_term and C_term is average of rest of values
      pKa_Arg : pIaa = (12.5, 12.48, 12.5, 12.5);    pKa_Asp : pIaa = (3.9, 3.82, 3.5, 3.5);
      pKa_Cys : pIaa = (8.3, 8.26, 10.3, 10.3);      pKa_Glu : pIaa = (4.3, 4.18, 4.5, 4.5);
      pKa_His : pIaa = (6.0, 6.08, 6.2, 6.2);        pKa_Lys : pIaa = (10.5, 10.66, 10.3, 10.3);
      pKa_tyr : pIaa = (10.1, 10.11, 10.3, 10.3);
      pIsingleAA : array [0..20] of real =  (0.0, 2.98, 5.44, 5.07, 5.68, 3.08, 5.65, 6.3,
                 6.06, 6.11, 6.0, 5.02, 5.74, 6.04, 6.04, 5.63, 5.91, 9.47, 7.64, 5.88, 10.76);
      RndColLst : array [0..14] of tColor = (clOrange, clRed, clBlue, clLime, clFuchsia,
                   clGreen, clNavy, ClTeal, clPurple, clAqua, clYellow, clMaroon,
                   clOlive, clGray, clFuchsia);
      ChargeCol : array [0..9] of tColor = (clFuchsia, clOrange, clLime, clGreen,
                          clOlive, clPurple, clMaroon, clRed, clYellow, clAqua);
      ChargeCstr : array [0..9] of string = ('clYellow', 'clOrange', 'clLime', 'clGreen',
                   'clOlive', 'clPurple', 'clMaroon', 'clRed', 'clFuchsia', 'clAqua');

//pHcH : array [1..39] of integer = (0, 1, 1, 1, 2, 2, 3, 3, 4, 5, 6, 8, 10, 13, 16, 20, 25,
//         32, 40, 50, 60, 68, 75, 80, 84, 87, 90, 92, 94, 95, 96, 97, 97, 98, 98, 99, 99, 99, 100);
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
      atomArray      = array [0..maxAtom] of longint;      //80 bytes
      aPctArray      = array [1..maxAtom] of real;
      aaRealArray    = array [0..20] of real;
      compos_array   = array [0..maxAA] of atomArray;      //680 bytes
      tagType        = array [0..12] of byte;
      w2array        = array [1..2] of word;
      r5Array        = array [0..4] of real;
      upCharSet      = tSysCharSet; //tAnsiCharSet of 'A'..'Y';
      hugeBuff       = array [0..hugeBuffSize] of ansichar;     {62000}
      pHugeBuff      = ^hugeBuff;
      largeBuff      = array [0..largeBuffSize] of ansichar;    {42000}
      pLargeBuff     = ^largeBuff;
      smallBuff      = array [0..smallBuffSize] of ansichar;    {12000}
      pSmallBuff     = ^smallBuff;
      colour_array   = array [1..glColNum] of longint;
      pComposition   = ^composition_array;
      composition_array = array [0..21] of integer;         {44/88 bytes}
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
      modres_type    = record                      // ~86 bytes
                         name, compStr : shortString;
                         mass : massType;          //real array 1=int, 2=ave, 3=mono
                         pKa : real;
                         pos, charge : integer;           //charge: -1, 0, +1
                         terminal : byte;                 //1= N-term; 2 = C-term; 4 = variable
                       end;
      modResArray    = array [1..maxModRes] of modres_type;       // -> 1..32
      termResArray   = array [1..2] of modRes_type;
      termStrArray   = array [0..maxTerm] of str20;              {0..12}
      termType       = array [0..maxTerm] of modres_type;
      hyXTblType     = array [0..21] of byte;        //table of exchangeable hydrogens
      ssBridgeType   = array [1..2, 1..maxLinks] of word;      //maxLinks = 40
      pSeq_record    = ^seq_record;
      seq_record     = record                                  //21.256
                         sequence, mode : seq;                 //1..10000 of byte
//mode: bit 0,1,2 = hilight res.;3 = Underline;4 = modified; 5,6,7= chain number
                         seqname, seqID : shortString;        //accession number
                         start, maxseq, numChains, offset : integer;
                         flags   : word;
//bit 0 = modified res.; 1 = SSbridges
                         modified  : modResArray;          //1..maxModRes 32 of modrestype
                         terminals : termResArray;         //N- & C-terminals
                         cleaveList : cleave_arr;          //1..4000 of smallint
                         SSbridges : ssBridgeType;         //1..40; 120 byte
                         MultiLink : array [1..3] of word;
                         chainList : array [1..maxChains + 1] of integer;     //8 chains total
                         chainChr : string [maxChains + 1];
                         changed   : boolean;
                         colRList  : packed array [0..100] of smallInt;  //0=number of col.res.
                         varMod : pSimpleMod;
                       end;
      pep_rec_ptr    = ^peptide_rec;
      peptide_rec    = record                                //156 bytes
                         start, slut   : integer;
                         number, part  : integer;        //peptide number; number of partials
                         HPLCindex, pI, charge, user : real;   //mono Mr, HPLC ret.time, user-defined value
                         mol_wgt : massType;             //1=int, 2=ave, 3=mono
                         bb_index, meekNdx,              //Bull & Breeze index
                         ext214, ext205 : longint;               //extinction coeff 214
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
      printer_record = record
                         lMargin, tbMargin,               //left, top/bottom margin
                         lh6, lh4, lh10,                  //1/6", 1/4" & 1/10"linefeed
                         xResol, yResol,                  //resolution in pixels/inch
                         ch1w, ch3w, ch4w, ch1h,          //width of 1, 3 and 4 characters
                         linX, linY, pageNum : integer;   //present x and y position
                       end;
      tProtInfo    = record
                       MSav, MSmo, extin, gravy : real;
                       pI : array [1..3, 0..1] of real;      //type, SS state ss=0 sh=1
                       ext280, ext205 : array [0..1] of real;
                       compos : composition_array;
                     end;
      tPepInfo     = record
                       pepSeq, modifs : string;
                       msTh, msExp, HPLC, HPLCExp, delta, sumInt : real;
                       charge, miss, b, y, totFrag : integer;
                       compos : composition_array;
                     end;
      tPepInfoArr  = array of tPepInfo;
      GlobalDefRec = record                              //glDef
                       default,
// bit set: 0 Highlight global; 1 Keep highlight; 2 Search global; 3 : search multicharged}
// 5 show toolbox; 6 show ribbon; 7 Menu grayed; 8 Internal editor; 9 : ask for exit
// 10 : auto load seq; 11 autoSize forms; 12 edit seq use all residues; 13 no report decim. grp.}
                       disp : word;
// bit set: 0 3-letter code; 2 monoiso mass display, 3 reduced Cys; 4 mass tracking,
// 5 font courier; 8 omit print modif; 9 print ext.info; 10 2x line spacing; 11 tab in table;
// 12 full seq in table; 13 Expanded seq display; 14 diff as ppm; 15 limit seq disp mod 5
//FREE Mass search short display
                       pepDisp : longint;
//bit 0 to 6 are not used any more
// 0 integer; 1 average; 2 monoiso; 3 compos; 4 HPLC; 5 B&B; 6 def. 1 overlap;
// 8 3-lett. disp.; 9 cleave shortlst; 10..13 sort by number; 14 : disp monoiso.
// 15 : print ext.info; 16 : 4 decimals; 17 . 6 decimals;
                       extDisp : integer;
//0 pepMSres mass list; 1 mass graph; 2 show all modif;3 closing Win size;
//4,5 auto refresh; 6 Absorbance Page; 7 Open seq sorted; 8 save mass file info
//9 : use single ms/ms window; 10: color multichain sequence window
                       msmsDspMode, barStyle : integer;
                       pepColDisp, altPepColDisp : AnsiString;
// pepColDisp: 4bit/value e.g. M2H+, M3H+, mass, MH+, From-To, HPLC, B&B, charge, pI
                       advanced, LowMScutoff : longint;
// bit 0,1: pInormal,free aa, modified, RS&N; 2: maximized, 3: Minimized, 4: num10seq
// 5,6,7,8: frames seqwin, ms/ms win, ms search, "reserved"
// 9: fit height to seq
//14,15 FastA header
                       msSrchMode : longWord;
//bit1: ppm; bit2: %; bit3: Da
                       seqTagMode : longWord;
//bit0-15: precis * 1000; bit16: Mo; bit17: short form;bit 18 : sync seq
                       compMSmode : longWord;
//bit0-15: precis * 1000; bit16: Mo; bit17: short form;bit 18 : sync seq
                       searchTol, peptideAddMs : real;
//search tolerance; mass to add to peptides in peptide table
                       altPepMsFile : str20;
                       altPepMsState, altPepNCTerm : byte;
//alternate file for mass calc. in peptide table
                       MenuPersistent : boolean;
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
                 pKaVal : array [0..maxAA] of real;
                 pKaCharge : array [0..maxAA] of integer; //-1, 0, +1
               end;
      modifRecord = record                             {88 bytes}
                      name, formula, valResStr : string;
                      enabled, massOnly : boolean;
//                      compos : atomArray;              //array 1..maxAA of integer
                      ave, mono, pKa : real;
                      charge : integer;                //0, 1, 2 (2 = +1 charge)
                      validRes : upCharSet;            //has to be 'A'..'Y'
                      terminal : integer;                 //1= N-term; 2 = C-term
                    end;
      tModifRecArr = array [1..maxDBmodif] of modifRecord;
      pModifType = ^ModifType;
      ModifType = record                               {2723 bytes}
                    dBase : tModifRecArr;         {1..30 maxDBmodif; 3520 bytes}
                    shortFName : string;                //just file name
                    longFname : fNameType;             //full path file name
                    tableMax : integer;
                  end;
  pepMSrec = record                       //72 byte - from the mass search dialog
               mass, height, precis : real;
               intMass : longint;        //mass Da * 1000
               enabled : boolean;
               sType : AnsiChar;         //C : composition; S : sequence; N : N-terminal
               msType : byte;            //1 = ave; 2 = mono
               intTable : array [1..2] of longint;   //lower and upper bounds (mass *1000)
               pepSeq : str12;
               pepPrc : longint;         //precision of search data (Da. * 1000)
               charge, msmsNdx, titleNdx : integer;
             end;
  pPepMassTable = ^tPepMassTable;
  tPepMassTable = array [1..maxPepMStable] of pepMSrec;        //msPeakType
  pMSsearchRec = ^MSsearchRec;
  MSsearchRec = record                                         //36.000 + 344 bytes
                  table : tPepMassTable;                       //[1..5000]
                  msMode : word;
//0 : M-H; 1 : M + H; 2 : monoiso; 3 : multicharge;4 chk enzyme fit;5 modif. mixed mode search;
//6 Enzyme fit group; 7 search cross chain
//HiByte := number of charges
                  precis : real;
                  modifDb, limitPep, maxModif, lastTbl, mono2AveMs : integer;
                  info : str40;
                  massFile : shortString;
                  msFileType : integer;
                  ModSelect : array [0..29] of boolean;
                end;
//digest mass search
  pDigestSearchData = ^tDigestSearchData;
  tDigestSearchData = record                              //8963 bytes
          low, high, monoMSpoint : longint;
          minHits, overlap, tableMax, sMode, digMode : word;
  //sMode: bit0 : seq/compos present; bit1: report pI; bit2: autoload massfile
  //       bit4 : replace index files
  //digMode: bit0-1 : print #pages; bit2 : database present; bit3 : save report
  //bit4: multidigest run; bit5: massfile changed; 
          optimiz : integer;   //bit0-2: overlaps;bit3 : lin. fit; bit4: tryp PMS fit
          scPrc2, scPrc4, scSequence, scCompos : integer;
          scoreMode, ionType, tagNum : byte;              //ionType 0=M-H,1=H,2=M+H
          scOverlap : array [0..5] of integer;
          modifFile : shortString;
          precision, minPrc : real;
          info : shortString;
          seqTag : array [1..4] of str12;                 //sequence tags
          dataFile : String;                              //digest database (.DA2)
          searchTable : tpepMassTable;
          pass, EnzymeNum : integer;
        end;                   //mass:real; enabled:boolean; sType : char; seqStr:str12;
  tMSMStable = array [1..maxMSMS] of real;             //400 -  3200 bytes

  VerInfoType = record
         version, year, month, age : longint;       //age of version in month
         licenseDate, compileDate : tDateTime;        //tStDate;
         regNum : string [8];
         supplier : string [16];
         unlim, site, demo : boolean;
         licName : string;
       end;
  UpgVerInfoType = record
         upInfo : VerInfoType;
         version, posted : AnsiString;
         altURL, info, Error, URLinfo : AnsiString;
         infoNum : integer;
       end;
  extOpType = record                                //used in peptide generation
         mode, loCount, hiCount : word;
         lowMS, hiMS : longint;
       end;
  linkResType = array [1..2] of integer;             //0=Acid;1=Amine;2=Sulfhydryl;
  xLinkRec = record                               //3=Tyrosine; 4=amide
               name : str20;
               linkRes : linkResType;       //0:Carb.Ac. 1:Amine 2:Cys 3:Tyr 4:Amide
               linkType : integer;          //1=zero length;2=homobifunc;3=heterobifunc.
               xLink, nonLink, redLink : str20;   //compositions
             end;
  xLinkTbl = record
               links : array [1..xLinkMax] of xLinkRec;
               count : integer;
             end;
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
  proxyRec = record
               UseProxy, BasicAuth, NoPassword : boolean;
               password, serverName, userName : AnsiString;
               port : integer;
             end;
  HPLCconType = record
                  T0, DT, P, Q, E, F, G, b : real;
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
  tEnzymeStr = array [1..maxEnzNum] of str32;     //1..15
const CSmax = 14;         mgfMax = 100000;
      CSdef : array [1..2, 1..CSmax] of integer = ((1, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 1, 2),
                                              (2, 13, 0, 0, 0, 0, 4, 2, 3, 1, 10, 13, 14, 29));
      cSugar = 'NhxHexFucSia';
      csMass : array [1..4] of real = (146.05791, 162.05282, 203.07937, 291.09542);
      csName : array [1..4] of string = ('146', '162', '203', '291');
      csTxName : array [1..4] of string = ('Fuc', 'Hex', 'Nhx', 'Sia');
var  appSeq   : pSeq_record;                      //global variables
     appFile  : file_record;
     glDef : globalDefRec;     //globalDef, globalDsp : word; globalPeptideDsp : longint;
     cleaveName : tEnzymeStr;
     cleaveCondition : tEnzymeStr;
     fastFile : array [1..9] of AnsiString;
     UserFile : array [0..5] of AnsiString;
     UserRunMode : byte;
     startupDir,                //absolute - directory of GPMAW
     workingDir,                //relative - contains current working files
     systemDir,                 //relative - system relevant files (mass etc)
     gpmaIniFile,               //relative - inifile
     baseDir, digestMSdir, glDbMsSearchFile : fNameType;
     glBlastDir, glXTandemDir, glClustalDir : fNameType;        //externam program directories
     glAppDir, glAllUserApp, glAllUserMyDoc, glMyDocDir : fNameType;
     CURLaddress : fNameType;
     glTempDir : string;
     glMassFile : string;
     aa : aaType;
     pep_decim : integer;          //2/4 decimals
     colours : colour_array;       //1..glColNum (16)
//hilight 1, 2, 3, 4; 5= pre-post AA; 6 = AA text; 7..10 = graph 1..4; 11 mark10; 12 aux; 13-16 dot 1-4
     glSeqPtr1, glSeqPtr2 : pSeq_record;    //used when creating daughter windows
     pModifList, pFixModList : pModifType;  //global modification list
     msSearchData : pMSsearchRec;           //peptide mass search data
     glCompos : composition_Array;
     glPepPtr : pep_rec_ptr;
     glMSsearchData, glRepeatMSsearch : pDigestSearchData;
     glPepMassTbl : tPepMassTable;
     glSSstate : byte;                     //0 = SS; 1 = SH; 2 = undefined
     glDBselect : word;                    //0=auto; 1 = company
     glVerInfo : verInfoType;
     upgVerInfo : UpgVerInfoType;
     glTransStr : fNameType;
     aa1Hash : array [0..255] of byte;     //hash table for calculating composition
     glHyXTbl : hyXTblType;                //hydrogen exchange table
     glHyXav, glHyXmo : double;       //value of hydrogen exchange atom, deuterium=2.0140
     fastAdbName : array [0..5, 1..2] of string; //0:Swiss-Prot;1-5 fastA;1=main, 2= update
     hilightArray : array [0..2, 1..4] of string;
     glGPMAWinfoStr : String;
     demoVersion : integer = -2;              //demo version - start value
//-1 = run count exceeded; 0 = standard;  1 = first run in limited, 2 = run number limited
     LimitedVersion : integer = 0;              //0 = unlimited; 1 = limited;
     DebugValue : integer = 0;
     glProxySet : proxyRec;
     glHPLCparam : HPLCconType;
     glLinkColor : array [0..4] of tColor;
     msgDummy : tMessage;                      //dummy message
     glMSMSprintMode : word;
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
  glHPLCret : aaRealArray = (0.01, 0.1, -0.45, 0.12, 0.18, 0.27, 0.36, 0.48,
     0.22, 0.13, 0.38, 1.57, 0.85, 1.38, 1.34, 1.23, 1.71, 0.05, 0.34, 2.34, 0.26);
  LocalRunMode = 0;      ManagedRunMode = 1;      ApplicatRunMode = 2;
  MyDocRunMode = 3;      PublicDocRunMode = 4;
//ini in gpmaw\bin       glAppDir (users\[user]\AppData\Roaming
//                       Application data\gpmaw  Like 2, but data in My Documents

IMPLEMENTATION
uses StrGeneral;
var i : integer;     osVerInfo: TOSVersionInfo;

{-----------------------------------------------------------------------------}

begin
  userRunMode := localRunMode;
  glAppDir := GetSpecialFolderPath (CSIDL_APPDATA);
  glAllUserApp := GetSpecialFolderPath (CSIDL_COMMON_APPDATA);
  glAllUserMyDoc := GetSpecialFolderPath (CSIDL_COMMON_DOCUMENTS);    //common
  glMyDocDir := GetSpecialFolderPath (CSIDL_PERSONAL);                //personal
  if not DirectoryExists (glMyDocDir + 'gpmaw') then
    CreateDir (glMyDocDir + 'gpmaw');
  if not DirectoryExists (glMyDocDir + 'gpmaw\temp\') then
    CreateDir (glMyDocDir + 'gpmaw\temp');
  glTempDir :=  '';  //in common documents
  FillChar (glCompos, SizeOf (glCompos), 0);
  gpmaIniFile := 'GPMAW.INI';
  glMassFile := 'AA_MASS';
  glMSMSprintMode := 1;
  FillChar (glVerInfo, SizeOf (glVerInfo), 0);
  FillChar (upgVerInfo, SizeOf (upgVerInfo), 0);
  glVerInfo.demo := true;
  New (glMSsearchData);
  FillChar (glMSsearchData^, SizeOf (glMSsearchData^), 0);
  New (glRepeatMSsearch);
  FillChar (glRepeatMSsearch^, SizeOf (glRepeatMSsearch^), 0);
  FillChar (glPepMassTbl, SizeOf (glPepMassTbl), 0);
  FillChar (aa1Hash, SizeOf (aa1Hash), 0);
  FillChar (msgDummy, SizeOf (msgDummy), 0);
  FillChar (glUserAAdat, SizeOf (glUserAAdat), 0);
  for i := 1 to Length (aa1) do
    aa1Hash [Ord (aa1 [i])] := i;    //aa1Hash [Ord ('D')] = Pos (chr (SQ. sequence [i]), aa1)
  with glHPLCparam do
  begin
    T0 := 1.3;   DT := 2.0;   P := 6.79;  Q := 28.24;  E := 2.02;  F := -0.76;
    G := -0.40;  b := 0.0167;
  end;
  isWinNT := false;
  osVerInfo.dwOSVersionInfoSize := SizeOf (TOSVersionInfo);
  if GetVersionEx (osVerInfo) then
    if osVerInfo.dwPlatformId = VER_PLATFORM_WIN32_NT then
      isWinNT := true;
  glAutoLoadSeq := false;
  glAMTloaded := false;
end.

