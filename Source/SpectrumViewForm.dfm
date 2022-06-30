object SpectrumView: TSpectrumView
  Left = 0
  Top = 0
  Caption = 'MS MALDI sequencer - Spectrum view'
  ClientHeight = 845
  ClientWidth = 1461
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object RightPanel: TAdvPanel
    Left = 1315
    Top = 0
    Width = 146
    Height = 845
    Align = alRight
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    UseDockManager = True
    Version = '2.6.0.0'
    BorderColor = clBlack
    Caption.Color = clHighlight
    Caption.ColorTo = clNone
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -11
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 0
    Caption.ShadeLight = 255
    CollapsColor = clNone
    CollapsDelay = 0
    DoubleBuffered = True
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clNone
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWindowText
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = clWhite
    StatusBar.GradientDirection = gdVertical
    Text = ''
    FullHeight = 200
    object RightPageCtrl: TAdvPageControl
      Left = 0
      Top = 0
      Width = 146
      Height = 845
      ActivePage = DeNovoTab
      ActiveFont.Charset = DEFAULT_CHARSET
      ActiveFont.Color = clWindowText
      ActiveFont.Height = -11
      ActiveFont.Name = 'Tahoma'
      ActiveFont.Style = []
      Align = alClient
      DoubleBuffered = True
      TabBackGroundColor = clBtnFace
      TabMargin.RightMargin = 0
      TabOverlap = 0
      Version = '2.0.3.0'
      PersistPagesState.Location = plRegistry
      PersistPagesState.Enabled = False
      TabOrder = 0
      object DeNovoTab: TAdvTabSheet
        Caption = 'Seq. tag'
        Color = clWhite
        ColorTo = clSilver
        TabColor = clBtnFace
        TabColorTo = clNone
        DesignSize = (
          138
          817)
        object HelpLbl: TLabel
          Left = 4
          Top = 452
          Width = 125
          Height = 26
          Caption = 'Click Ctrl+left/right arrow key to extend sequence'
          WordWrap = True
        end
        object Label2: TLabel
          Left = 4
          Top = 496
          Width = 73
          Height = 13
          Caption = 'Trim sequence:'
        end
        object SequenceBtn: TAdvToolButton
          Left = 4
          Top = 383
          Width = 126
          Height = 19
          Hint = 'Click to highlight sequence peaks'
          AutoThemeAdapt = False
          BorderColor = clSilver
          BorderDownColor = 14925219
          BorderHotColor = 16444643
          Color = 14540253
          ColorDown = 14925219
          ColorHot = 16444643
          ColorChecked = 13744549
          DropDownButton = True
          DropDownMenu = BackupSeqPop
          Caption = '&Sequence'
          ParentShowHint = False
          ShowHint = True
          Version = '1.7.2.0'
          TMSStyle = 0
        end
        object Label6: TLabel
          Left = 4
          Top = 231
          Width = 73
          Height = 13
          Caption = 'Show spectrum'
        end
        object Label1: TLabel
          Left = 4
          Top = 122
          Width = 57
          Height = 13
          Caption = 'Show peaks'
        end
        object LimitPeaksTrack: TAdvTrackBar
          Left = 3
          Top = 13
          Width = 131
          Height = 50
          BorderColor = clNone
          BorderColorDisabled = clNone
          Buttons.BorderColor = 11250603
          Buttons.BorderColorHot = 15917525
          Buttons.BorderColorDown = 14925219
          Buttons.Color = clWhite
          Buttons.ColorTo = clWhite
          Buttons.ColorHot = 15917525
          Buttons.ColorHotTo = 15917525
          Buttons.ColorDown = 14925219
          Buttons.ColorDownTo = 14925219
          Buttons.ColorMirror = clNone
          Buttons.ColorMirrorTo = clNone
          Buttons.ColorMirrorHot = clNone
          Buttons.ColorMirrorHotTo = clNone
          Buttons.ColorMirrorDown = clNone
          Buttons.ColorMirrorDownTo = clNone
          Buttons.GradientMirror = ggVertical
          ColorTo = clNone
          ColorDisabled = clNone
          ColorDisabledTo = clNone
          Direction = gdHorizontal
          Color = 15724527
          Max = 1000
          Min = 50
          PageSize = 10
          Position = 1000
          Slider.BorderColor = 12752500
          Slider.BorderColorDisabled = clBlack
          Slider.Color = clWhite
          Slider.ColorTo = clBlack
          Slider.ColorDisabled = clBlack
          Slider.ColorDisabledTo = clBlack
          Slider.ColorCompleted = clNone
          Slider.ColorCompletedTo = clNone
          Slider.ColorCompletedDisabled = clNone
          Slider.ColorCompletedDisabledTo = clNone
          Slider.Direction = gdHorizontal
          TabOrder = 0
          Thumb.BorderColor = 10317632
          Thumb.BorderColorHot = 10079963
          Thumb.BorderColorDown = 4548219
          Thumb.BorderColorDisabled = clBlack
          Thumb.Color = 15653832
          Thumb.ColorTo = 16178633
          Thumb.ColorDown = 7778289
          Thumb.ColorDownTo = 4296947
          Thumb.ColorHot = 15465983
          Thumb.ColorHotTo = 11332863
          Thumb.ColorDisabled = clBlack
          Thumb.ColorDisabledTo = clBlack
          Thumb.ColorMirror = 15586496
          Thumb.ColorMirrorTo = 16245200
          Thumb.ColorMirrorHot = 5888767
          Thumb.ColorMirrorHotTo = 10807807
          Thumb.ColorMirrorDown = 946929
          Thumb.ColorMirrorDownTo = 5021693
          Thumb.ColorMirrorDisabled = clBlack
          Thumb.ColorMirrorDisabledTo = clBlack
          Thumb.Gradient = ggVertical
          Thumb.GradientMirror = ggRadial
          Thumb.Shape = tsTriangle
          TickMark.Color = clBlack
          TickMark.ColorDisabled = clBlack
          TickMark.Font.Charset = DEFAULT_CHARSET
          TickMark.Font.Color = clWindowText
          TickMark.Font.Height = -11
          TickMark.Font.Name = 'Tahoma'
          TickMark.Font.Style = []
          TrackHint = False
          TrackLabel.Visible = True
          TrackLabel.Font.Charset = DEFAULT_CHARSET
          TrackLabel.Font.Color = clWindowText
          TrackLabel.Font.Height = -11
          TrackLabel.Font.Name = 'Tahoma'
          TrackLabel.Font.Style = []
          TrackLabel.Format = 'Number: %d'
          Transparent = False
          Version = '1.7.2.3'
          OnChange = LimitPeaksTrackChange
        end
        object NewSequenceBtn: TAdvGlowButton
          Left = 5
          Top = 408
          Width = 57
          Height = 22
          Hint = 'Clear de-novo sequence and add a new sequence'
          Caption = 'Ne&w'
          Default = True
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          Picture.Data = {
            424D4E0100000000000076000000280000001200000012000000010004000000
            0000D80000000000000000000000000000000000000000000000000080000080
            00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
            000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0066666666666666666600
            00006666666666666666660000006FF6FF666666666666000000FFFFFFFF6666
            666666000000FFFFFF711166666666000000FFFFF7911116666666000000FFFF
            F9191111666666000000FF6F61999111066666000000F6666919191070666600
            00006666669191038706660000006666666910BB387066000000666666663BF8
            B387060000006666666663BF8B303000000066666666663BFB03330000006666
            66666663B38B3300000066666666666638BBB300000066666666666663FBBB00
            0000666666666666663FBB000000}
          Rounded = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = NewSequenceBtnClick
          Appearance.BorderColor = 11382963
          Appearance.BorderColorHot = 11565130
          Appearance.BorderColorCheckedHot = 11565130
          Appearance.BorderColorDown = 11565130
          Appearance.BorderColorChecked = 13744549
          Appearance.BorderColorDisabled = 13948116
          Appearance.Color = clWhite
          Appearance.ColorTo = clWhite
          Appearance.ColorChecked = 13744549
          Appearance.ColorCheckedTo = 13744549
          Appearance.ColorDisabled = clWhite
          Appearance.ColorDisabledTo = clNone
          Appearance.ColorDown = 11565130
          Appearance.ColorDownTo = 11565130
          Appearance.ColorHot = 16444643
          Appearance.ColorHotTo = 16444643
          Appearance.ColorMirror = clWhite
          Appearance.ColorMirrorTo = clWhite
          Appearance.ColorMirrorHot = 16444643
          Appearance.ColorMirrorHotTo = 16444643
          Appearance.ColorMirrorDown = 11565130
          Appearance.ColorMirrorDownTo = 11565130
          Appearance.ColorMirrorChecked = 13744549
          Appearance.ColorMirrorCheckedTo = 13744549
          Appearance.ColorMirrorDisabled = clWhite
          Appearance.ColorMirrorDisabledTo = clNone
          Appearance.GradientHot = ggVertical
          Appearance.GradientMirrorHot = ggVertical
          Appearance.GradientDown = ggVertical
          Appearance.GradientMirrorDown = ggVertical
          Appearance.GradientChecked = ggVertical
          Appearance.TextColorChecked = 3750459
          Appearance.TextColorDown = 2303013
          Appearance.TextColorHot = 2303013
          Appearance.TextColorDisabled = 13948116
          DropDownSplit = False
        end
        object CopySeqBtn: TAdvGlowButton
          Left = 68
          Top = 408
          Width = 66
          Height = 22
          Hint = 'Clear de-novo sequence'
          Caption = 'Copy'
          Default = True
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          Picture.Data = {
            424D360500000000000036040000280000001000000010000000010008000000
            0000000100000000000000000000000100000001000000000000010101000202
            0200030303000404040005050500060606000707070008080800090909000A0A
            0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F0010101000111111001212
            1200131313001414140015151500161616001717170018181800191919001A1A
            1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F0020202000212121002222
            2200232323002424240025252500262626002727270028282800292929002A2A
            2A002B2B2B002C2C2C002D2D2D002E2E2E0033303000383232003C3433004135
            350045373600483838004C3939004F3A3A00523B3B00563D3C005A3E3D005D3E
            3E00613F3F0064403F0067404000694140006A4140006C4140006D4141006E42
            41006E4241006F4241006F424100704241007142410072424100724341007343
            42007544430076464400784745007B4946007D4B4700814F4A0085524C008955
            4E008D595100925D540096605600996357009C6559009E685B00A0695C00A16B
            5D00A26C5E00A26D5F00A16C5E00A16C5E00A16C5E00A06B5E00A06A5D009F69
            5D009F695C009E685C009D675C009B665B009A655B0099645B0098635A009662
            5A0094615A0092605A00905F59008F5E59008F5E59008E5E59008C5E59008B5E
            5A00895F5B0086605D0085615F008464610083676500826B6900826C6A00826D
            6C00826F6D0082716F0082737100827574008277760082797900827C7C00827F
            7F00838383008484840085858500927F8C009F7A9300A9749A00B967A700C55B
            B200D04FBC00D846C500E238D000E92ED900EF22E300F516EC00F90EF300FB09
            F700FD05FA00FD03FC00FE01FD00FE01FE00FE00FE00FE00FE00FE00FE00FE00
            FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
            FE00FE00FE00FE00FE00FF00FF00FE00FE00FE00FE00FE00FE00FE00FE00FE00
            FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
            FE00FE00FE00FE01FE00FE02FD00FE03FC00FD06FA00F912F000F326DD00ED3A
            CB00E74DBB00E25EAD00DE6AA300D97A9500D6848B00D38E8600CF968500D197
            7A00D2977300CF957100CC926F00CB916E00CA8F6E00C98E6D00C88D6C00C98E
            6C00CB8F6C00CC8F6B00CE906B00D0916B00D1926800D4915F00D6905700D88E
            4C00DA8E4400DB8E3E00DC8E3C00DC8E3B00DC8E3A00DD8E3B00DD903D00DD91
            3E00DD913F00DE924000DF944300E1974500E2994700E39A4900E39B4B00E49E
            5100E6A35A00E9A86200EDAF6D00F0B57600F5BD8400F8C48F00FAC99800FCCE
            9F00FDD1A600FED5AC00FED7B000FED9B300FDDBB900FDDDBE00FCDEC000FADE
            C300F9DFC700F8E2CE00F8E4D200F8E8D800FAEBDE00FBEEE200FCF1E600FDF4
            EB00FDF6EE00FEF8F100FEF9F500FEFAF700FEFAF700A5A5A5A5A57070707070
            7070707048A5A5A5A5A5A56CF0EEECEBEAE9E8E848A5A5A5A5A5A566F3D9D9D9
            D9D9D9E948A5A5A5A5A5A55DF6F4F1EFEDECEAEA48A570707070705CF8D9D9D9
            D9D9D9EB48A56CF0EEECEB5CF9F8F6F5F3F0EEEC48A566F3D9D9D9C9FCD9D9D9
            D9D9D9EF48A55DF6F4F1EFC9FEFCFAF9F7F6F4F148A55CF8D9D9D9C5FFFFFCFB
            F9F4C18748A55CF9F8F6F5C3FFFFFFFDFB58585857A5C9FCD9D9D9C3FFFFFFFF
            FE58E2D7A5A5C9FEFCFAF9E4CECECECECE58E0A5A5A5C5FFFFFCFBF9F4C18748
            A5A5A5A5A5A5C3FFFFFFFDFB58585857A5A5A5A5A5A5C3FFFFFFFFFE58E2D7A5
            A5A5A5A5A5A5E4CECECECECE58E0A5A5A5A5A5A5A5A5}
          PopupMenu = DNSeqCopyTypePop
          Rounded = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Appearance.BorderColor = 11382963
          Appearance.BorderColorHot = 11565130
          Appearance.BorderColorCheckedHot = 11565130
          Appearance.BorderColorDown = 11565130
          Appearance.BorderColorChecked = 13744549
          Appearance.BorderColorDisabled = 13948116
          Appearance.Color = clWhite
          Appearance.ColorTo = clWhite
          Appearance.ColorChecked = 13744549
          Appearance.ColorCheckedTo = 13744549
          Appearance.ColorDisabled = clWhite
          Appearance.ColorDisabledTo = clNone
          Appearance.ColorDown = 11565130
          Appearance.ColorDownTo = 11565130
          Appearance.ColorHot = 16444643
          Appearance.ColorHotTo = 16444643
          Appearance.ColorMirror = clWhite
          Appearance.ColorMirrorTo = clWhite
          Appearance.ColorMirrorHot = 16444643
          Appearance.ColorMirrorHotTo = 16444643
          Appearance.ColorMirrorDown = 11565130
          Appearance.ColorMirrorDownTo = 11565130
          Appearance.ColorMirrorChecked = 13744549
          Appearance.ColorMirrorCheckedTo = 13744549
          Appearance.ColorMirrorDisabled = clWhite
          Appearance.ColorMirrorDisabledTo = clNone
          Appearance.GradientHot = ggVertical
          Appearance.GradientMirrorHot = ggVertical
          Appearance.GradientDown = ggVertical
          Appearance.GradientMirrorDown = ggVertical
          Appearance.GradientChecked = ggVertical
          Appearance.TextColorChecked = 3750459
          Appearance.TextColorDown = 2303013
          Appearance.TextColorHot = 2303013
          Appearance.TextColorDisabled = 13948116
          DropDownButton = True
          DropDownSplit = False
          DropDownMenu = DNSeqCopyTypePop
        end
        object NoLowMassLabelChk: TAdvOfficeCheckBox
          Left = 3
          Top = 96
          Width = 113
          Height = 20
          Hint = 'Remove bottom 25%'
          ShowHint = True
          TabOrder = 3
          OnClick = NoLowMassLabelChkClick
          Alignment = taLeftJustify
          Caption = 'No low mass labels'
          ReturnIsTab = False
          Version = '1.8.0.5'
        end
        object LimitPeaksChk: TAdvOfficeCheckBox
          Left = 4
          Top = 3
          Width = 88
          Height = 20
          Hint = 'Limit number of peaks'
          Checked = True
          ShowHint = True
          TabOrder = 4
          OnClick = LimitPeaksChkClick
          Alignment = taLeftJustify
          Caption = 'Limit # peaks'
          ReturnIsTab = False
          State = cbChecked
          Version = '1.8.0.5'
        end
        object TrimSeqNBtn: TAdvGlowButton
          Left = 4
          Top = 515
          Width = 57
          Height = 22
          Hint = 'Trim N-terminus of sequence'
          Caption = ' &N-'
          Default = True
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          Picture.Data = {
            424D360500000000000036040000280000001000000010000000010008000000
            0000000100000000000000000000000100000001000000000000010101000202
            0200030303000404040005050500060606000707070008080800090909000A0A
            0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F0010101000111111001212
            1200131313001414140015151500161616001A1717002A1B1800391D1A00401E
            1A0047201B004B211B004F211B0052231B0056251A005B2719005E281800602A
            1800622C1900642F1B006B371F007A4526008C552E009C613400AB6D3C00B878
            4300C7844900D18A4D00D68E4F00DB925100DD945200DF955300E1975500E299
            5700E39B5900E39C5D00E39A5800E3995600E2975300E0945000E0934F00E092
            4D00DF914B00DF8F4800DE8D4600DE8C4400DE8A4100DD893F00DC863C00DA83
            3900D77E3300D47A2F00D1762B00D1732700CB6E2400C5681F00BB601B00B359
            1800A64F15009C48130093421100893C11008539100082370F007F350F007E34
            0F007D340F007D330F007E340E007F340E0081350D0083350C0084360C008636
            0B0088370B008C390A00913A0900953C0800983E08009B3F07009E400600A041
            0500A3410500A5420400A8420300AC430200AF430100B2440100B4440100B646
            0000B8470000B9480000BA490000BB4A0000BC4A0000BD4C0100BF4D0100C04F
            0200C1500200C2510200C2510300C1520400C0530600BE540900BA550E00B358
            1900A4613300916D540084776D00817A76007F7F7F0080808000818181008282
            8200838383008484840085858500868686008787870088888800898989008A8A
            8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F0090909000919191009292
            9200939393009494940095959500969696009C999700A29D9900ACA39B00B6A8
            9C00BEAD9D00C5B19E00CDB49C00D5B79B00DEBA9900E7BE9800EBC19900EFC3
            9B00F1C59B00F2C59B00F3C69C00F2C49800F1C29500F1C09200F0BE8F00F0BD
            8E00EFBC8D00EFBC8C00EFBB8B00EEBA8A00EEB88500ECB68300EBB58200EAB7
            8700EAB98B00E7BA9000E4BB9500E0BD9C00DABEA300D5BFAA00D0BFAF00CBBE
            B200C7BDB500C1BDB900BFBDBB00BEBEBE00C2C0BF00C5C3C000C8C4C000CBC6
            C100CDC7C200CEC9C300CFC9C300D3CDC700D5D0CA00DBD6D000E0DBD500E3DF
            DB00E6E4E100E9E9E900EFEEED00F2F1F000F5F4F300F7F6F500F9F8F800FAFA
            FA00FCFCFC00FDFDFD00FDFDFD00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
            FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
            FD00FEFDFC00FEFCFB00FEFCFA00FEFCFA00FEFBFA00FEFBFA00FEF9FA00FEF3
            FA00FEE8FB00FED6FC00FEBCFD00FE9DFD00FE6CFD00FE42FE00FE26FE00FE13
            FE00FE07FE00FE02FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
            FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FAFAFAFAFA1C1E22221E
            1CFAFAFAFAFAFAFAFA1F2260686E6F6961231CFAFAFAFAFA215D7372716F7071
            71745D1DFAFAFA2260726F70706F6D6D6F70735E1CFAFA57727273736F6F7772
            6C6F707322FA5E677742CC466A6A34CB2E6C6E71621D60794734DEDE446A34DE
            E43478716A1D624643B1DEDEDEA5C9E7DEDEA56F711D643E37AEDEDEDEA5CBE7
            DEE2A56F711F613BB1A6DEDE3446B1DEE5B177716A1C6243A5A5EAB14646AECE
            346F6D72611DFA79A9A5A8B0363F3E437876717321FAFA6344A5A5B1343A4346
            4877745C1FFAFAFA6144A6A5A8B1333C43485D21FAFAFAFAFA637A2CB1B2B12D
            495121FAFAFAFAFAFAFAFA604C4C4D5F5CFAFAFAFAFA}
          Rounded = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = TrimSeqNBtnClick
          Appearance.BorderColor = 11382963
          Appearance.BorderColorHot = 11565130
          Appearance.BorderColorCheckedHot = 11565130
          Appearance.BorderColorDown = 11565130
          Appearance.BorderColorChecked = 13744549
          Appearance.BorderColorDisabled = 13948116
          Appearance.Color = clWhite
          Appearance.ColorTo = clWhite
          Appearance.ColorChecked = 13744549
          Appearance.ColorCheckedTo = 13744549
          Appearance.ColorDisabled = clWhite
          Appearance.ColorDisabledTo = clNone
          Appearance.ColorDown = 11565130
          Appearance.ColorDownTo = 11565130
          Appearance.ColorHot = 16444643
          Appearance.ColorHotTo = 16444643
          Appearance.ColorMirror = clWhite
          Appearance.ColorMirrorTo = clWhite
          Appearance.ColorMirrorHot = 16444643
          Appearance.ColorMirrorHotTo = 16444643
          Appearance.ColorMirrorDown = 11565130
          Appearance.ColorMirrorDownTo = 11565130
          Appearance.ColorMirrorChecked = 13744549
          Appearance.ColorMirrorCheckedTo = 13744549
          Appearance.ColorMirrorDisabled = clWhite
          Appearance.ColorMirrorDisabledTo = clNone
          Appearance.GradientHot = ggVertical
          Appearance.GradientMirrorHot = ggVertical
          Appearance.GradientDown = ggVertical
          Appearance.GradientMirrorDown = ggVertical
          Appearance.GradientChecked = ggVertical
          Appearance.TextColorChecked = 3750459
          Appearance.TextColorDown = 2303013
          Appearance.TextColorHot = 2303013
          Appearance.TextColorDisabled = 13948116
          DropDownSplit = False
        end
        object TrimSeqCBtn: TAdvGlowButton
          Tag = 1
          Left = 78
          Top = 515
          Width = 57
          Height = 22
          Hint = 'Trim C-terminus of sequence'
          Caption = ' -&C'
          Default = True
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          Picture.Data = {
            424D360500000000000036040000280000001000000010000000010008000000
            0000000100000000000000000000000100000001000000000000010101000202
            0200030303000404040005050500060606000707070008080800090909000A0A
            0A000B0B0B000C0C0C000D0D0D00130F0E001A120F001F14100028171100361B
            1400401D1700461E18004A1F19004C201A004D201A004F211A00532219005623
            18005A2517005E261600602716006228150064281400662A1400692B1300702D
            1200783110007C320E0080340D0084350C0087370B008A380A008C390A008E39
            09008F3A0900923B0800953C0800983D07009B3F07009D4006009F410700A142
            0600A4430500A7440400AB450300AF470400B3490300B74A0200BA4A0000BA4A
            0000BB4B0000BC4B0000BD4C0100BD4D0100BF4E0100C14E0100C24F0100C350
            0200C2510300C3540600C4570800C55A0B00C85E0F00CA631400CD681900CF6D
            1F00D1712500D3762A00D4792E00D57B3100D57D3300D57E3400D6803700D57E
            3600D47D3400D37C3300D17A3200D0793100CE773000CC752E00CB732D00C871
            2B00C56E2900C16A2700BB652400B35F2100AA581F00A0521F00944C1F008A48
            21008646230080452600804728007F482B007E4A2E007D4C31007D4E35007C50
            39007B533D007A55420079584700785B4C00775F52007663580076665E00756B
            6500746F6C007474740075757500767676007777770078787800797979007A7A
            7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F0080808000818181008282
            8200838383008484840085858500868686008787870088888800898989008A8A
            8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F0090909000919191009292
            9200939393009494940095959500969696009797970098989800999999009A9A
            9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1A100A2A2
            A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9A900AAAA
            AA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B5B2AF00BAB4
            AE00BEB5AD00C3B7AC00C7B9AC00CEBDAD00D5C0AD00DDC7B100E3CCB600E9D2
            BC00EDD6C100F1DCC800F3E1CE00F5E4D300F7E7D800F8EADC00F9ECDF00FAEF
            E500FBF2E900FBF5EE00FCF7F200FDFAF600FDFCFA00FEFCFA00FDFBF900FDF8
            F300FCF3EA00FBEADA00F9E3CC00F8DDC200F7D6B600F6D2AE00F5CDA700F4CA
            A200F3C79D00F3C59A00F3C49700F3C39500F3C29300F3C09000F2BF8E00F2BD
            8A00F0BB8800F0BA8600EFB88300EDB57F00ECB27A00ECAF7500EBAB6F00EAA9
            6C00EAA76800E9A56600E7A46600E5A16400E39F6200E39D6100E39A6000E298
            6100E3966600E5927000E8897F00EB7D8D00EE6B9F00F34EBA00F928DD00FC0F
            F200FE03FC00FE01FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
            FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FAFAFAFAFA1518212118
            16FAFAFAFAFAFAFAFA1A202F363B3C37302117FAFAFAFAFA1E2C42413F3C3D3D
            40422C17FAFAFA212F413A3F3F3C3A3C3C3C422C15FAFA25413F3C3E493E433A
            3C473C4221FA2C36464746EAC0EA3E3E51C0E64030172F464A4BD7C8C8513EE7
            C8C8E63F3717324C51CDC8C8C8DED2C8C8C8E53C3C183451E6CFC8C8C8DBD2C8
            C8C8E53C3C1A30EADAE4D6C8C8E14951C8C8E63F37173150D1DCE1DCC4DB514B
            4CC4E6403017FA37D8CEDAE1DAE3EA4F49493E421FFAFA334DCFCED8DAE45151
            4A45422A1AFAFAFA3056D2CED0DCE2E851482B1EFAFAFAFAFA335F51E0DBDFEA
            5E251EFAFAFAFAFAFAFAFA2F31312D2E29FAFAFAFAFA}
          Rounded = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnClick = TrimSeqCBtnClick
          Appearance.BorderColor = 11382963
          Appearance.BorderColorHot = 11565130
          Appearance.BorderColorCheckedHot = 11565130
          Appearance.BorderColorDown = 11565130
          Appearance.BorderColorChecked = 13744549
          Appearance.BorderColorDisabled = 13948116
          Appearance.Color = clWhite
          Appearance.ColorTo = clWhite
          Appearance.ColorChecked = 13744549
          Appearance.ColorCheckedTo = 13744549
          Appearance.ColorDisabled = clWhite
          Appearance.ColorDisabledTo = clNone
          Appearance.ColorDown = 11565130
          Appearance.ColorDownTo = 11565130
          Appearance.ColorHot = 16444643
          Appearance.ColorHotTo = 16444643
          Appearance.ColorMirror = clWhite
          Appearance.ColorMirrorTo = clWhite
          Appearance.ColorMirrorHot = 16444643
          Appearance.ColorMirrorHotTo = 16444643
          Appearance.ColorMirrorDown = 11565130
          Appearance.ColorMirrorDownTo = 11565130
          Appearance.ColorMirrorChecked = 13744549
          Appearance.ColorMirrorCheckedTo = 13744549
          Appearance.ColorMirrorDisabled = clWhite
          Appearance.ColorMirrorDisabledTo = clNone
          Appearance.GradientHot = ggVertical
          Appearance.GradientMirrorHot = ggVertical
          Appearance.GradientDown = ggVertical
          Appearance.GradientMirrorDown = ggVertical
          Appearance.GradientChecked = ggVertical
          Appearance.TextColorChecked = 3750459
          Appearance.TextColorDown = 2303013
          Appearance.TextColorHot = 2303013
          Appearance.TextColorDisabled = 13948116
          Layout = blGlyphRight
          DropDownSplit = False
        end
        object ShowNTermPeaksChk: TAdvOfficeCheckBox
          Left = 4
          Top = 138
          Width = 120
          Height = 20
          Enabled = False
          TabOrder = 7
          OnClick = ShowNTermPeaksChkClick
          Alignment = taLeftJustify
          Caption = 'N-terminal'
          ReturnIsTab = False
          Version = '1.8.0.5'
        end
        object PkWidthDrop: TAdvComboBox
          Left = 4
          Top = 69
          Width = 115
          Height = 21
          Hint = 'Set peak width'
          Color = clWhite
          Version = '2.0.0.1'
          Visible = True
          BevelInner = bvNone
          BevelOuter = bvNone
          BevelEdges = []
          ButtonWidth = 17
          Flat = True
          EmptyTextStyle = []
          Ctl3D = False
          DropWidth = 0
          Enabled = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Peak width 0'
            'Peak width 1'
            'Peak width 2')
          LabelPosition = lpRightCenter
          LabelTransparent = True
          LabelAlwaysEnabled = True
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -15
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          Text = 'Peak width 0'
          OnChange = PkWidthDropChange
        end
        object CopySpectrumBtn: TAdvGlowButton
          Left = 28
          Top = 573
          Width = 90
          Height = 22
          Anchors = [akRight, akBottom]
          Caption = 'Copy spec.'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -12
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          Picture.Data = {
            424D360500000000000036040000280000001000000010000000010008000000
            0000000100000000000000000000000100000001000000000000010101000202
            0200030303000404040005050500060606000707070008080800090909000A0A
            0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F0010101000111111001212
            1200131313001414140015151500161616001717170018181800191919001A1A
            1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F0020202000212121002222
            2200232323002424240025252500262626002727270028282800292929002A2A
            2A002B2B2B002C2C2C002D2D2D002E2E2E0033303000383232003C3433004135
            350045373600483838004C3939004F3A3A00523B3B00563D3C005A3E3D005D3E
            3E00613F3F0064403F0067404000694140006A4140006C4140006D4141006E42
            41006E4241006F4241006F424100704241007142410072424100724341007343
            42007544430076464400784745007B4946007D4B4700814F4A0085524C008955
            4E008D595100925D540096605600996357009C6559009E685B00A0695C00A16B
            5D00A26C5E00A26D5F00A16C5E00A16C5E00A16C5E00A06B5E00A06A5D009F69
            5D009F695C009E685C009D675C009B665B009A655B0099645B0098635A009662
            5A0094615A0092605A00905F59008F5E59008F5E59008E5E59008C5E59008B5E
            5A00895F5B0086605D0085615F008464610083676500826B6900826C6A00826D
            6C00826F6D0082716F0082737100827574008277760082797900827C7C00827F
            7F00838383008484840085858500927F8C009F7A9300A9749A00B967A700C55B
            B200D04FBC00D846C500E238D000E92ED900EF22E300F516EC00F90EF300FB09
            F700FD05FA00FD03FC00FE01FD00FE01FE00FE00FE00FE00FE00FE00FE00FE00
            FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
            FE00FE00FE00FE00FE00FF00FF00FE00FE00FE00FE00FE00FE00FE00FE00FE00
            FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
            FE00FE00FE00FE01FE00FE02FD00FE03FC00FD06FA00F912F000F326DD00ED3A
            CB00E74DBB00E25EAD00DE6AA300D97A9500D6848B00D38E8600CF968500D197
            7A00D2977300CF957100CC926F00CB916E00CA8F6E00C98E6D00C88D6C00C98E
            6C00CB8F6C00CC8F6B00CE906B00D0916B00D1926800D4915F00D6905700D88E
            4C00DA8E4400DB8E3E00DC8E3C00DC8E3B00DC8E3A00DD8E3B00DD903D00DD91
            3E00DD913F00DE924000DF944300E1974500E2994700E39A4900E39B4B00E49E
            5100E6A35A00E9A86200EDAF6D00F0B57600F5BD8400F8C48F00FAC99800FCCE
            9F00FDD1A600FED5AC00FED7B000FED9B300FDDBB900FDDDBE00FCDEC000FADE
            C300F9DFC700F8E2CE00F8E4D200F8E8D800FAEBDE00FBEEE200FCF1E600FDF4
            EB00FDF6EE00FEF8F100FEF9F500FEFAF700FEFAF700A5A5A5A5A57070707070
            7070707048A5A5A5A5A5A56CF0EEECEBEAE9E8E848A5A5A5A5A5A566F3D9D9D9
            D9D9D9E948A5A5A5A5A5A55DF6F4F1EFEDECEAEA48A570707070705CF8D9D9D9
            D9D9D9EB48A56CF0EEECEB5CF9F8F6F5F3F0EEEC48A566F3D9D9D9C9FCD9D9D9
            D9D9D9EF48A55DF6F4F1EFC9FEFCFAF9F7F6F4F148A55CF8D9D9D9C5FFFFFCFB
            F9F4C18748A55CF9F8F6F5C3FFFFFFFDFB58585857A5C9FCD9D9D9C3FFFFFFFF
            FE58E2D7A5A5C9FEFCFAF9E4CECECECECE58E0A5A5A5C5FFFFFCFBF9F4C18748
            A5A5A5A5A5A5C3FFFFFFFDFB58585857A5A5A5A5A5A5C3FFFFFFFFFE58E2D7A5
            A5A5A5A5A5A5E4CECECECECE58E0A5A5A5A5A5A5A5A5}
          Rounded = True
          TabOrder = 9
          OnClick = CopySpectrumBtnClick
          Appearance.BorderColor = 11382963
          Appearance.BorderColorHot = 11565130
          Appearance.BorderColorCheckedHot = 11565130
          Appearance.BorderColorDown = 11565130
          Appearance.BorderColorChecked = 13744549
          Appearance.BorderColorDisabled = 13948116
          Appearance.Color = clWhite
          Appearance.ColorTo = clWhite
          Appearance.ColorChecked = 16111818
          Appearance.ColorCheckedTo = 16367008
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 16111818
          Appearance.ColorDownTo = 16367008
          Appearance.ColorHot = 16117985
          Appearance.ColorHotTo = 16372402
          Appearance.ColorMirror = clSilver
          Appearance.ColorMirrorTo = clWhite
          Appearance.ColorMirrorHot = 16107693
          Appearance.ColorMirrorHotTo = 16775412
          Appearance.ColorMirrorDown = 16102556
          Appearance.ColorMirrorDownTo = 16768988
          Appearance.ColorMirrorChecked = 16102556
          Appearance.ColorMirrorCheckedTo = 16768988
          Appearance.ColorMirrorDisabled = 11974326
          Appearance.ColorMirrorDisabledTo = 15921906
          Appearance.GradientHot = ggVertical
          Appearance.GradientMirrorHot = ggVertical
          Appearance.GradientDown = ggVertical
          Appearance.GradientMirrorDown = ggVertical
          Appearance.GradientChecked = ggVertical
          Appearance.TextColorChecked = 3750459
          Appearance.TextColorDown = 2303013
          Appearance.TextColorHot = 2303013
          Appearance.TextColorDisabled = 13948116
        end
        object IonPrecisionChart: TChart
          Left = 0
          Top = 602
          Width = 138
          Height = 215
          Title.Text.Strings = (
            'MS/MS precision (Da)')
          LeftAxis.Visible = False
          View3D = False
          Align = alBottom
          TabOrder = 10
          DefaultCanvas = 'TGDIPlusCanvas'
          ColorPaletteIndex = 13
          object IonPrecisionSeries: TPointSeries
            Legend.Visible = False
            ShowInLegend = False
            ClickableLine = False
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
        end
        object ViewUnmodSpectrumRadBtn: TRadioButton
          Left = 4
          Top = 251
          Width = 82
          Height = 17
          Caption = 'Unmodified'
          Checked = True
          TabOrder = 11
          TabStop = True
          OnClick = ViewUnmodSpectrumRadBtnClick
        end
        object ViewCTermModSpectrumRadBtn: TRadioButton
          Left = 5
          Top = 297
          Width = 82
          Height = 17
          Caption = 'C-terminal'
          TabOrder = 12
          OnClick = ViewCTermModSpectrumRadBtnClick
        end
        object ViewNTermModSpectrumRadBtn: TRadioButton
          Left = 4
          Top = 274
          Width = 82
          Height = 17
          Caption = 'N-terminal'
          TabOrder = 13
          OnClick = ViewNTermModSpectrumRadBtnClick
        end
        object ViewCombinedSpectrumRadBtn: TRadioButton
          Left = 5
          Top = 320
          Width = 82
          Height = 17
          Caption = 'Combined'
          Color = clGray
          ParentColor = False
          TabOrder = 14
          OnClick = ViewCombinedSpectrumRadBtnClick
        end
        object ViewDeconvolutedChk: TAdvOfficeCheckBox
          Left = 3
          Top = 343
          Width = 120
          Height = 34
          Checked = True
          TabOrder = 15
          OnClick = ViewDeconvolutedChkClick
          Alignment = taLeftJustify
          Caption = 'Deconvoluted spectrum'
          ReturnIsTab = False
          State = cbChecked
          Version = '1.8.0.5'
        end
        object ShowCTermPeaksChk: TAdvOfficeCheckBox
          Left = 4
          Top = 156
          Width = 120
          Height = 20
          Checked = True
          Enabled = False
          TabOrder = 16
          OnClick = ShowCTermPeaksChkClick
          Alignment = taLeftJustify
          Caption = 'C-terminal'
          ReturnIsTab = False
          State = cbChecked
          Version = '1.8.0.5'
        end
        object ShowFragmentPeaksChk: TAdvOfficeCheckBox
          Left = 4
          Top = 172
          Width = 120
          Height = 20
          Enabled = False
          TabOrder = 17
          OnClick = ShowFragmentPeaksChkClick
          Alignment = taLeftJustify
          Caption = 'Fragments'
          ReturnIsTab = False
          Version = '1.8.0.5'
        end
        object ShowUnusedPeaksChk: TAdvOfficeCheckBox
          Left = 4
          Top = 190
          Width = 120
          Height = 20
          Enabled = False
          TabOrder = 18
          OnClick = ShowUnusedPeaksChkClick
          Alignment = taLeftJustify
          Caption = 'Unused'
          ReturnIsTab = False
          Version = '1.8.0.5'
        end
      end
    end
  end
  object BackPanel: TAdvPanel
    Left = 0
    Top = 0
    Width = 1315
    Height = 845
    Align = alClient
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    UseDockManager = True
    Version = '2.6.0.0'
    BorderColor = clBlack
    Caption.Color = clHighlight
    Caption.ColorTo = clNone
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -11
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 0
    Caption.ShadeLight = 255
    CollapsColor = clNone
    CollapsDelay = 0
    DoubleBuffered = True
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clNone
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWindowText
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = clWhite
    StatusBar.GradientDirection = gdVertical
    Text = ''
    FullHeight = 200
    object MainChart: TChart
      Left = 0
      Top = 0
      Width = 1315
      Height = 845
      Hint = 'No labels on low intensity peaks'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AllowPanning = pmHorizontal
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = 11118482
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Pen.Visible = False
      BackWall.Transparent = False
      BackWall.Visible = False
      Border.Color = 14645801
      Border.Width = 7
      BottomWall.Brush.Gradient.EndColor = 16580349
      BottomWall.Brush.Gradient.StartColor = 3114493
      BottomWall.Pen.Visible = False
      BottomWall.Size = 4
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      LeftWall.Brush.Gradient.EndColor = 2413052
      LeftWall.Brush.Gradient.StartColor = 900220
      LeftWall.Color = 14745599
      LeftWall.Dark3D = False
      LeftWall.Pen.Visible = False
      LeftWall.Size = 4
      LeftWall.Visible = False
      Legend.Brush.Gradient.Direction = gdTopBottom
      Legend.Brush.Gradient.EndColor = clYellow
      Legend.Brush.Gradient.StartColor = clWhite
      Legend.Color = clInfoBk
      Legend.Font.Name = 'Verdana'
      Legend.Frame.Color = clGray
      Legend.Frame.Visible = False
      Legend.Shadow.Color = 13421772
      Legend.Shadow.Transparency = 0
      Legend.Symbol.Pen.Visible = False
      Legend.Visible = False
      MarginBottom = 0
      MarginLeft = 0
      MarginRight = 0
      MarginTop = 0
      MarginUnits = muPixels
      RightWall.Color = 14745599
      Title.Alignment = taLeftJustify
      Title.Color = clInfoBk
      Title.Font.Color = clBlack
      Title.Font.Name = 'Verdana'
      Title.Font.Style = [fsBold]
      Title.Frame.Color = clGray
      Title.Shadow.HorizSize = 0
      Title.Shadow.VertSize = 0
      Title.Text.Strings = (
        'TChart')
      Title.Transparent = False
      Title.Visible = False
      OnAllowScroll = MainChartAllowScroll
      OnScroll = MainChartScroll
      OnUndoZoom = MainChartUndoZoom
      OnZoom = MainChartZoom
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 13421772
      BottomAxis.Grid.Visible = False
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.LabelStyle = talValue
      BottomAxis.MinimumOffset = 2
      BottomAxis.MinorTicks.Color = clBlack
      BottomAxis.TicksInner.Color = clBlack
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.MinorTicks.Color = clBlack
      DepthAxis.TicksInner.Color = clBlack
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.MinorTicks.Color = clBlack
      DepthTopAxis.TicksInner.Color = clBlack
      DepthTopAxis.Title.Font.Name = 'Verdana'
      Frame.Visible = False
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.Grid.Visible = False
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.MaximumOffset = 5
      LeftAxis.MinorTicks.Color = clBlack
      LeftAxis.PositionUnits = muPixels
      LeftAxis.TicksInner.Color = clBlack
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.MinorTicks.Color = clBlack
      RightAxis.TicksInner.Color = clBlack
      RightAxis.Title.Font.Name = 'Verdana'
      Shadow.Color = clBlack
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.MinorTicks.Color = clBlack
      TopAxis.TicksInner.Color = clBlack
      TopAxis.Title.Font.Name = 'Verdana'
      View3D = False
      Zoom.Brush.Color = 16244940
      Zoom.Brush.Style = bsSolid
      Zoom.History = True
      Zoom.MinimumPixels = 12
      OnAfterDraw = MainChartAfterDraw
      Align = alClient
      Color = clWhite
      TabOrder = 0
      OnClick = MainChartClick
      OnDblClick = MainChartDblClick
      OnKeyUp = MainChartKeyUp
      DefaultCanvas = 'TGDIPlusCanvas'
      PrintMargins = (
        15
        32
        15
        32)
      ColorPaletteIndex = 8
      object BarSeries: TBarSeries
        BarBrush.Gradient.StartColor = clBlue
        BarPen.Color = clRed
        BarPen.Visible = False
        Cursor = crCross
        Marks.Brush.Gradient.Angle = 90
        Marks.Emboss.Clip = True
        Marks.Font.Brush.Gradient.Angle = 90
        Marks.Font.Shadow.Visible = False
        Marks.Frame.Color = clGray
        Marks.Frame.Visible = False
        Marks.Shadow.Clip = True
        Marks.Shadow.Color = 13421772
        Marks.Shadow.HorizSize = 0
        Marks.Shadow.Smooth = False
        Marks.Shadow.VertSize = 0
        Marks.Transparency = 50
        Marks.Transparent = True
        Marks.Margins.Left = 9
        Marks.Margins.Right = 10
        Marks.Margins.Bottom = 0
        Marks.Margins.Units = maPixels
        Marks.Style = smsXValue
        Marks.BackColor = 16710882
        Marks.Clip = True
        Marks.Symbol.Frame.Visible = False
        Marks.Symbol.Pen.Visible = False
        Marks.Symbol.Transparency = 17
        Marks.Color = 16710882
        Marks.Items = {
          010000000105436F6C6F7204E2FCFE000B456D626F73732E436C6970090C456D
          626F73732E436F6C6F720706636C4772617919466F6E742E42727573682E4772
          616469656E742E416E676C65025A13466F6E742E536861646F772E5669736962
          6C65080B536861646F772E436C6970090C536861646F772E436F6C6F7204CCCC
          CC0010536861646F772E486F72697A53697A6502000D536861646F772E536D6F
          6F7468080F536861646F772E5665727453697A6502000A53686170655374796C
          650711666F73526F756E6452656374616E676C650C546578742E537472696E67
          7301060130000C5472616E73706172656E637902320B5472616E73706172656E
          740900}
        SeriesColor = 10485760
        ValueFormat = '0.00'
        OnClick = BarSeriesClick
        BarWidthPercent = 0
        Dark3D = False
        Gradient.StartColor = clBlue
        SideMargins = False
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Bar'
        YValues.Order = loNone
      end
    end
  end
  object DNSeqCopyTypePop: TAdvPopupMenu
    Version = '2.7.1.5'
    UIStyle = tsCustom
    Left = 1426
    Top = 833
    object CopySequence1lett: TMenuItem
      Caption = 'Copy sequence -1 lett.'
      OnClick = CopySequence1lettClick
    end
    object Copysequence3lett: TMenuItem
      Tag = 1
      Caption = 'Copy sequence -3 lett.'
      OnClick = CopySequence3lettClick
    end
    object CopySequenceAndMass: TMenuItem
      Tag = 2
      Caption = 'Copy sequence and mass'
      OnClick = CopySequenceAndMassClick
    end
  end
  object BackupSeqPop: TAdvPopupMenu
    Version = '2.7.1.5'
    UIStyle = tsOffice2019White
    Left = 1392
    Top = 832
    object seqM1: TMenuItem
      Tag = 1
      Caption = '1:'
      OnClick = seqM1Click
    end
    object seqM2: TMenuItem
      Tag = 2
      Caption = '2:'
      OnClick = seqM2Click
    end
    object seqM3: TMenuItem
      Tag = 3
      Caption = '3:'
      OnClick = seqM3Click
    end
    object seqM4: TMenuItem
      Tag = 4
      Caption = '4:'
      OnClick = seqM4Click
    end
    object seqM5: TMenuItem
      Tag = 5
      Caption = '5:'
      OnClick = seqM5Click
    end
  end
end
