# Progress Log

Claude Code: read this at the start of every session per `CLAUDE.md`. Update it at the end of every session per the session-end protocol. Do not delete history — this file is append-only for the session log, and the checkpoint table should be edited in place.

## Current status
- **Current Phase:** 1 — Foundations
- **Current Week:** 2 — Git fundamentals
- **Last session date:** 2026-07-18

## Checkpoint log

| Week | Topic | Grade (Pass / Retry / Not Yet) | Date | Notes |
|---|---|---|---|---|
| 1 | Terminal/CLI fluency | Pass | 2026-07-18 | Real terminal, all commands typed. Struggled: tried plain-English "navigate" instead of a real command; missing space/wrong case in cd (cd/desktop/second-brain); typo'd tests as test; forgot to touch agents/.gitkeep initially; needed code . PATH setup walkthrough. All errors self-diagnosed correctly after prompting. Auto-check (tests/test_week01.sh) run for real: PASS. |
| 2 | Git fundamentals | | | |
| 3 | Reading code / debugging instinct | | | |
| 4 | Python foundations + API mechanics | | | |
| 5 | The agent loop | | | |
| 6 | Tool use / function calling, hands-on | | | |
| 7 | Prompting and context design | | | |
| 8 | Multi-step orchestration basics | | | |
| 9 | First real micro-agent | | | |
| 10 | Map the manual content workflow | | | |
| 11 | Build tool wrappers | | | |
| 12 | Wire into a loop with human checkpoint | | | |
| 13 | Add mobile trigger (Telegram/Slack) | | | |
| 14 | Harden and document | | | |
| 15 | Local model mechanics | | | |
| 16 | API vs. local trade-off analysis | | | |
| 17 | The hardware decision | | | |
| 18 | Set up real environment | | | |
| 19 | Study existing harness patterns | | | |
| 20 | Build minimal harness from scratch | | | |
| 21 | Add routing logic between models/tools | | | |
| 22 | Add persistence/memory | | | |
| 23 | Web fundamentals | | | |
| 24 | Backend/database fundamentals | | | |
| 25 | Build one full small app solo | | | |
| 26 | Deployment literacy | | | |
| 27 | Rebuild an outsourced project | | | |
| 28+ | Ongoing: agent network + wellness app | | | |

## Specialization track: Brand & Visual Design (parallel — see `brand-design-specialist-track.md`)

| Module | Topic | Grade (Pass / Retry / Not Yet) | Date | Notes |
|---|---|---|---|---|
| A1 | Typography systems | | | |
| A2 | Color theory and palette construction | | | |
| A3 | Layout, composition, grid systems | | | |
| A4 | Verbal identity methodology | | | |
| A5 | Systematic moodboarding | | | |
| B1 | Figma fluency | | | |
| B2 | Adobe for creativity tools | | | |
| B3 | Higgsfield (deepened) | | | |
| B4 | Canva (speed work) | | | |
| C1 | The repeatable 4-stage process | | | |
| C2 | Redo OHPAH's brand system from scratch | | | |
| C3 | Full process on a novel brief | | | |
| D | Capstone: brand-generation agent | | | |
| E | Portfolio: 2-3 full brand collections | | | |

## Personal brand builder track (parallel — see `personal-brand-builder-track.md`)

| Module | Topic | Grade (Pass / Retry / Not Yet) | Date | Notes |
|---|---|---|---|---|
| F1 | Positioning | | | |
| F2 | Narrative architecture | | | |
| F3 | Visual identity of the person | | | |
| F4 | Platform-specific presence | | | |
| F5 | Content pillars and calendar system | | | |
| F6 | Proof and credibility asset inventory | | | |
| F7 | Bio and asset library | | | |
| F8 | Capstone: personal brand agent | | | |

**Dated milestones (independent of weekly pace):**
- [ ] F1-F3 usable before FL-CEMS "Invisible Load" presentation
- [ ] F6-F7 finished before EMS World Expo (Sept 28-Oct 2, Booth 1731)

## Harness architecture build (see `agent-harness-architecture.md`)

| Component | Status | Date | Notes |
|---|---|---|---|
| Repo scaffolded (`second-brain/` structure) | | | |
| Router / Orchestrator agent | | | |
| Positioning agent | | | |
| Narrative agent | | | |
| Visual Direction agent | | | |
| Copy/Platform-Formatting agent | | | |
| Brand/Voice QA agent | | | |
| Document Assembly agent | | | |
| Research/Grounding agent | | | |
| Persistence/state layer | | | |
| `personal_brand` vertical wired up | | | |
| `company_brand` vertical wired up | | | |
| Front-end (Next.js) built | | | |
| Deployed to Vercel with live URL | | | |

## Overrides (skipped without a Pass)
- **2026-07-17** — Repo setup (git init, first commit, GitHub remote, push) was done by Claude Code before Week 1 or Week 2 began, as one-off session administration — not a graded rep. Does NOT count as a Week 2 Pass. Week 2 will still be run for real when we get there, commands typed by Michael.

## Session log (append-only — newest at bottom)
- **[date]** — Week —, topic —. What we covered: —. Result: —. Next step: —.
- **2026-07-18** — Week 1, Terminal/CLI fluency. What we covered: pwd, cd, ls (incl. -a), mkdir (incl. -p and multi-arg), touch, reading real zsh errors (command not found vs. no such file or directory vs. permission denied), VS Code + code . setup. Built the full second-brain/ directory tree and a real README.md, all typed by Michael in his own terminal/VS Code, not run by Claude Code. Result: Pass (auto-check tests/test_week01.sh run for real, all green). Next step: Week 2 — git fundamentals (init, commit, push, .gitignore) — note the repo/remote already technically exist from prior session admin, but the actual git commands should still be typed fresh by Michael for the rep to count.
