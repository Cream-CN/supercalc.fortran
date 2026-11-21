!  supercalc.fortran.f90 
!
!  FUNCTIONS:
!   WinMain()      - Entry point for the application;
!                    displays the main window; processes the message loop
!   supercalcfortranSub()  - Callback routine for the main dialog box
!   supercalcfortranApply()- Callback routine for the APPLY button
!

!****************************************************************************
!
!  FUNCTION: WinMain( hInstance, hPrevInstance, lpszCmdLine, nCmdShow )
!
!  PURPOSE:  Entry point for the application
!
!  COMMENTS: Displays the main window and processes the message loop
!
!****************************************************************************

function WinMain( hInstance, hPrevInstance, lpszCmdLine, nCmdShow )
!DEC$ IF DEFINED(_X86_)
!DEC$ ATTRIBUTES STDCALL, ALIAS : '_WinMain@16' :: WinMain
!DEC$ ELSE
!DEC$ ATTRIBUTES STDCALL, ALIAS : 'WinMain' :: WinMain
!DEC$ ENDIF

    use user32
    use kernel32
    use iflogm
    use supercalcfortranGlobals

    implicit none

    integer(SINT) :: WinMain
    integer(HANDLE) hInstance
    integer(HANDLE) hPrevInstance
    integer(LPWSTR) lpszCmdLine
    integer(SINT)   nCmdShow

    include 'resource.fd'

    external supercalcfortranSub
    external supercalcfortranApply

    ! Variables
    type (T_MSG)            mesg
    integer*4               ret
    integer(LRESULT)        lret
    integer(BOOL)           bret
    integer(SINT)           iret

    ghInstance = hInstance
    ghModule = GetModuleHandle(NULL)
    ghwndMain = NULL

    lret = DlgInit(IDD_supercalcfortran_DIALOG, gdlg)
    if (lret == FALSE) goto 99999
    lret = DlgSetSub(gdlg, IDD_supercalcfortran_DIALOG, supercalcfortranSub)
    lret = DlgSetSub(gdlg, IDM_APPLY, supercalcfortranApply)
    lret = DlgModeless(gdlg, nCmdShow)
    if (lret == FALSE) goto 99999

    ! Read and process messsages
    do while( GetMessage (mesg, NULL, 0, 0) ) 
       if ( DlgIsDlgMessage(mesg) .EQV. FALSE ) then
           bret = TranslateMessage( mesg )
           lret  = DispatchMessage( mesg )
       end if
    end do
    call DlgUninit(gdlg)

    WinMain = mesg.wParam
    return

99999 &

    iret = MessageBox(ghwndMain, "Error initializing application supercalcfortran"C, &
                     "Error"C, MB_OK)
    WinMain = 0

end 

!****************************************************************************
!
!  FUNCTION: supercalcfortranSub ( dlg, id, callbacktype )
!
!  PURPOSE:  Dialog box callback for initialization and destroy
!
!  COMMENTS:
!
!****************************************************************************

SUBROUTINE supercalcfortranSub( dlg, id, callbacktype )
!DEC$ ATTRIBUTES DEFAULT :: supercalcfortranSub

  use user32
  use iflogm

  implicit none

  type (dialog) dlg
  integer id, callbacktype

  if (callbacktype == dlg_destroy) then
    call PostQuitMessage(0)
  endif

  END SUBROUTINE supercalcfortranSub

!****************************************************************************
!
!  FUNCTION: supercalcfortranApply ( dlg, id, callbacktype )
!
!  PURPOSE:  Dialog box callback for APPLY button
!
!  COMMENTS:
!
!****************************************************************************

SUBROUTINE supercalcfortranApply( dlg, id, callbacktype )
!DEC$ ATTRIBUTES DEFAULT :: supercalc.fortranApply

  use iflogm

  implicit none

  type (dialog) dlg
  integer id, callbacktype

  if (callbacktype == dlg_clicked) then
    ! TO DO; Add your APPLY logic here
  endif

  END SUBROUTINE supercalcfortranApply


