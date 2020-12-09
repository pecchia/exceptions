module sub
  use errorcodes
  use :: iso_c_binding
  implicit none
  private

  public :: testsub1 
  public :: testsub2
  public :: teststop
  public :: testfpe
  public :: testioerror
  public :: testalloc

  integer, parameter :: dp = c_double 

  contains

  subroutine testsub1(array, n, av) bind(c, name='testsub1')
    real(dp) :: array(*) !assumed size array
    integer(c_int) :: n
    real(dp) :: av

    print*,"testsub1"

    av = sum(array(1:n))/n

  end subroutine testsub1


  subroutine testsub2(array, av) bind(c, name='testsub2')
    real(dp) :: array(:) !assumed shape array
    real(dp) :: av
  
    av = sum(array(:))/size(array)

  end subroutine testsub2

  subroutine teststop() bind(c, name='teststop')
    stop 'hard stop in fortran code'
  end subroutine teststop

  subroutine testfpe() bind(c, name='testfpe')
    integer :: a, b, c
    a=5
    b=0
    c = a/b
  end subroutine testfpe

  subroutine testioerror() bind(c, name='testioerror')
    integer :: ios
    open(unit = 20, file = 'scores', status='old', iostat=ios)
    if (ios /= 0) then
      call throw_exception(ERR_FILE_ERR)  
    end if
  end subroutine testioerror

  subroutine testalloc() bind(c, name='testalloc')
    integer(1), allocatable :: A(:)
    integer(c_int64_t) :: hugenum
    integer :: ierr
    hugenum = 4000000000_8  !4 Gb array
    allocate(A(hugenum), stat = ierr)
    if (ierr /= 0) then
      call throw_exception(ERR_ALLOC_ERR)
    else     
      A(hugenum) = 1.0_dp
      print*,A(hugenum)
    end if   
  end subroutine testalloc

  

end module sub
