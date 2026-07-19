# Build Strategy Prompt

Use `pine-v6-developer` and implement the approved specification in Pine Script v6.

Requirements:
- preserve exact strategy semantics
- make costs, sizing, pyramiding, and execution assumptions explicit
- organize code into inputs, calculations, signals, risk, orders, visuals, alerts, diagnostics
- avoid repainting and lookahead bias
- include a compact on-chart diagnostics table only when useful
- report any assumption that could not be represented exactly in Pine

After the code, provide a pre-compile audit and a TradingView test procedure.
