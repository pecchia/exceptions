module errorcodes
#include "errorcodes.h"
  use :: iso_c_binding
  implicit none

INTEGER(C_INT),PARAMETER:: ERR_ALLOC_ERR  =  _ERR_ALLOC_ERR 
INTEGER(C_INT),PARAMETER:: ERR_FILE_ERR  =  _ERR_FILE_ERR 
                                                        
INTEGER(C_INT),PARAMETER:: ERR_ATM_MISMTCH = _ERR_ATM_MISMTCH
INTEGER(C_INT),PARAMETER:: ERR_EGV_VOID    = _ERR_EGV_VOID  
INTEGER(C_INT),PARAMETER:: ERR_EGV_MISMTCH = _ERR_EGV_MISMTCH
INTEGER(C_INT),PARAMETER:: ERR_MAT_UNALLOC = _ERR_MAT_UNALLOC
INTEGER(C_INT),PARAMETER:: ERR_MAT_NOTSQRE = _ERR_MAT_NOTSQRE
                                                        
INTEGER(C_INT),PARAMETER:: ERR_NN_LIST     = _ERR_NN_LIST    
                                                        
INTEGER(C_INT),PARAMETER:: ERR_HAM_UNMAT   = _ERR_HAM_UNMAT  
INTEGER(C_INT),PARAMETER:: ERR_HAM_UNPAIR  = _ERR_HAM_UNPAIR 
INTEGER(C_INT),PARAMETER:: ERR_HAM_ZEROLN  = _ERR_HAM_ZEROLN 

end module errorcodes
