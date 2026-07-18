# Agent Harness Architecture: "Second Brain"
### The harness is the product. The Personal Brand Builder is Vertical #1 running on top of it.

**Reframe:** Everything built in Module D (company-brand agent) and Module F8 (personal-brand agent) are not two separate one-off tools — they're the first two "verticals" that prove out one shared architecture: a team of specialist agents, coordinated by a router, each doing one job well, some using different models because the job calls for it. This document is the actual target of main-curriculum Phase 5 (build your own harness). Everything in Modules D and F8 gets built *inside* this architecture, not alongside it.

This is also the literal, correctly-scoped version of the original "GLM via Claude Code + Hermes layer" idea — the Router Agent below *is* that layer, built with understanding instead of as a buzzword.

---

## 1. The team of agents

Each agent has one job. This is deliberate — a single do-everything agent is harder to debug, harder to improve piece by piece, and forces every task onto one model even when that's the wrong tool.

| Agent | Job | Model / tool it should use | Why this model |
|---|---|---|---|
| **Router / Orchestrator** | Receives the raw input (a brief, an idea, a voice memo transcript). Decides which specialist agents to call, in what order, and assembles their outputs into a final result. Holds the overall state. | A strong reasoning model (Claude Sonnet, or GLM-5.2 via API) | This job requires judgment — deciding what a vague input actually needs. Cheap models make bad routing decisions, and routing mistakes cascade through every downstream agent. |
| **Positioning Agent** | Extracts or refines the specific angle (F1 for personal, or the equivalent Discovery stage for company brand): who this is for, what makes it credible, what's the one sentence. | Strong reasoning model (same tier as Router) | Nuanced synthesis of scattered facts into one sharp claim — not a mechanical task. |
| **Narrative Agent** | Generates and organizes story beats (F2) or brand story elements; keeps them modular/recombinable rather than one fixed script. | Strong reasoning + creative-writing model (Claude) | Needs genuine writing quality, not just retrieval. |
| **Visual Direction Agent** | Produces mood boards, palette proposals, logo/image concepts. Wraps calls to Higgsfield / Adobe for creativity (generation, vectorization) and Figma (systems). | Image-generation APIs, orchestrated by a lighter reasoning model that just sequences the calls | The intelligence here is mostly in the tool calls (image models), not in chat reasoning — don't waste an expensive model's tokens narrating what an image API is about to do. |
| **Copy/Platform-Formatting Agent** | Takes the core narrative/positioning and reformats it per platform (LinkedIn post, Instagram caption, stage version, pull-quote) or per brand asset (social template copy). | A smaller/cheaper model (Haiku-class, or a local 7-13B model once Phase 4 is done) | This is repurposing, not originating — it's the clearest candidate for cost savings once you trust the pattern, and a good first place to test a local model in production. |
| **Brand/Voice QA Agent** | Checks every output against locked rules: banned words, palette values, voice constraints (no em dashes, no exclamation points, etc. — same pattern as your OHPAH voice rules). | Cheap/fast model, or even non-LLM code (regex/rule checks) doing the first pass, with a lightweight model doing judgment calls the code can't catch | Rule-checking is mostly deterministic. Don't pay reasoning-model prices for a banned-word scan. |
| **Document Assembly Agent** | Assembles final outputs into real deliverables: a brand book PDF, a bio library doc, a credibility sheet. | Mostly code (your docx/PDF skill fluency from the main curriculum), a model only for final polish pass | This is the payoff step — turning agent outputs into something presentable, not another reasoning task. |
| **Research/Grounding Agent** | Pulls or verifies facts when needed (a citation, a stat, a competitor reference) using web search. | A model with web search tool access | Keeps the creative agents from quietly inventing "facts" — this agent's whole job is staying honest. |

**The pattern to notice:** expensive, judgment-heavy work (Router, Positioning, Narrative) uses your best model. Mechanical, repetitive, or rule-based work (formatting, QA, assembly) uses cheap or local models. This is the actual skill "using different models for different agents" refers to — not using different models arbitrarily, but matching model cost/capability to task difficulty.

---

## 2. How a request flows through the system

1. You (or a UI) submit a brief: *"Draft something for LinkedIn about the FL-CEMS talk going well."*
2. **Router** reads it, checks what's needed — this is a Copy/Platform task drawing on existing Positioning + Narrative outputs, not a fresh Positioning pass.
3. Router pulls stored Positioning/Narrative context (from prior runs — this is where Phase 5's "add persistence/memory" week matters) and calls **Copy/Platform-Formatting Agent**.
4. Output passes through **Brand/Voice QA Agent** before being returned.
5. If the request instead were "build me a brand book for a new partner," the Router would sequence Positioning → Narrative → Visual Direction → Copy → QA → Document Assembly, in order, each agent's output feeding the next.

This sequencing logic — not any single agent — is the actual hard part of harness design, and it's exactly what main-curriculum Phase 5, Week 21 ("add routing logic") is building toward. Build it here, for real, instead of a toy example.

---

## 3. Repo structure (GitHub)

```
second-brain/
├── README.md                  # what this is, how to run it
├── CLAUDE.md                  # this project's own tutor/dev instructions (separate from the learning-curriculum CLAUDE.md)
├── agents/
│   ├── router.py
│   ├── positioning.py
│   ├── narrative.py
│   ├── visual_direction.py
│   ├── copy_formatting.py
│   ├── brand_qa.py
│   ├── document_assembly.py
│   └── research_grounding.py
├── tools/
│   ├── higgsfield_client.py
│   ├── adobe_client.py
│   ├── figma_client.py
│   └── model_router.py        # decides which model/API a given agent call uses
├── state/
│   └── (persistence layer — starts as simple JSON/SQLite, per Phase 5 Week 22)
├── verticals/
│   ├── personal_brand/        # Vertical #1 — your own brand, F1-F8 outputs live here
│   └── company_brand/         # Vertical #2 — OHPAH and future brand work, Module D outputs live here
└── web/
    └── (the front-end — see Section 4)
```

Two verticals sharing one `agents/` and `tools/` layer is the actual proof that the architecture is real — if adding a third vertical later only means adding a new folder under `verticals/` and not rewriting the agents, the design worked.

---

## 4. Deployment: making it a real, viewable product

- **Repo:** push to GitHub under the Emergency-Medical-Resolutions org, or a personal org if you want this decoupled from OHPAH's codebase — decide this deliberately, since personal-brand tooling living inside the company's GitHub org has a different visibility/ownership implication than a separate one.
- **Front-end:** a simple web app (Next.js is the standard pairing with Vercel) with:
  - An input box for a brief/idea
  - A view of which agents ran and what each contributed (this is good for demoing the *system*, not just the output — useful if this ever becomes something you show investors or pitch as a capability)
  - The final assembled output (post drafts, or a rendered brand book)
- **Hosting:** Vercel is the natural choice — connects directly to the GitHub repo, deploys on push, gives you a real URL (`your-project.vercel.app` or a custom domain) with no separate server to manage.
- **Sequencing with the main curriculum:** this deployment step is literally main-curriculum Phase 6, Weeks 26 ("deployment literacy"). Don't front-load Vercel setup before you understand what a deploy actually does — but know that this is where Phase 6 is heading, concretely, not abstractly.

---

## 5. How this reframes Modules D and F8

- **Module D (company-brand capstone)** becomes: build the `company_brand` vertical inside this shared architecture, using the agents already defined above.
- **Module F8 (personal-brand capstone)** becomes: build the `personal_brand` vertical the same way — and since you're doing yours first, this is where you actually build and test the Router, Positioning, and Narrative agents for the first time.
- Practically: **F8 gets built first**, and in building it, you're simultaneously building the shared `agents/` and `tools/` layer that Module D will later reuse. This is more efficient than building them as two unrelated exercises.

---

## 6. What to explicitly decide later, not now
- Whether personal-brand and company-brand verticals ever get a third: a genuinely productized "sell this to other founders" version (this was the earlier fork you deliberately deferred — right call, don't reopen it until F8 actually works on your own case).
- Whether the Router itself should eventually call a local model (post Phase 4) for cost reasons, once you've measured whether Router-quality reasoning actually degrades on a cheaper model — don't assume either way before testing.
