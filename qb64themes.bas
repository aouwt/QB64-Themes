': This program uses
': InForm - GUI library for QB64 - v1.2
': Fellippe Heitor, 2016-2020 - fellippe@qb64.org - @fellippeheitor
': https://github.com/FellippeHeitor/InForm
'-----------------------------------------------------------
TYPE ThemeType
    Name AS STRING
    Author AS STRING
    Date AS STRING
    'Licence AS STRING
    Description AS STRING
    Theme AS STRING * 81
END TYPE

RANDOMIZE TIMER
': Controls' IDs: ------------------------------------------------------------------
DIM SHARED Form1 AS LONG
DIM SHARED FR_Themes AS LONG
DIM SHARED FR_ThemeInfo AS LONG
DIM SHARED FR_Repository AS LONG
DIM SHARED LI_ThemeList AS LONG
DIM SHARED BT_AddTheme AS LONG
DIM SHARED IM_ThemePreview AS LONG
DIM SHARED LB_Description AS LONG
DIM SHARED TB_RepoURL AS LONG
DIM SHARED PB_Repo AS LONG
DIM SHARED BT_DownloadRepo AS LONG
DIM SHARED TB_ConfigPath AS LONG
DIM SHARED BT_SaveConfig AS LONG

DIM SHARED Themes(100) AS ThemeType

DIM SHARED WinNL AS STRING * 2, UnixNL AS STRING * 1
WinNL = CHR$(10) + CHR$(13)
UnixNL = CHR$(10)

REM $error hi
': External modules: ---------------------------------------------------------------
REM $INCLUDE:'InForm\InForm.ui'
REM $INCLUDE:'InForm\xp.uitheme'
REM $INCLUDE:'qb64themes.frm'

SUB ParseRepofile (QML$) 'Based on the SCS loader for stupidc
    Control(PB_Repo).Min = 0
    Control(PB_Repo).Max = LEN(QML$)
    SetCaption PB_Repo, "Parsing... \#%"
    ResetList LI_ThemeList
    REDIM Themes(100) AS ThemeType
    DO
        GOSUB NewLine
        IF Ln$ = CHR$(0) THEN EXIT DO
        IF ASC(Ln$) = 35 THEN _CONTINUE 'Hashtags for comments

        SELECT CASE Ln$
            CASE "desc"
                DO
                    GOSUB NewLine
                    IF Ln$ = "." THEN EXIT DO
                    Themes(Theme%).Description = Themes(Theme%).Description + Ln$ + "\n"
                LOOP

            CASE ".": Theme% = Theme% + 1
                IF Theme% >= UBOUND(themes) THEN EXIT SUB

            CASE ELSE 'Single line keys get some extra processing
                I% = INSTR(Ln$, " ")
                IF I% = 0 THEN _CONTINUE

                Key$ = LTRIM$(RTRIM$(LEFT$(Ln$, I%)))
                Val$ = LTRIM$(RTRIM$(MID$(Ln$, I% + 1)))

                SELECT CASE Key$
                    CASE "author"
                        Themes(Theme%).Author = Val$
                    CASE "date"
                        Themes(Theme%).Date = Val$
                    CASE "theme"
                        CALL ParseTheme(Val$, Themes(Theme%).Name, Themes(Theme%).Theme)
                        AddItem LI_ThemeList, Themes(Theme%).Name + " by " + Themes(Theme%).Author
                END SELECT
        END SELECT
        'IF TIMER - t# > 1 THEN __UI_DoEvents: t# = TIMER
        __UI_DoEvents
    LOOP
    Control(PB_Repo).Value = 0
    SetCaption PB_Repo, "Done"
    EXIT SUB

    NewLine:
    NextLine_Start% = NextLine_End% + 1
    NextLine_End% = INSTR(NextLine_Start%, QML$, UnixNL)
    IF NextLine_End% = 0 THEN Ln$ = CHR$(0): RETURN
    Ln$ = LTRIM$(RTRIM$(MID$(QML$, NextLine_Start%, NextLine_End% - NextLine_Start%)))
    Control(PB_Repo).Value = NextLine_End%
    RETURN
END SUB

SUB UpdateSample (scheme AS STRING * 81)
    'Stole from QB64 itself lol
    DIM i AS INTEGER
    DIM TextColor AS _UNSIGNED LONG, KeywordColor AS _UNSIGNED LONG, NumbersColor AS _UNSIGNED LONG, QuoteColor AS _UNSIGNED LONG, MetaCommandColor AS _UNSIGNED LONG
    DIM BackgroundColor AS _UNSIGNED LONG, BackgroundColor2 AS _UNSIGNED LONG
    'begin stolen content
    i = 1
    r$ = MID$(scheme, i, 3): i = i + 3
    g$ = MID$(scheme, i, 3): i = i + 3
    b$ = MID$(scheme, i, 3): i = i + 3
    TextColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))

    r$ = MID$(scheme, i, 3): i = i + 3
    g$ = MID$(scheme, i, 3): i = i + 3
    b$ = MID$(scheme, i, 3): i = i + 3
    KeywordColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))

    r$ = MID$(scheme, i, 3): i = i + 3
    g$ = MID$(scheme, i, 3): i = i + 3
    b$ = MID$(scheme, i, 3): i = i + 3
    NumbersColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))

    r$ = MID$(scheme, i, 3): i = i + 3
    g$ = MID$(scheme, i, 3): i = i + 3
    b$ = MID$(scheme, i, 3): i = i + 3
    QuoteColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))

    r$ = MID$(scheme, i, 3): i = i + 3
    g$ = MID$(scheme, i, 3): i = i + 3
    b$ = MID$(scheme, i, 3): i = i + 3
    MetaCommandColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))

    r$ = MID$(scheme, i, 3): i = i + 3
    g$ = MID$(scheme, i, 3): i = i + 3
    b$ = MID$(scheme, i, 3): i = i + 3
    CommentColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))

    r$ = MID$(scheme, i, 3): i = i + 3
    g$ = MID$(scheme, i, 3): i = i + 3
    b$ = MID$(scheme, i, 3): i = i + 3
    BackgroundColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))

    r$ = MID$(scheme, i, 3): i = i + 3
    g$ = MID$(scheme, i, 3): i = i + 3
    b$ = MID$(scheme, i, 3): i = i + 3
    BackgroundColor2 = _RGB32(VAL(r$), VAL(g$), VAL(b$))

    r$ = MID$(scheme, i, 3): i = i + 3
    g$ = MID$(scheme, i, 3): i = i + 3
    b$ = MID$(scheme, i, 3): i = i + 3
    BracketHighlightColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))
    'end stolen content
    IF Control(IM_ThemePreview).HelperCanvas = 0 THEN Control(IM_ThemePreview).HelperCanvas = _NEWIMAGE(Control(IM_ThemePreview).Width, Control(IM_ThemePreview).Height, 32)
    _DEST Control(IM_ThemePreview).HelperCanvas

    'PRINT scheme
    CLS , BackgroundColor
    COLOR CommentColor, BackgroundColor2: PRINT "'";
    COLOR MetaCommandColor, BackgroundColor2: PRINT "$DYNAMIC"; SPACE$((_WIDTH / _FONTWIDTH) - POS(0));
    COLOR KeywordColor, BackgroundColor: PRINT "DIM ";
    COLOR TextColor, BackgroundColor: PRINT "Arr";
    COLOR TextColor, BracketHighlightColor: PRINT "(";
    COLOR NumbersColor, BackgroundColor: PRINT "5";
    COLOR TextColor, BracketHighlightColor: PRINT ")";
    COLOR CommentColor, BackgroundColor: PRINT " 'An array"
    COLOR MetaCommandColor, BackgroundColor: PRINT "SubR ";
    COLOR QuoteColor, BackgroundColor: PRINT CHR$(34); "String"; CHR$(34)

    Control(IM_ThemePreview).Redraw = True
END SUB

FUNCTION GetFile$ (fn$)
    f% = FREEFILE
    OPEN fn$ FOR BINARY AS #f%
    DO
        GET #f%, , a~%%
        GetFile$ = GetFile$ + CHR$(a~%%)
    LOOP UNTIL EOF(f%)
    CLOSE f%
END FUNCTION

FUNCTION StripWinNL$ (f$)
    FOR i% = 0 TO LEN(f$)
        IF ASC(f$, i%) <> 13 THEN StripWinNL$ = StripWinNL$ + CHR$(ASC(f$, i%))
    NEXT
END FUNCTION

SUB ParseTheme (I$, Name$, Theme$)
    i% = INSTR(I$, "|")
    IF i% = 0 THEN
        Name$ = I$
        Theme$ = I$
        EXIT SUB
    END IF
    Name$ = LEFT$(I$, i% - 1)
    Theme$ = MID$(I$, i% + 1)
END SUB

': Event procedures: ---------------------------------------------------------------
SUB __UI_BeforeInit

END SUB

SUB __UI_OnLoad
    $IF USE_REPEATER THEN
        SHARED dld_client&, wgetinput`
        IF COMMAND$(1) = "WGETINPUT" THEN
        SCREEN 0
        _AUTODISPLAY
        PRINT "Connecting to '"; COMMAND$(2); "'";

        reopen:
        IF t% > 10 THEN PRINT "Could not connect.": END
        dld_client& = _OPENCLIENT(COMMAND$(2) + ":localhost")
        PRINT ".";
        t% = t% + 1
        IF dld_client& = 0 THEN GOTO reopen

        PRINT "done"

        OPEN "/dev/stdin" FOR BINARY AS #1
        wgetinput` = -1
        'SetFrameRate 120
        END IF
    $END IF
END SUB

SUB __UI_BeforeUpdateDisplay
    'This event occurs at approximately 30 frames per second.
    'You can change the update frequency by calling SetFrameRate DesiredRate%
    SHARED dld_client&, dld_host&, wgetinput`, RepoFile$
    IF Control(LI_ThemeList).Redraw THEN UpdateSample Themes(Control(LI_ThemeList).Value - 1).Theme
    $IF USE_REPEATER THEN
        IF wgetinput` THEN
        FOR i% = 0 TO 1000
        GET #1, , a~%%
        PUT #dld_client&, , a~%%
        IF EOF(1) THEN
        CLOSE dld_client&, 1
        SYSTEM
        END IF
        NEXT
        EXIT SUB
        END IF
        IF dld_host& THEN

        IF LOF(dld_client&) = 0 AND _CONNECTED(dld_client&) = 0 THEN
        CLOSE dld_client&, dld_host&
        dld_client& = 0
        dld_host& = 0
        END IF

        IF dld_client& THEN
        'IF LEFT$(_CONNECTIONADDRESS$(dld_client&), 10) <> ":127.0.0.1" THEN CLOSE dld_client&: EXIT SUB 'Only accept connections from localhost

        SetCaption PB_Repo, "Recieving from repeater..." + _CONNECTIONADDRESS$(dld_client&)
        'DO
        GET #dld_client&, , s~%%
        RepoFile$ = RepoFile$ + CHR$(s~%%)
        'LOOP UNTIL LOF(dld_client&) = 0

        ELSEIF RepoFile$ = "" THEN
        dld_client& = _OPENCONNECTION(dld_host&)

        ELSE
        CLOSE dld_host&
        SetCaption PB_Repo, "Parsing..."
        CALL ParseRepofile(StripWinNL(RepoFile$), Themes())
        Control(BT_DownloadRepo).Disabled = 0

        END IF

        END IF
    $END IF

    SetCaption LB_Description, Themes(Control(LI_ThemeList).Value - 1).Description
END SUB

SUB __UI_BeforeUnload
    'If you set __UI_UnloadSignal = False here you can
    'cancel the user's request to close.

END SUB

SUB __UI_Click (id AS LONG)
    SHARED dld_client&, dld_host&
    SELECT CASE id
        CASE Form1

        CASE FR_Themes

        CASE FR_ThemeInfo

        CASE FR_Repository

        CASE LI_ThemeList

        CASE BT_AddTheme

        CASE IM_ThemePreview

        CASE LB_Description

        CASE PB_Repo

        CASE BT_DownloadRepo
            Control(BT_DownloadRepo).Disabled = -1
            IF LEFT$(Text(TB_RepoURL), 7) = "file://" THEN
                ParseRepofile StripWinNL$(GetFile$(MID$(Text(TB_RepoURL), 8)))
            ELSE
                $IF USE_REPEATER THEN
                    SetCaption PB_Repo, "Opening localhost port..."

                    openhost:
                    tcp$ = "TCP/IP:" + LTRIM$(STR$(INT(RND * 60000) + 256))
                    dld_host& = _OPENHOST(tcp$)
                    '_DELAY 0.1
                    IF dld_host& = 0 GOTO openhost

                    SetCaption PB_Repo, "Downloading..."
                    SHELL _DONTWAIT "curl '" + Text(TB_RepoURL) + "' -o- | " + COMMAND$(0) + " WGETINPUT " + tcp$
                $ELSE
                    SetCaption PB_Repo, "Downloading..."
                    SHELL "curl '" + Text(TB_RepoURL) + "' -o /tmp/repofile"
                    ParseRepofile StripWinNL$(GetFile$("/tmp/repofile"))
                    KILL "/tmp/repofile"
                $END IF
            END IF
            Control(BT_DownloadRepo).Disabled = 0

        CASE TB_ConfigPath

        CASE BT_SaveConfig

    END SELECT
END SUB

SUB __UI_MouseEnter (id AS LONG)
    SELECT CASE id
        CASE Form1

        CASE FR_Themes

        CASE FR_ThemeInfo

        CASE FR_Repository

        CASE LI_ThemeList

        CASE BT_AddTheme

        CASE IM_ThemePreview

        CASE LB_Description

        CASE CB_Repos

        CASE PB_Repo

        CASE BT_DownloadRepo

        CASE TB_ConfigPath

        CASE BT_SaveConfig

    END SELECT
END SUB

SUB __UI_MouseLeave (id AS LONG)
    SELECT CASE id
        CASE Form1

        CASE FR_Themes

        CASE FR_ThemeInfo

        CASE FR_Repository

        CASE LI_ThemeList

        CASE BT_AddTheme

        CASE IM_ThemePreview

        CASE LB_Description

        CASE CB_Repos

        CASE PB_Repo

        CASE BT_DownloadRepo

        CASE TB_ConfigPath

        CASE BT_SaveConfig

    END SELECT
END SUB

SUB __UI_FocusIn (id AS LONG)
    SELECT CASE id
        CASE LI_ThemeList

        CASE BT_AddTheme

        CASE CB_Repos

        CASE BT_DownloadRepo

        CASE TB_ConfigPath

        CASE BT_SaveConfig

    END SELECT
END SUB

SUB __UI_FocusOut (id AS LONG)
    'This event occurs right before a control loses focus.
    'To prevent a control from losing focus, set __UI_KeepFocus = True below.
    SELECT CASE id
        CASE LI_ThemeList

        CASE BT_AddTheme

        CASE CB_Repos

        CASE BT_DownloadRepo

        CASE TB_ConfigPath

        CASE BT_SaveConfig

    END SELECT
END SUB

SUB __UI_MouseDown (id AS LONG)
    SELECT CASE id
        CASE Form1

        CASE FR_Themes

        CASE FR_ThemeInfo

        CASE FR_Repository

        CASE LI_ThemeList

        CASE BT_AddTheme

        CASE IM_ThemePreview

        CASE LB_Description

        CASE CB_Repos

        CASE PB_Repo

        CASE BT_DownloadRepo

        CASE TB_ConfigPath

        CASE BT_SaveConfig

    END SELECT
END SUB

SUB __UI_MouseUp (id AS LONG)
    SELECT CASE id
        CASE Form1

        CASE FR_Themes

        CASE FR_ThemeInfo

        CASE FR_Repository

        CASE LI_ThemeList

        CASE BT_AddTheme

        CASE IM_ThemePreview

        CASE LB_Description

        CASE CB_Repos

        CASE PB_Repo

        CASE BT_DownloadRepo

        CASE TB_ConfigPath

        CASE BT_SaveConfig

    END SELECT
END SUB

SUB __UI_KeyPress (id AS LONG)
    'When this event is fired, __UI_KeyHit will contain the code of the key hit.
    'You can change it and even cancel it by making it = 0
    SELECT CASE id
        CASE LI_ThemeList

        CASE BT_AddTheme

        CASE CB_Repos

        CASE BT_DownloadRepo

        CASE TB_ConfigPath

        CASE BT_SaveConfig

    END SELECT
END SUB

SUB __UI_TextChanged (id AS LONG)
    SELECT CASE id
        CASE TB_ConfigPath

    END SELECT
END SUB

SUB __UI_ValueChanged (id AS LONG)
    SELECT CASE id
        CASE LI_ThemeList

        CASE CB_Repos

    END SELECT
END SUB

SUB __UI_FormResized

END SUB
