# eiffel_gmp
Eiffel bindings to the GNU Multiple Precision Arithmetic Library

This is an update of the eGMP library by Chris Saunders.

I have made the following changes to the code Chris uploaded to EiffelRoom in 2010:

1) Fixed code so that it compiles with modern versions of GMP (i.e. changed __gmp_const to const)
2) Changed the license from public domain to LGPL v3 (to match the license for GMP)
3) Added header comments and assertions where missing, in the core classes
4) Changed the name of the core classes from MPZ to GMP_INTEGER etc.
5) Changed routine names in core classes from set_mpz to set_gmp_integer etc.
6) Removed convert clause from core classes.
7) Added library.ecf file (works for linux - will need to be modified for other OSs - please send pull request)

Classes intended to be used by clients of the library are named GMP_* (this might not apply to classes in the constant cluster)
Some (eventually all) such classes will be moved into the core cluster. These classes have all been updated w.r.t. standard naming conventions.
Have contracts for non-void-safe mode. And have been extensively tested via generated Autotests.

The principal core classes are GMP_INTEGER, GMP_RATIONAL and GMP_FLOAT.
Classes like MPZ_FUNCTIONS will NOT be renamed.

The thinking behind this naming scheme is that we use eiffel-style naming for classes and routines that users of the library will use.
Also the link to the GMP routines is still clear, so you can check the GMP documentation if you need to.

ECFs should work out of the box for Linux, and most other UNIX style systems, assuming gmp.h is installed on the system. Otherwise you will
need to install the relevant packages (gmp-devel on Fedora). For Windows, you will additionally need to change the linking flag, I think.