': This program uses
': InForm - GUI library for QB64 - v1.2
': Fellippe Heitor, 2016-2020 - fellippe@qb64.org - @fellippeheitor
': https://github.com/FellippeHeitor/InForm
'-----------------------------------------------------------

$LET WGET = -1
': Controls' IDs: ------------------------------------------------------------------
DIM SHARED Form1 AS LONG
DIM SHARED FR_Themes AS LONG
DIM SHARED FR_ThemeInfo AS LONG
DIM SHARED FR_Repository AS LONG
DIM SHARED LI_ThemeList AS LONG
DIM SHARED BT_AddTheme AS LONG
DIM SHARED IM_ThemePreview AS LONG
DIM SHARED LB_Description AS LONG
DIM SHARED CB_Repos AS LONG
DIM SHARED PB_Repo AS LONG
DIM SHARED BT_DownloadRepo AS LONG
DIM SHARED TB_ConfigPath AS LONG
DIM SHARED BT_SaveConfig AS LONG

DIM SHARED winNL AS STRING * 2, unixNL AS STRING * 1
winNL = CHR$(10) + CHR$(13)
unixNL = CHR$(10)

IF COMMAND$(1) = "WGETINPUT" THEN
    _SCREENHIDE
    reopen:
    a& = _OPENCLIENT(COMMAND$(2))
    OPEN "/dev/stdin" FOR INPUT AS #1
    IF a& = 0 OR a& = -1 THEN GOTO reopen
    DO
        LINE INPUT #1, a$
        PUT #a&, , a$
    LOOP UNTIL EOF(1)
    CLOSE a&, 1
    SYSTEM
END IF


': External modules: ---------------------------------------------------------------
'$INCLUDE:'InForm\InForm.ui'
'$INCLUDE:'InForm\xp.uitheme'
'$INCLUDE:'qb64themes.frm'

': Event procedures: ---------------------------------------------------------------
SUB __UI_BeforeInit

END SUB

SUB __UI_OnLoad

END SUB

SUB __UI_BeforeUpdateDisplay
    'This event occurs at approximately 30 frames per second.
    'You can change the update frequency by calling SetFrameRate DesiredRate%
     shared dld_client&,dld_host&
     if dld_host& then
     if dld_client&=0 or dld_client&=-1 then
     dld_client&=_openconnection(dld_host&)
     else
     line input #dld_client&, s$
     repoFile$=repoFile$+s$
     endif
     endif
END SUB

SUB __UI_BeforeUnload
    'If you set __UI_UnloadSignal = False here you can
    'cancel the user's request to close.

END SUB

SUB __UI_Click (id AS LONG)
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
            $IF WGET = -1 THEN
                SHARED dld_client&, dld_host&
                Caption(PB_Repo) = "Opening localhost port..."

                openhost:
                tcp$ = "TCP/IP:" + LTRIM$(STR$(RND * 65535))
                dld_host& = _OPENHOST(tcp$)
                IF dld_host& = -1 OR dld_host& = 0 GOTO openhost

                Caption(PB_Repo) = "Downloading..."
                SHELL "wget '" + Text(CB_Repos) + "' -o- | " + COMMAND$(0) + " WGETINPUT " + tcp$
            $ELSE
                SHARED TCPCon&, TCPData$
                tcpdat$ = ""
                Caption(PB_Repo) = "Checking URL..."
                Control(BT_DownloadRepo).Disabled = -1

                CheckURL:
                slash% = INSTR(Text(CB_Repos), "/")
                IF slash% = 0 THEN
                Text(CB_Repos) = Text(CB_Repos) + "/"
                GOTO CheckURL
                END IF
                tcp$ = "TCP/IP:80:" + LEFT$(Text(CB_Repos), slash%)
                url$ = MID$(Text(CB_Repos), slash%)

                Caption(PB_Repo) = "Connecting to " + tcp$ + "..."
                TCPCon& = _OPENCLIENT(tcp$)
                IF TCPCon& = -1 OR TCPCon& = 0 THEN
                Caption(PB_Repo) = "Error: Could not connect to " + tcp$ + "!"
                TCPCon& = 0
                EXIT SUB
                END IF
                httphead$ = "GET " + url$ + " HTTP/1.1" + winNL + "Host: " + LEFT$(Text(CB_Repos), slash%) + winNL + winNL
                Caption(PB_Repo) = "Sending HTTP header..."
                PUT #TCPCon&, , httphead$
            $END IF

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

