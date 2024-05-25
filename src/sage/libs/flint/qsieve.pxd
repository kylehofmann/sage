# distutils: libraries = flint
# distutils: depends = flint/qsieve.h

################################################################################
# This file is auto-generated by the script
#   SAGE_ROOT/src/sage_setup/autogen/flint_autogen.py.
# From the commit 3e2c3a3e091106a25ca9c6fba28e02f2cbcd654a
# Do not modify by hand! Fix and rerun the script instead.
################################################################################

from libc.stdio cimport FILE
from sage.libs.gmp.types cimport *
from sage.libs.mpfr.types cimport *
from sage.libs.flint.types cimport *

cdef extern from "flint_wrap.h":
    mp_limb_t qsieve_knuth_schroeppel(qs_t qs_inf) noexcept
    mp_limb_t qsieve_primes_init(qs_t qs_inf) noexcept
    mp_limb_t qsieve_primes_increment(qs_t qs_inf, mp_limb_t delta) noexcept
    void qsieve_init_A0(qs_t qs_inf) noexcept
    void qsieve_next_A0(qs_t qs_inf) noexcept
    void qsieve_compute_pre_data(qs_t qs_inf) noexcept
    void qsieve_init_poly_first(qs_t qs_inf) noexcept
    void qsieve_init_poly_next(qs_t qs_inf, slong i) noexcept
    void qsieve_compute_C(fmpz_t C, qs_t qs_inf, qs_poly_t poly) noexcept
    void qsieve_do_sieving(qs_t qs_inf, unsigned char * sieve, qs_poly_t poly) noexcept
    void qsieve_do_sieving2(qs_t qs_inf, unsigned char * seive, qs_poly_t poly) noexcept
    slong qsieve_evaluate_candidate(qs_t qs_inf, ulong i, unsigned char * sieve, qs_poly_t poly) noexcept
    slong qsieve_evaluate_sieve(qs_t qs_inf, unsigned char * sieve, qs_poly_t poly) noexcept
    slong qsieve_collect_relations(qs_t qs_inf, unsigned char * sieve) noexcept
    void qsieve_write_to_file(qs_t qs_inf, mp_limb_t prime, const fmpz_t Y, const qs_poly_t poly) noexcept
    hash_t * qsieve_get_table_entry(qs_t qs_inf, mp_limb_t prime) noexcept
    void qsieve_add_to_hashtable(qs_t qs_inf, mp_limb_t prime) noexcept
    relation_t qsieve_parse_relation(qs_t qs_inf, char * str) noexcept
    relation_t qsieve_merge_relation(qs_t qs_inf, relation_t  a, relation_t  b) noexcept
    int qsieve_compare_relation(const void * a, const void * b) noexcept
    int qsieve_remove_duplicates(relation_t * rel_list, slong num_relations) noexcept
    void qsieve_insert_relation2(qs_t qs_inf, relation_t * rel_list, slong num_relations) noexcept
    int qsieve_process_relation(qs_t qs_inf) noexcept
    void qsieve_factor(fmpz_factor_t factors, const fmpz_t n) noexcept
