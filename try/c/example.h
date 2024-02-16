// A safe guard to prevent the header from being defined too many times. This
// happens in the case of circle dependency, the contents of the header is
// already defined.
#ifndef EXAMPLE_H // if EXAMPLE_H is not yet defined.
#define EXAMPLE_H // Define the macro EXAMPLE_H.

// Other headers can be included in headers and therefore transitively
// included into files that include this header.
#include <string.h>

// Like for c source files, macros can be defined in headers
// and used in files that include this header file.
#define EXAMPLE_NAME "Dennis Ritchie"

// Function macros can also be defined.
#define ADD(a, b) ((a) + (b))

// Notice the parenthesis surrounding the arguments -- this is important to
// ensure that a and b don't get expanded in an unexpected way (e.g. consider
// MUL(x, y) (x * y); MUL(1 + 2, 3) would expand to (1 + 2 * 3), yielding an
// incorrect result)

// Structs and typedefs can be used for consistency between files.
typedef struct Node {
  int val;
  struct Node *next;
} Node;

// So can enumerations.
enum traffic_light_state {GREEN, YELLOW, RED};

// Function prototypes can also be defined here for use in multiple files,
// but it is bad practice to define the function in the header. Definitions
// should instead be put in a C file.
Node create_linked_list(int *vals, int len);

// Beyond the above elements, other definitions should be left to a C source
// file. Excessive includes or definitions should also not be contained in
// a header file but instead put into separate headers or a C file.

#endif // End of the if precompiler directive.
