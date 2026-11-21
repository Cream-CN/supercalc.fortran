!****************************************************************************
!  Global data, parameters, and structures 
!****************************************************************************

module supercalcfortranGlobals
use iflogm
use ifwinty

implicit none

!  Parameters

integer*4, parameter, public :: SIZEOFAPPNAME = 100

!  Global data

integer(HANDLE)		ghInstance
integer(HANDLE)		ghModule
integer(HANDLE)		ghwndMain
type (dialog) gdlg


end module
