': This form was generated by
': InForm - GUI library for QB64 - v1.2
': Fellippe Heitor, 2016-2020 - fellippe@qb64.org - @fellippeheitor
': https://github.com/FellippeHeitor/InForm
'-----------------------------------------------------------
SUB __UI_LoadForm

    DIM __UI_NewID AS LONG, __UI_RegisterResult AS LONG

    __UI_NewID = __UI_NewControl(__UI_Type_Form, "Form1", 610, 396, 0, 0, 0)
    __UI_RegisterResult = 0
    SetCaption __UI_NewID, "Form1"
    Control(__UI_NewID).Font = SetFont("/usr/share/fonts/truetype/liberation/LiberationSans-Regular.ttf", 12)

    __UI_NewID = __UI_NewControl(__UI_Type_Frame, "FR_Themes", 590, 255, 10, 10, 0)
    __UI_RegisterResult = 0
    Control(__UI_NewID).HasBorder = True
    Control(__UI_NewID).Value = 1
    Control(__UI_NewID).BorderSize = 1

    __UI_NewID = __UI_NewControl(__UI_Type_Frame, "FR_ThemeInfo", 250, 230, 340, 22, 0)
    __UI_RegisterResult = 0
    SetCaption __UI_NewID, "Theme information"
    Control(__UI_NewID).HasBorder = True
    Control(__UI_NewID).Value = 3
    Control(__UI_NewID).BorderSize = 1

    __UI_NewID = __UI_NewControl(__UI_Type_Frame, "FR_Repository", 587, 76, 10, 275, 0)
    __UI_RegisterResult = 0
    SetCaption __UI_NewID, "Repository"
    Control(__UI_NewID).HasBorder = True
    Control(__UI_NewID).Value = 3
    Control(__UI_NewID).BorderSize = 1

    __UI_NewID = __UI_NewControl(__UI_Type_ListBox, "LI_ThemeList", 312, 230, 10, 10, __UI_GetID("FR_Themes"))
    __UI_RegisterResult = 0
    Control(__UI_NewID).HasBorder = True
    Control(__UI_NewID).CanHaveFocus = True
    Control(__UI_NewID).BorderSize = 1

    __UI_NewID = __UI_NewControl(__UI_Type_Button, "BT_AddTheme", 80, 23, 160, 195, __UI_GetID("FR_ThemeInfo"))
    __UI_RegisterResult = 0
    SetCaption __UI_NewID, "Add"
    Control(__UI_NewID).CanHaveFocus = True

    __UI_NewID = __UI_NewControl(__UI_Type_PictureBox, "IM_ThemePreview", 230, 110, 10, 80, __UI_GetID("FR_ThemeInfo"))
    __UI_RegisterResult = 0
    Control(__UI_NewID).HasBorder = True
    Control(__UI_NewID).Align = __UI_Center
    Control(__UI_NewID).VAlign = __UI_Middle
    Control(__UI_NewID).BorderSize = 1

    __UI_NewID = __UI_NewControl(__UI_Type_Label, "LB_Description", 230, 60, 10, 15, __UI_GetID("FR_ThemeInfo"))
    __UI_RegisterResult = 0
    SetCaption __UI_NewID, "Description..."
    Control(__UI_NewID).HasBorder = True
    Control(__UI_NewID).VAlign = __UI_Middle
    Control(__UI_NewID).BorderSize = 1

    __UI_NewID = __UI_NewControl(__UI_Type_DropdownList, "CB_Repos", 570, 23, 10, 15, __UI_GetID("FR_Repository"))
    __UI_RegisterResult = 0
    AddItem __UI_NewID, "www.github.com/all-other-usernames-were-taken/QB64-Themes/branch/main/repolist.qbtrepo"
    Control(__UI_NewID).HasBorder = True
    Control(__UI_NewID).Value = 1
    Control(__UI_NewID).CanHaveFocus = True
    Control(__UI_NewID).BorderSize = 1

    __UI_NewID = __UI_NewControl(__UI_Type_ProgressBar, "PB_Repo", 497, 23, 83, 43, __UI_GetID("FR_Repository"))
    __UI_RegisterResult = 0
    SetCaption __UI_NewID, "\92;#"
    Control(__UI_NewID).Max = 100

    __UI_NewID = __UI_NewControl(__UI_Type_Button, "BT_DownloadRepo", 80, 23, 10, 43, __UI_GetID("FR_Repository"))
    __UI_RegisterResult = 0
    SetCaption __UI_NewID, "Download"
    Control(__UI_NewID).CanHaveFocus = True

    __UI_NewID = __UI_NewControl(__UI_Type_TextBox, "TB_ConfigPath", 505, 23, 10, 360, 0)
    __UI_RegisterResult = 0
    SetCaption __UI_NewID, "Path to config.ini"
    Text(__UI_NewID) = "internal\92;config.ini"
    Control(__UI_NewID).HasBorder = True
    Control(__UI_NewID).CanHaveFocus = True
    Control(__UI_NewID).BorderSize = 1

    __UI_NewID = __UI_NewControl(__UI_Type_Button, "BT_SaveConfig", 80, 23, 520, 360, 0)
    __UI_RegisterResult = 0
    SetCaption __UI_NewID, "Save"
    Control(__UI_NewID).CanHaveFocus = True

END SUB

SUB __UI_AssignIDs
    Form1 = __UI_GetID("Form1")
    FR_Themes = __UI_GetID("FR_Themes")
    FR_ThemeInfo = __UI_GetID("FR_ThemeInfo")
    FR_Repository = __UI_GetID("FR_Repository")
    LI_ThemeList = __UI_GetID("LI_ThemeList")
    BT_AddTheme = __UI_GetID("BT_AddTheme")
    IM_ThemePreview = __UI_GetID("IM_ThemePreview")
    LB_Description = __UI_GetID("LB_Description")
    CB_Repos = __UI_GetID("CB_Repos")
    PB_Repo = __UI_GetID("PB_Repo")
    BT_DownloadRepo = __UI_GetID("BT_DownloadRepo")
    TB_ConfigPath = __UI_GetID("TB_ConfigPath")
    BT_SaveConfig = __UI_GetID("BT_SaveConfig")
END SUB
