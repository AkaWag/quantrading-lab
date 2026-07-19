# Backtest Audit Checklist

- [ ] Hypothesis existed before parameter search
- [ ] Symbol, exchange, timeframe, session, timezone, and test dates recorded
- [ ] Commission, spread, slippage, and fill assumptions are realistic
- [ ] Position sizing and pyramiding are explicit
- [ ] No future leakage or unoffset lookahead
- [ ] Higher/lower timeframe requests reviewed
- [ ] Intrabar behavior and broker emulator assumptions reviewed
- [ ] Adequate number of independent trades
- [ ] Results assessed across multiple regimes and symbols where relevant
- [ ] In-sample and out-of-sample periods separated
- [ ] Parameter sensitivity checked
- [ ] Benchmark and buy-and-hold comparison considered
- [ ] Drawdown depth and duration acceptable under the stated mandate
- [ ] Turnover, exposure, and concentration reported
- [ ] Failure criteria documented
