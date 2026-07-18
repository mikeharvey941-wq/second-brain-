# Graded Assignments — Every Week Is a Real Commit
### Companion to `agent-building-learning-schedule.md`, `brand-design-specialist-track.md`, `personal-brand-builder-track.md`, and `agent-harness-architecture.md`.

**How this works:** every assignment below produces a real file inside the `second-brain` repo (structure defined in `agent-harness-architecture.md`). Passing a week means an auto-check passes — a real test, script, or file-presence/content check — not just "it feels done." Where a task is inherently a judgment call (narrative quality, positioning sharpness, visual taste), the auto-check verifies the deliverable *exists and meets structural requirements*, and a separate manual criteria list is graded by review. Both are stated honestly per assignment — I will not pretend a script can grade taste.

**Repo convention:** all auto-checks live in `second-brain/tests/`. Naming: `test_week01.py`, `test_week02.sh`, etc. — Python for anything testing Python code, shell for anything testing repo/file state or live services. Run with `pytest second-brain/tests/test_weekNN.py` or `bash second-brain/tests/test_weekNN.sh`.

**Pass bar, every week:** Pass = auto-check green AND (if manual criteria exist) all manual criteria met. Retry = auto-check green but manual criteria partially met, or auto-check fails on a minor/fixable point. Not Yet = auto-check fails on a structural/conceptual point, or manual criteria mostly unmet.

---

## PHASE 1 — Foundations

### Week 1 — Terminal/CLI fluency
- **Deliverable:** The full `second-brain/` directory tree exists locally, matching the architecture doc's structure (`agents/`, `tools/`, `state/`, `verticals/personal_brand/`, `verticals/company_brand/`, `web/`, `tests/`), plus a `README.md` stub.
- **Assignment:** Using only terminal commands you type yourself, create every folder and a placeholder file in each (even just `.gitkeep`). Write a `README.md` with a one-paragraph description of the project.
- **Auto-check:** `tests/test_week01.sh` — bash script asserting every required directory exists (`test -d`) and `README.md` is non-empty.
- **Manual criteria:** None — this week is purely structural.
- **Why this is the rung:** every future week writes into a folder that has to exist first. This is the literal foundation, not a metaphorical one.

### Week 2 — Git fundamentals
- **Deliverable:** `second-brain` exists as a real GitHub repository, with the Week 1 structure as its first commit, and a `.gitignore` covering `.env`, `__pycache__/`, `node_modules/`.
- **Assignment:** Initialize git, create the GitHub repo (public or private, your call), make your first commit, push it, and add `.gitignore` in a second commit.
- **Auto-check:** `tests/test_week02.sh` — runs `git remote -v` (confirms a remote is set), `git log --oneline` (confirms ≥2 commits), and `cat .gitignore` (confirms required entries present).
- **Manual criteria:** You can explain, out loud, what would happen if you ran `git reset --hard HEAD~1` right now — without running it.
- **Why this is the rung:** every subsequent assignment is graded partly by "is this a real commit" — this week is what makes that possible.

### Week 3 — Reading code / debugging instinct
- **Deliverable:** `second-brain/docs/week03_code_reading.md` — your line-by-line annotation of a real, already-written script (use your own existing Higgsfield upload workflow logic, reconstructed from memory/notes, as the subject).
- **Assignment:** Before running anything, write a prediction of what the script does. Then annotate each line in your own words. Note anywhere your prediction was wrong and why.
- **Auto-check:** `tests/test_week03.py` — asserts the file exists, is over 400 words, and contains the literal headers `## Prediction`, `## Line-by-line`, `## Where I was wrong`.
- **Manual criteria:** The annotations are correct, not just present — reviewed against the actual script logic.
- **Why this is the rung:** this document becomes your reference the first time a real agent throws an error you didn't expect, later in Phase 2.

### Week 4 — Python foundations + API mechanics
- **Deliverable:** `second-brain/tools/higgsfield_client.py` — a real function `upload_and_confirm(filepath: str) -> str` implementing your actual 3-step Higgsfield workflow (media_upload → curl PUT to presigned URL → media_confirm), returning the confirmed media_id.
- **Assignment:** Write this function by hand (with Claude Code explaining, not writing, each part first). It must handle the case where the upload fails (raise a clear exception, don't fail silently).
- **Auto-check:** `tests/test_week04.py` — uses a mocked HTTP client to simulate the 3-step flow and asserts: (1) the function calls all 3 steps in order, (2) it returns the media_id string on success, (3) it raises an explicit exception (not a silent `None`) on a simulated upload failure.
- **Manual criteria:** None beyond the test — this is intentionally code-gradable.
- **Why this is the rung:** this is the first real tool in `tools/` — every specialist agent from Phase 2 onward calls functions like this one.

---

## PHASE 2 — Agent & Harness Mechanics

### Week 5 — The agent loop
- **Deliverable:** `second-brain/agents/router.py` — a `Router` class with a method `run(brief: str) -> dict` that, for now, just logs each conceptual step (received input → decided next action → "called" a stub tool → recorded observation) and returns a dict with a `steps_taken` list.
- **Auto-check:** `tests/test_week05.py` — asserts `Router().run("test brief")` returns a dict containing a non-empty `steps_taken` list with at least 3 entries.
- **Manual criteria:** You can narrate, from memory, what each step in your own `steps_taken` output represents.
- **Why this is the rung:** this file is the one every later week edits — Week 20 turns this stub into the real loop.

### Week 6 — Tool use / function calling, hands-on
- **Deliverable:** `second-brain/agents/positioning.py` — a minimal real agent using the Anthropic API with one custom tool: `lookup_credential(field: str) -> str`, reading from a local `second-brain/data/founder_facts.json` you create (your actual credentials, EMR Inc. facts).
- **Auto-check:** `tests/test_week06.py` — mocks the Anthropic client's tool_use response, asserts your code correctly parses the `tool_use` block, executes `lookup_credential`, and sends a `tool_result` back.
- **Manual criteria:** None beyond the test.
- **Why this is the rung:** this is the first agent in the actual `agents/` folder that will run in the real Positioning role from the harness architecture doc.

### Week 7 — Prompting and context design
- **Deliverable:** `second-brain/agents/prompts/positioning_system_prompt.md` — the real, versioned system prompt for the Positioning agent.
- **Assignment:** Must include explicit sections: role definition, constraints (e.g., "never invent a credential not in founder_facts.json"), and 2 worked examples.
- **Auto-check:** `tests/test_week07.py` — asserts the file exists and contains the literal headers `## Role`, `## Constraints`, `## Examples`, and that `## Examples` contains at least 2 example blocks.
- **Manual criteria:** Run the same brief through the agent with a vague vs. this precise prompt (from Positioning's Module F1 exercise) and confirm the precise one produces a noticeably sharper result.
- **Why this is the rung:** this file becomes the actual prompt `positioning.py` loads in Week 6+ — not a throwaway exercise.

### Week 8 — Multi-step orchestration basics
- **Deliverable:** `router.py` extended so `run()` actually sequences 2 real agents — Positioning then Narrative (Narrative can still be a stub) — with a retry: if an agent call fails once, retry once before raising.
- **Auto-check:** `tests/test_week08.py` — simulates one failure on the first call to a mocked agent and asserts the Router retries exactly once before either succeeding or raising a clear error (not silently swallowing it).
- **Manual criteria:** None beyond the test.
- **Why this is the rung:** this is the actual orchestration logic the whole harness depends on — not a diagram, working code.

### Week 9 — First real micro-agent, end-to-end
- **Deliverable:** `second-brain/agents/narrative.py` (real, not stub) wired through `router.py`, producing a real output file: `second-brain/verticals/personal_brand/outputs/beat_1.md` — one actual narrative beat about your firefighter-to-founder story (Module F2's first beat).
- **Auto-check:** `tests/test_week09.py` — runs the full Router → Positioning → Narrative chain against a real brief and asserts `outputs/beat_1.md` exists, is non-empty, and is over 50 words.
- **Manual criteria:** The beat is actually usable — you'd send it as-is or with light editing.
- **Why this is the rung (end of Phase 2):** this is the first real, usable output your harness has ever produced. Everything before this was scaffolding; this is proof it works.

---

## PHASE 3 — Real Project: Content Generator (Company Brand Vertical)

### Week 10 — Map the manual content workflow
- **Deliverable:** `second-brain/verticals/company_brand/partner_spotlight_spec.md`
- **Assignment:** Numbered, step-by-step spec of your actual current manual partner-spotlight process (PIL crop → Higgsfield text swap → post).
- **Auto-check:** `tests/test_week10.py` — asserts the file exists and contains at least 5 numbered steps.
- **Manual criteria:** The spec matches what you actually do, verified by you reading it back against your own memory of the last spotlight you made.

### Week 11 — Build tool wrappers
- **Deliverable:** `higgsfield_client.py` extended with a real `generate_partner_spotlight(template_media_id: str, partner_image_path: str) -> str` function (returns the generated asset's media_id).
- **Auto-check:** `tests/test_week11.py` — mocked API test asserting correct parameters are passed to the underlying `generate_image` call (correct `medias` array format, roles `image`/`reference`).

### Week 12 — Wire into a loop with a human checkpoint
- **Deliverable:** `second-brain/agents/copy_formatting.py` + `router.py` updated so a full spotlight-generation run stops at a `status: "awaiting_approval"` state rather than auto-publishing.
- **Auto-check:** `tests/test_week12.py` — asserts the pipeline's returned dict has `status == "awaiting_approval"` and includes the draft asset reference, and that no "publish" function was called during the test run.

### Week 13 — Add a mobile trigger (Telegram/Slack)
- **Deliverable:** `second-brain/tools/telegram_bot.py` — a real bot handler that receives a message and calls `router.run()`.
- **Auto-check:** `tests/test_week13.py` — constructs a mock Telegram update object and asserts the handler correctly extracts the message text and calls `Router.run()` with it.
- **Manual criteria:** You actually trigger a real draft from your phone at least once.

### Week 14 — Harden and document (end of Phase 3)
- **Deliverable:** Every function touched in Weeks 11-13 gets error handling (no unhandled exceptions on bad input); `second-brain/README.md` gets a real "How to run this" section.
- **Auto-check:** `tests/test_week14.py` — feeds each function deliberately malformed input (missing file, bad API response) and asserts each raises a clear, typed exception rather than crashing uncontrolled or returning `None` silently.
- **Manual criteria:** README section is accurate — someone else (or you in 3 months) could follow it cold.

---

## PHASE 4 — Local Models & Infrastructure Literacy

### Week 15 — Local model mechanics
- **Deliverable:** Ollama installed and running locally; `second-brain/tests/test_week15.sh` — pings the local Ollama endpoint and confirms a response.
- **Manual criteria:** You can explain, correctly, why GLM-5.2 (744B params) cannot run on this same local setup.

### Week 16 — API vs. local trade-off analysis
- **Deliverable:** `second-brain/docs/model_assignment_decision.md` — a real table, one row per agent role (Router, Positioning, Narrative, Visual Direction, Copy/Formatting, Brand QA, Document Assembly, Research/Grounding), each with your own cost/latency/privacy reasoning.
- **Auto-check:** `tests/test_week16.py` — asserts the file exists and contains a markdown table with exactly those 8 role names present.

### Week 17 — The hardware decision
- **Deliverable:** `second-brain/docs/hardware_decision.md` — a final written decision with reasoning.
- **Auto-check:** `tests/test_week17.py` — asserts the file exists, non-empty, and contains a line starting with `Decision:`.
- **Manual criteria:** The decision follows logically from Week 16's table, not from the original untested assumption.

### Week 18 — Set up the real environment (end of Phase 4)
- **Deliverable:** `.env.example` listing every required key (Anthropic, Higgsfield, Adobe, Figma, and your chosen GLM-5.2 provider); real `.env` populated locally (never committed).
- **Auto-check:** `tests/test_week18.py` — asserts every variable name in `.env.example` is set in the actual environment (checks presence only, never logs values).

---

## PHASE 5 — Build Your Own Harness

### Week 19 — Study existing harness patterns
- **Deliverable:** `second-brain/docs/harness_patterns_notes.md`
- **Auto-check:** `tests/test_week19.py` — asserts the file mentions "ReAct", "planner-executor", and "subagent" by name, with your own notes under each.
- **Manual criteria:** Correctly identifies which pattern `router.py` currently follows.

### Week 20 — Build the minimal harness for real
- **Deliverable:** `router.py`'s raw loop (no framework), completing a real 2-step task (Positioning → Narrative) fully unattended.
- **Auto-check:** `tests/test_week20.py` — integration test running the full loop against a canned real brief, asserting `steps_taken` has ≥2 real (non-stub) entries and the final output is non-empty.

### Week 21 — Add routing logic between models/tools
- **Deliverable:** `second-brain/tools/model_router.py` — real function `get_model_client(task_type: str) -> dict` (returns model/provider config), correctly routing at least Positioning and Copy/Formatting to two different models.
- **Auto-check:** `tests/test_week21.py` — asserts `get_model_client("positioning")` and `get_model_client("copy_formatting")` return different model identifiers, matching your Week 16 decision doc.

### Week 22 — Add persistence/memory (end of Phase 5)
- **Deliverable:** `second-brain/state/store.py` — simple JSON or SQLite persistence; `Router` saves state after a run and can reload it.
- **Auto-check:** `tests/test_week22.py` — runs the harness once, kills the Python process (new instance), reloads state, and asserts the reloaded state matches what was saved.

---

## PHASE 6 — Full-Stack Independence: Websites & Apps

### Week 23 — Web fundamentals
- **Deliverable:** `second-brain/web/` — a working input page (plain HTML/CSS/JS or a minimal Next.js scaffold) with a text input and submit button, no backend wiring yet.
- **Auto-check:** `tests/test_week23.sh` — starts a local static server and asserts the page returns HTTP 200 and contains an `<input>` and a submit control.

### Week 24 — Backend/database fundamentals
- **Deliverable:** `second-brain/state/schema.md` documenting your actual state schema, plus one real query run against it.
- **Auto-check:** `tests/test_week24.py` — runs the documented query against the real state DB and asserts it returns without error.

### Week 25 — Build one full small app solo
- **Deliverable:** `web/` wired end-to-end: submitting a brief calls `router.run()` via a real API route and displays the output.
- **Auto-check:** `tests/test_week25.py` — hits the local API route with a real brief and asserts a valid, non-empty JSON response.

### Week 26 — Deployment literacy
- **Deliverable:** Repo deployed to Vercel; live URL recorded in `README.md`.
- **Auto-check:** `tests/test_week26.sh` — `curl`s the live URL and asserts HTTP 200.

### Week 27 — Rebuild an outsourced project (end of Phase 6)
- **Deliverable:** `second-brain/web/legacy_rebuild/` — one previously outsourced Wix/Lovable page, rebuilt by you.
- **Manual criteria:** Side-by-side content/structure parity with the original, built without asking anyone how.

---

## PHASE 7 — Ongoing: Full Agent Network & Wellness App (Week 28+)
- **Deliverable:** `second-brain/verticals/wellness_app/` scaffolded, mirroring `personal_brand/` and `company_brand/` structure.
- **Auto-check:** `tests/test_phase7.sh` — asserts the new vertical folder mirrors the required subfolder structure of the existing two.
- **Ongoing rhythm (not a single checkpoint):** every 1-2 weeks, ship one real improvement to any vertical, write what broke in `docs/retro_log.md`, and log it in `PROGRESS.md`.

---

## SPECIALIZATION TRACK A-E — Brand & Visual Design (mapped to `verticals/company_brand/design_system/`)

| Module | Deliverable | Auto-check | Manual criteria |
|---|---|---|---|
| A1 Typography | `design_system/typography_rationale.md` | File exists, names 3+ typefaces with a role each | Justifications are structurally sound, not just aesthetic preference |
| A2 Color theory | `design_system/palette_rationale.md` | File exists, table with role column (primary/accent/neutral/restricted) | Restricted-use color has an explicit meaning-based reason |
| A3 Layout/composition | `design_system/layout_annotations.md` + 1 annotated screenshot | Both files exist | Annotation correctly identifies grid/hierarchy elements |
| A4 Verbal identity | `design_system/voice_brief_template.md` | Contains banned-words section (5+) and preferred-lines section (5+) | An outside reader (or Claude Code with no other context) can write one on-brand line from the brief alone |
| A5 Moodboarding | `design_system/moodboard/` (12 real images, generated or curated) + `moodboard_brief.md` with one reason per image | 12 images present, brief has 12 corresponding entries | Someone unfamiliar with the brief can guess the intended tone |
| B1 Figma | `tools/figma_client.py` real wrapper | Mocked-MCP test asserts correct call structure | — |
| B2 Adobe | `tools/adobe_client.py` real vectorize wrapper | Mocked test asserts correct call structure | One real logo sketch taken to clean vector |
| B3 Higgsfield deepened | `higgsfield_client.py` gets `generate_mood_set()` | Mocked test asserts multi-image, consistent-reference call structure | 3-image set is visually consistent |
| B4 Canva | N/A (manual tool, no code) | — | One week of social assets produced in under an hour |
| C1-C3 Brand system methodology | `verticals/company_brand/brand_system_v2/` full redo of OHPAH system + one novel-brief system | Both folders exist with all sub-deliverables (palette, type, logo direction, verbal identity) | Redo converges close to actual locked OHPAH system; novel-brief system is presentable |
| D Capstone | Company brand vertical fully wired through the harness (agents + tools + verticals/company_brand) | Same auto-checks as Phase 5/6 weeks, applied to the company_brand vertical specifically | Output usable with only light manual polish |

---

## SPECIALIZATION TRACK F1-F8 — Personal Brand Builder (mapped to `verticals/personal_brand/`)

| Module | Deliverable | Auto-check | Manual criteria |
|---|---|---|---|
| F1 Positioning | `verticals/personal_brand/positioning.md` | File exists, contains one sentence matching the "I'm the [X] who [Y], for [Z], because [W]" structure | A person unfamiliar with OHPAH doesn't ask "wait, so what do you do" |
| F2 Narrative architecture | `verticals/personal_brand/narrative_beats.md` | 4 distinct beats present, each 3-4 sentences | 90-second and 5-minute combined versions both read naturally |
| F3 Visual identity of the person | `verticals/personal_brand/visual_brief.md` | Contains setting, wardrobe notes, and 3 named shot types | Brief is usable to hand directly to a photographer |
| F4 Platform-specific presence | `verticals/personal_brand/platform_strategy.md` | Contains a ranked list of 2-3 committed platforms + explicit skip list | Reasoning per platform is specific, not generic |
| F5 Content pillars | `verticals/personal_brand/content_pillars.md` | 3-5 pillars named, 5 post ideas each (15-25 total) | Ideas are genuinely distinct, not restatements |
| F6 Credibility sheet | `verticals/personal_brand/credibility_sheet.md` | Contains all real proof points (FL-CEMS talk, Expo, patents, dataset, accelerator, credentials) each linked to the F1 positioning sentence | Usable handed directly to a journalist/investor |
| F7 Bio library | `verticals/personal_brand/bio_library.md` | All 5-6 bio variants present (tag, 50-word, 150-word, stage intro, founder-letter voice, X-style) | Each variant is genuinely usable as-is |
| F8 Capstone | Personal brand vertical fully wired through the harness | `tests/test_f8.py` — feeds one unseen rough idea through the full Router → Positioning → Narrative → Copy chain and asserts LinkedIn + stage-version outputs are both produced and non-empty | Both outputs clearly sound like you, not generic founder-content voice |

**Dated milestones remain as previously set:** F1-F3 usable before FL-CEMS; F6-F7 finished before EMS World Expo — these override the weekly pace if the calendar forces it.

---

## A note on honesty in grading
Not everything above is truly auto-gradable, and I said so explicitly rather than pretending otherwise — narrative quality, positioning sharpness, and visual taste are judgment calls, checked structurally by script and substantively by review. Where an assignment says "auto-check" only, it means the structural bar is genuinely sufficient for that task (e.g., a function correctly parsing a tool_use block either does or doesn't). Where it also lists "manual criteria," treat both as required for a real Pass — a green test with hollow content is a Retry, not a Pass.
