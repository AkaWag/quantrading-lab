# Repainting and Lookahead Checklist

- [ ] Signals based on confirmed bars where required
- [ ] No negative plot offsets that visually relocate knowledge into the past
- [ ] `request.*()` calls inspected for timeframe and lookahead behavior
- [ ] `barmerge.lookahead_on` absent or correctly offset and documented
- [ ] `timenow`, realtime-only states, and intrabar variables reviewed
- [ ] `calc_on_every_tick` behavior explicitly accepted or disabled
- [ ] Alerts use the same confirmation semantics as entries
- [ ] Historical versus realtime behavior described
- [ ] Pivot/fractal confirmation delay not disguised
- [ ] Strategy does not claim non-repainting without a reasoned audit
