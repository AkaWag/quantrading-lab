---
name: Pine Performance Optimizer
description: Reduce Pine runtime and resource use without changing strategy semantics.
---

# Pine Performance Optimizer

Optimize only after correctness.

Inspect:

- repeated calculations and duplicated `request.*()` calls
- loops over unnecessary history
- arrays, matrices, maps, and object growth
- label, line, box, table, and plot counts
- expensive work repeated on every bar
- opportunities to restrict diagnostics to last/confirmed bars
- functions that can be reused without obscuring logic

Prove semantic equivalence for material changes. Prefer measured Pine Profiler evidence supplied by the user. Do not trade readability for negligible savings.
