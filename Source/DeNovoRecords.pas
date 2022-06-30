unit DeNovoRecords;

interface
uses Globals, GeneralUtils;

type

{---------- Spectrum records ----------}
  msmsHeaderData = record
    precursorMz, precursorInt, mass: real;
    charge, scanNumber: integer;
    title: string;
  end;

  msmsPeak = record
    mz, int, massDeviation : real;
    mode : integer; // Peak mode (0 = Non, 1 = N-term (b), 2 = C-term (y), 3 = Both N/C-term (b/y))
    mark : string;  // Label for peak
    // Spectrum variables
    peakIdx: integer;
    available: boolean;
    {
    -1: Not existing.
    Idx:
      0 = Basis N-term, 1 = Mod N-term,
      2 = Deconv Basis N-term, 3 = Deconv Mod N-term,
      4 = N-term combined,
      5 = Basis C-term, 6 = Mod C-term,
      7 = Deconv Basis C-term, 8 = Deconv Mod C-term,
      9 = C-term combined.
    }
    intensities: array[0..9] of real;

    // De novo variables
    peakUsage: integer; // 1 = Tag, 2 = Fragment, 4 = Neutral loss, 8 = Immonium
    tempTag: boolean;
    mainTag: boolean;
    tagIdx: array of integer;
    fragmentIdx: array of integer;
    neutralLossIdx: array of integer;
    immoniumIdx: array of integer;
  end;

  msmsSpectrum = array of msmsPeak;

  msmsSpectrumDataFull = record
    headers: array[0..9] of msmsHeaderData;
    spectrum: msmsSpectrum;
  end;

  msmsSpectrumData = record
    header: msmsHeaderData;
    spectrum: msmsSpectrum;
  end;

  msmsSpectrumFile = array of msmsSpectrumData;


  spectraList = record
    basisN: msmsSpectrumData;
    modN: msmsSpectrumData;
    basisC: msmsSpectrumData;
    modC: msmsSpectrumData;

    combinedN: msmsSpectrumData;
    combinedC: msmsSpectrumData;
  end;

{---------- General Records ----------}
  SequencerSettings = record
    basisNSpectrumFile, modNSpectrumFile, basisCSpectrumFile, modCSpectrumFile: string;
    loadedSpectra: array[0..3] of boolean;
    fullSpectrum: msmsSpectrumDataFull;
    nTermDeltaMass, cTermDeltaMass: real;
    nTermMass, cTermMass: real;
    isMaldi: boolean;
    precision: real;
    sequencingMode : integer;
    leuIleEqual: boolean;
    lysGlnEqual: boolean;
    modificationFile: string;
    modifications: PossibleModifications;
    showNMostIntenseCandidates: integer;
  end;

{---------- De Novo Sequencing Records ----------}
  NeutralLossIon = record
    mz, int : real;
    peakIdx, lostFromPeakIdx: integer;
    lossType: integer; // 17 = Ammonia, 18 = Water
    ionType: integer; // 1 = N-term (b), 2 = C-term (y)
    massDeviation: real;
    lostFromAaNum: integer;
    lostFromTerminus: integer; // 0 = Internal loss, 1 = N-term loss, 2 = C-term loss
  end;

  NeutralLossIons = array of NeutralLossIon;

  FragmentIon = record
    mz, int, massDeviation: real;
    peakIdx: integer;
    resIdxs: TArray<integer>;
    resIdxPermutations: TArray<TArray<integer>>; // Permutation Idx - Residue Idx
    matchingFragments: TArray<TArray<integer>>;
  end;

  FragmentIons = array of FragmentIon;

  ImmoniumIon = record
    mz, int, massDeviation: real;
    peakIdx: integer;
    aaNum: integer;

  end;

  ImmoniumIons = array of ImmoniumIon;

  ResidueModification = record
    modification: string;
    position: integer;
    residue: string;
    massChange: real;
    modString: string;
  end;

  ResidueModifications = array of ResidueModification;


  DNSequenceSeriesTag = record
    mainPeakIdx: integer;
    otherMainPeakIdxs: TArray<integer>;
    tempResidues: Residues;
    residues: DeNovoSeqArray;
    tag: SequenceTag;
    internalLength: integer;
    startPeakIdx, endPeakIdx, internStartPeakIdx, internEndPeakIdx: integer;
    massDeviation: real;
    precursorCharge: integer;
    modifications: ResidueModifications;
    sumI: real;
    isNTerm: boolean;
    // Supporting ions
    immonium: ImmoniumIons;
    fragments: FragmentIons;
    neutralLossIons: NeutralLossIons;
    // Scoring
    id: string;
    score: real;
  end;

  DNSequenceSeriesTags = array of DNSequenceSeriesTag;

  DNSequenceTag = record
    // Series
    nTermBasis: DNSequenceSeriesTag;
    nTermMod: DNSequenceSeriesTag;
    cTermBasis: DNSequenceSeriesTag;
    cTermMod: DNSequenceSeriesTag;
    nTermCombined: DNSequenceSeriesTag;
    cTermCombined: DNSequenceSeriesTag;
    // Sequence information
    id: string;
    tag: SequenceTag;
    modifications: ResidueModifications;
    massDeviation: real;
    // Scoring
    score: real;
  end;

  DNSequenceTags = array of DNSequenceTag;

implementation

end.
