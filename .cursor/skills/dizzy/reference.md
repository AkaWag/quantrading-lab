# Dizzy reference

## File map

| Path | Role |
|---|---|
| `tools/dizzy/README.md` | Toolchain overview |
| `tools/dizzy/OWNER_SETUP.md` | Owner Discord bot/channel checklist |
| `tools/dizzy/config/channels.example.json` | Allowlist template (tracked) |
| `tools/dizzy/config/channels.json` | Real allowlist (gitignored) |
| `tools/dizzy/.env` | Bot token (gitignored) |
| `tools/dizzy/scripts/export-channel.sh` | Allowlisted export wrapper |
| `tools/dizzy/runtime/exports/` | Quarantine captures |
| `docs/onboarding/DIZZY_AGENT.md` | Mandate |
| `decisions/ADR-009-establish-dizzy-discord-intake-agent.md` | Decision record |
| `.cursor/skills/dizzy/SKILL.md` | This agent skill |

## Current pilot mailbox

- Guild label: `aka_wag's server`
- Channel label: `trader-j`
- Purpose: owner paste/forward external ideas; Dizzy exports from here

## Skill matrix (apply while remaining Dizzy)

| Stage | Skills |
|---|---|
| Export + quarantine | `dizzy` (self) |
| Classify / dedupe | `update-intake-analyst` |
| Write clean artifacts | `documentation-steward` |
| Frame market behavior | `market-behavior-researcher` |
| Draft falsifiable angle | `hypothesis-designer` |
| Risk / invalidation language | `risk-architect`, `risk-manager` |
| Alert design only | `alert-automation-engineer` |
| Chart read / TV | `shotgun` (handoff) |
| Gate / stream decision | `research-director` (handoff) |

## SOURCE.md checklist

- captureId, tool, capturedAtUtc
- guild/channel IDs + labels
- permissionBasis
- quarantine path
- per-message triage table
- exact quotes
- forward origin IDs when present
- media file list
- no secrets

## OBSERVATION.md checklist

- Stream unknown until Director assigns
- What / where-when / why / alternatives / evidence / confidence / next step
- Prefer `unknown` over invented levels
- Confidence starts very low for Discord relays

## ANALYSIS.md checklist

- Facts vs assumptions vs inferences
- Accept / defer / reject table
- Blockers
- Explicit “not verified”

## Director routing codes

| Code | Meaning |
|---|---|
| `ACCEPT_INBOX` | Packet written; waiting Director |
| `ATTACH QT-R-###` | Link to existing research |
| `SHOTGUN_REVIEW` | Needs human-opened chart transcription |
| `DEFER` | Not enough signal yet |
| `REJECT` | Noise / ops / non-actionable |

## Hard denials

- User tokens / self-bots
- Non-allowlisted channels
- Auto TradingView actions from Dizzy seat
- Auto alert deployment
- Live/broker/order routing
- Silent Pine implementation from Discord text
