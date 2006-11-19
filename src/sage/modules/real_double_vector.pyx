"""
Vectors with entries that are floating point doubles

AUTHOR:
    -- Josh Kantor (2006-10)
"""

from sage.structure.element cimport ModuleElement

cimport free_module_element
import  free_module_element

cimport complex_double_vector
import  complex_double_vector

import sage.rings.complex_double

include '../ext/stdsage.pxi'

cdef class RealDoubleVectorSpace_element(free_module_element.FreeModuleElement):
    cdef _new_c(self, gsl_vector* v):
        cdef RealDoubleVectorSpace_element y
        y = PY_NEW(RealDoubleVectorSpace_element)
        y._parent = self._parent
        y.v = v
        return y

    cdef gsl_vector* gsl_vector_copy(self):
        """
        Return a copy of the underlying GSL vector of self.
        """
        cdef gsl_vector* v
        v = <gsl_vector*> gsl_vector_alloc(self.v.size)
        if v is NULL:
            raise MemoryError, "error allocating real double vector"
        if gsl_vector_memcpy(v,self.v):
            raise RuntimeError, "error copying real double vector"
        return v

    def __init__(self,parent,x,coerce=True,copy=True):
        free_module_element.FreeModuleElement.__init__(self,sage.rings.real_double.RDF)
        self._parent=parent
        cdef int n
        cdef int i
        n = parent.rank()

        try:
            length = len(x)
        except TypeError:
            if x == 0:
                gsl_set_error_handler_off()
                self.v = <gsl_vector*> gsl_vector_calloc(n)
                if self.v is not NULL:
                    return
                else:
                    self.v = NULL
                    raise MemoryError, "Error allocating memory"


        gsl_set_error_handler_off()
        self.v = <gsl_vector*> gsl_vector_calloc(n)

        if self.v is not NULL and length ==n:
            for i from 0 <=i < n:
                gsl_vector_set(self.v, i, x[i] )

        elif self.v is NULL:
            raise MemoryError, "Error allocating memory for vector"

        elif length !=n:
            raise TypeError,"user supplied bector must be same length as rank of vector space"

    def __dealloc__(self):
        gsl_vector_free(self.v)

    def __len__(self):
        return self.v.size

    def __setitem__(self,size_t i,x):
        if i < 0 or i >=self.v.size:
            raise IndexError
        else:
            gsl_vector_set(self.v,i,x)

    def __getitem__(self,size_t i):
        if i < 0 or i >=self.v.size:
            raise IndexError
        else:
            return gsl_vector_get(self.v,i)

    cdef ModuleElement _add_c_impl(self, ModuleElement right):
        cdef gsl_vector* v
        gsl_set_error_handler_off()
        v = self.gsl_vector_copy()
        if gsl_vector_add(v, (<RealDoubleVectorSpace_element> right).v):
            raise RuntimeError, "error adding real double vectors"
        return self._new_c(v)


    cdef ModuleElement _sub_c_impl(self, ModuleElement right):
        cdef gsl_vector* v
        gsl_set_error_handler_off()
        v = self.gsl_vector_copy()
        if gsl_vector_sub(v, (<RealDoubleVectorSpace_element> right).v):
            raise RuntimeError, "error subtracting real double vectors"
        return self._new_c(v)


    def fft(self):
        cdef complex_double_vector.ComplexDoubleVectorSpace_element result
        cdef int i
        P = self.parent().change_ring( sage.rings.complex_double.CDF )
        result = complex_double_vector.ComplexDoubleVectorSpace_element.__new__(
            complex_double_vector.ComplexDoubleVectorSpace_element, P, None)
        for i from 0 <=i< self.v.size:
            (result.v).data[2*i]= self.v.data[i]
        result.fft(inplace=True)
        return result


