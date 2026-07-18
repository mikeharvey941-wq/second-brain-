# From Prompting to Building: Full Learning Schedule
### Goal: build your own harness, write your own software, and ship websites/apps using a full agent network you own — not one you rent from Vikelas.

**Pace:** 5-10 hrs/week
**Total length:** ~28 weeks (~6-7 months)
**Rule for every week:** use Claude Code as your tutor, not your ghostwriter. Ask it to explain before it acts, ask "what would break this," and type commands yourself instead of letting it run autonomously. The point of every exercise below is that YOU could redo it with no AI present, even badly.

---

## PHASE 1 — Foundations (Weeks 1-4)
**Why this phase exists:** Every agent tool — Claude Code, Codex, a local harness — is a thin layer over a terminal, a filesystem, git, and API calls. If those four things are a black box to you, every "agent" will always feel like magic you're renting instead of a machine you understand. This phase makes the black box transparent.

### Week 1 — Terminal/CLI fluency
- **Objective:** Navigate directories, create/move/delete files, run a script, read error output without panicking.
- **Why:** This is the floor everything else sits on. Claude Code's suggestions are terminal commands. If you can't read them, you can't supervise them.
- **Exercise:** With Claude Code, learn `cd`, `ls`, `mkdir`, `mv`, `cat`, `python3 script.py` — but you type each command yourself and ask what it does to your filesystem before running it.
- **Checkpoint:** From a blank terminal, create a folder, put a file in it, run that file. Zero AI help.

### Week 2 — Git fundamentals
- **Objective:** Understand repository, commit, branch, push as concepts — not just commands. Git is a series of saved snapshots you can travel between.
- **Why:** Everything Moses and Vikelas maintain lives in git. Right now you can't see your own project's history or undo a mistake. This is the single biggest disempowering gap for a non-technical founder.
- **Exercise:** Create a throwaway GitHub repo. Make a file, commit it, edit it, commit again, look at the diff between the two commits.
- **Checkpoint:** Explain "reverting a commit" to Alpheus in one sentence, correctly.

### Week 3 — Reading code / debugging instinct
- **Objective:** Read a 30-50 line script and describe what it does, line by line, before running it.
- **Why:** This is the actual difference between someone who directs agents well and someone who's along for the ride. Agents will occasionally produce a wrong "fix" that just hides an error — you need to be able to catch that.
- **Exercise:** Before running any script Claude Code writes, write a one-sentence prediction of its output. Run it. Compare.
- **Checkpoint:** When something errors, identify which line caused it from the error message alone, before asking the AI.

### Week 4 — Python foundations + what an API call actually is
- **Objective:** Variables, functions, loops, reading/writing files, calling an API and handling a JSON response.
- **Why:** Python underlies your Whisper/Claude Haiku dispatch pipeline and most content automation. Every "agent" is fundamentally a loop of API calls — if that's fuzzy, "harness" stays a buzzword instead of a mechanism.
- **Exercise:** Write, by hand, a script that reads a text file of partner names and prints a caption template for each. Then have Claude Code make one raw `curl` API call (e.g. to Higgsfield, which you already use manually) and explain each part of the request before sending it.
- **Checkpoint (end of Phase 1):** Without AI help, write a script from scratch that reads a small CSV, transforms one column, writes a new file. Under 20 minutes.

---

## PHASE 2 — Agent & Harness Mechanics (Weeks 5-9)
**Why this phase exists:** You now have the raw materials. This phase teaches you what a "harness" actually is mechanically — a loop, not magic — so that "wiring GLM into Claude Code with a routing layer" stops being a phrase you repeat and becomes something you could diagram on a napkin.

### Week 5 — The agent loop
- **Objective:** Understand the loop: system prompt + context → model call → model requests a tool → tool executes → result fed back to model → repeat until done.
- **Why:** This loop is the entire "secret" behind Claude Code, Codex, and any custom harness. Once you see it, the mystery goes away.
- **Exercise:** Have Claude Code narrate its own loop on a real task you give it — ask it to state, at each step, "here's what I just decided and why" before acting.
- **Checkpoint:** Draw the loop on paper from memory.

### Week 6 — Tool use / function calling, hands-on
- **Objective:** Build one tiny agent yourself using the Anthropic API directly, with one custom tool (e.g. a toy `get_weather` function).
- **Why:** Reading about function calling is not the same as watching your own code receive a `tool_use` block and having to write the code that executes it and sends back a `tool_result`.
- **Exercise:** Write ~40 lines of Python that calls the API, detects a tool call, runs a fake function, and sends the result back for a final answer.
- **Checkpoint:** Explain why the model can't just "run the tool itself" — why your code has to be the one executing it.

### Week 7 — Prompting and context design for agents
- **Objective:** Learn system prompts, context window limits, and the common failure modes (context rot, ambiguous tool definitions, silent wrong answers).
- **Why:** A harness is only as good as what you feed it. This is the skill that separates someone who gets reliable agents from someone who gets flaky ones.
- **Exercise:** Take a task, run it with a vague prompt, then a precise one with explicit constraints. Compare failure rates.
- **Checkpoint:** Identify, in your own OHPAH prompts/docs, one place where ambiguity likely causes inconsistent output.

### Week 8 — Multi-step orchestration basics
- **Objective:** Understand sequential agents vs. looping agents, retries, and error handling in a chain of steps.
- **Why:** Real work (like your content pipeline) is rarely one call — it's a chain where step 3 depends on step 2's output. This is where "harness" design decisions actually live.
- **Exercise:** Sketch (on paper, then in pseudocode) the steps your weekly partner-spotlight workflow already goes through manually.
- **Checkpoint:** Identify which steps could fail and what should happen when they do.

### Week 9 — Your first real micro-agent
- **Objective:** Build a small script that checks for a new partner post trigger and drafts a caption using an API call.
- **Why:** This is deliberately tied to your actual business, not a toy — first proof that you can build something real, not just follow tutorials.
- **Exercise:** Build it, break it once on purpose, fix it yourself before asking Claude Code.
- **Checkpoint:** It runs end-to-end once, unattended.

---

## PHASE 3 — Real Project: The Content Generator (Weeks 10-14)
**Why this phase exists:** This is where dependence on Vikelas for content-adjacent work ends. You take your actual manual workflow (PIL crop → Higgsfield text swap → manual posting) and turn it into something you own end-to-end, including mobile control.

### Week 10 — Map the current manual workflow
- **Objective:** Write out every discrete step of your partner-spotlight process as a numbered list of inputs/outputs.
- **Why:** You can't automate what you haven't first made explicit. This document becomes your build spec.
- **Checkpoint:** A written, step-by-step spec of the current manual process.

### Week 11 — Build tool wrappers
- **Objective:** Turn each step (image upload, template swap, caption draft) into its own small function/tool.
- **Why:** Small, single-purpose tools are easier to debug and reuse than one giant script — this is real software architecture, not just scripting.
- **Checkpoint:** Each function works standalone, tested separately.

### Week 12 — Wire it into a loop with a human checkpoint
- **Objective:** Chain the tools into one agent loop, with a pause for your approval before anything posts publicly.
- **Why:** You want automation with a human-in-the-loop safety valve, especially early — full autonomy comes later, once you trust it.
- **Checkpoint:** The full pipeline runs and stops for your sign-off before publishing.

### Week 13 — Add a mobile trigger (Telegram/Slack)
- **Objective:** Wire a Telegram or Slack bot as the trigger/interface, so you can run this from your phone — the exact "mobile-native builder" capability you noticed in Vikelas's workflow.
- **Why:** This is the specific capability you called out wanting. It's a modest addition once the pipeline itself works.
- **Checkpoint:** You trigger a real post draft from your phone, not your laptop.

### Week 14 — Harden and document
- **Objective:** Add error handling, logging, and a short README so this tool survives you forgetting how it works in three months.
- **Why:** Undocumented one-off scripts are how founders end up re-dependent on whoever wrote them. Don't recreate the Vikelas problem with your own code.
- **Checkpoint (end of Phase 3):** This tool replaces a piece of manual work you (or Moses) used to do by hand, permanently.

---

## PHASE 4 — Local Models & Infrastructure Literacy (Weeks 15-18)
**Why this phase exists:** This is where you make an informed hardware decision instead of a guessed one — including resolving the Mac mini/GLM-5.2 question correctly (GLM-5.2 is a 744B-parameter model; it does not run on a Mac mini locally at any practical quantization — it runs via API, cheaply, or a much smaller model runs locally instead).

### Week 15 — Local model mechanics
- **Objective:** Understand quantization, context windows, and what "running locally" costs in memory and compute.
- **Why:** Without this, hardware shopping is guesswork dressed up as a plan.
- **Exercise:** Install Ollama, run a small 7-8B model locally on whatever machine you already own.
- **Checkpoint:** Explain why a 744B-parameter model can't run on a 64GB machine, in your own words.

### Week 16 — API vs. local trade-off analysis, for YOUR use cases
- **Objective:** For each real task (content drafting, code generation, data extraction), decide cloud API vs. local model based on cost, latency, and privacy — not vibes.
- **Why:** This is the actual decision Vikelas is making for the backend. You should be able to make it too.
- **Checkpoint:** A short written list: which tasks should stay cloud (likely: anything needing GLM-5.2/Claude-class reasoning), which could go local (lightweight, high-frequency, private tasks).

### Week 17 — The hardware decision
- **Objective:** Choose actual hardware — or confirm cloud-only is correct for now — based on Week 16's answer, not the original assumption.
- **Why:** You now have grounds to make this decision instead of guessing a Mac mini would work.
- **Checkpoint:** A one-paragraph hardware decision with reasoning, that you'd be comfortable defending to Ben Walker or an investor asking why you spent the money.

### Week 18 — Set up your real environment
- **Objective:** Fully configure whatever you decided — cloud API accounts and keys, or a local install — end to end.
- **Checkpoint:** You can run a real task through your chosen setup, start to finish, without help.

---

## PHASE 5 — Build Your Own Harness (Weeks 19-22)
**Why this phase exists:** This is the literal "Hermes layer" idea — done with understanding instead of as a buzzword. You build the routing/orchestration logic yourself, from raw parts, so you know exactly what it does and can fix it when it breaks.

### Week 19 — Study existing harness patterns
- **Objective:** Learn the common patterns: ReAct loops, planner-executor split, subagents delegating to other agents.
- **Why:** Claude Code and Codex are reference implementations of these patterns — recognizing the pattern demystifies the product.
- **Checkpoint:** Identify which pattern Claude Code appears to use, from observing its behavior.

### Week 20 — Build a minimal harness from scratch
- **Objective:** Write your own raw loop in Python: prompt → model call → parse tool call → execute → feed result back — no framework.
- **Why:** Frameworks hide the mechanics you're trying to learn. Build it raw once, then use frameworks later with full understanding of what they're doing for you.
- **Checkpoint:** Your ~100-line harness completes a real two-step task unattended.

### Week 21 — Add routing logic between models/tools
- **Objective:** Add logic that decides which model or tool handles which type of task (e.g., cheap/fast model for simple extraction, GLM-5.2 or Claude for complex reasoning).
- **Why:** This is literally the "Hermes layer" you described — except now it's code you wrote and understand, not a black box you're hoping works.
- **Checkpoint:** Your harness correctly routes two different task types to two different models.

### Week 22 — Add persistence/memory
- **Objective:** Give your harness simple state (a file or lightweight database) so it remembers context across runs.
- **Why:** This mirrors what Vikelas built with Supabase — you're now building the same category of thing, at small scale, understanding every layer.
- **Checkpoint (end of Phase 5):** Your harness can pause, and resume later, without losing context.

---

## PHASE 6 — Full-Stack Independence: Websites & Apps (Weeks 23-27)
**Why this phase exists:** This is where "make websites and apps easily" stops being outsourced. You don't need to become Moses or Vikelas — you need enough literacy to build small tools solo and to read/modify what they build.

### Week 23 — Web fundamentals
- **Objective:** Enough HTML/CSS/JS to read and edit generated frontend code — literacy, not frontend mastery.
- **Checkpoint:** Modify one visual element on a page yourself and understand why the change worked.

### Week 24 — Backend/database fundamentals
- **Objective:** Understand what Supabase/Postgres actually does — tables, auth, edge functions — enough to read Vikelas's setup.
- **Why:** You can't evaluate or eventually reduce reliance on the backend you don't understand.
- **Checkpoint:** Explain, correctly, what one table in your own Supabase schema is for.

### Week 25 — Build one full small app solo
- **Objective:** Build a real small internal tool end-to-end (e.g., a simple partner tracker), with Claude Code as your build partner but you as architect making the decisions.
- **Checkpoint:** It's deployed and you used it for a real task.

### Week 26 — Deployment literacy
- **Objective:** Understand how a site/app actually goes live: hosting, domains, environment variables, basic CI/CD.
- **Checkpoint:** You deploy something yourself without asking anyone how.

### Week 27 — Rebuild something you previously outsourced
- **Objective:** Take a Wix or Lovable page you previously built and had handed off, and rebuild it yourself using your own tools/harness.
- **Checkpoint (end of Phase 6):** A side-by-side comparison — same output, built by you.

---

## PHASE 7 — Ongoing: Full Agent Network & the Wellness App (Week 28+)
**Why this phase exists:** This is the destination state you described — a network of agents you own, coordinated by your own routing layer, applied to a second product.

- Consolidate your Phase 3-5 work into a real personal "agent network": a content agent, a code-review agent, a research agent, coordinated by the harness you built in Phase 5.
- Start the wellness app as a second product, running it through the full pipeline you now own — not a new dependency on someone else's stack.
- Ongoing rhythm: ship something small every 1-2 weeks, review what broke, refine the harness. This replaces "phases" with a permanent build-and-improve loop.

---

## Honest expectations
- This is ~140-280 hours of real work at 5-10 hrs/week — about 6-7 months to genuine independence, not weeks.
- You will still use Vikelas and Moses for scale and speed even after this — the point isn't to replace them, it's that you stop being unable to evaluate, direct, or rebuild what they do.
- Skipping phases to "just build the content generator now" is possible (Claude Code will do it today) — but you'll be back in the exact dependency pattern you're trying to escape, just with an AI instead of a person.
