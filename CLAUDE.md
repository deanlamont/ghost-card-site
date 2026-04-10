# CLAUDE.md — Ghost Card

## What This Project Is

Ghost Card is a horror-themed disc golf scoring app where players compete against ghost pro scores on a live leaderboard. React + Vite frontend. Two repos, both deployed on Vercel:

- **ghost-card** (app) — React app at app.ghostcard.live. Current version: v0.7.
- **ghost-card-site** (marketing) — Static HTML site at ghostcard.live, includes `/docs/` documentation hub.

GitHub: github.com/deanlamont/ghost-card, github.com/deanlamont/ghost-card-site

## How We Work

- **Boo Boo (deanlamont) does not write code.** Claude does all code work. Boo Boo gives direction, confirms decisions, and reviews output.
- Get directional confirmation before implementing large changes.
- Deliver complete, working code — no stubs, no placeholders unless explicitly agreed to.
- When flagging a decision point, be concise. Don't over-explain options.

## Architecture

### App (`ghost-card`)

- Single large `GhostCard.jsx` file (~10,400+ lines). Do not split this into separate files unless Boo Boo explicitly asks.
- Supabase is live for auth and round history but not yet fully connected to all features.
- All Supabase-dependent features use clearly labeled **comment swap points** — `// SUPABASE-SWAP:` comments marking where localStorage logic gets replaced with Supabase calls in a single-pass migration. Maintain this pattern for any new features.
- Course data seeded from Kaggle (~7,000 US courses via Supabase).
- 134 PDGA-rated ghost pro opponents with real stats (MPO/FPO/Mixed divisions).
- Simulation engine uses seeded RNG (`mulberry32`) + Gaussian noise for deterministic ghost scores.

### Marketing Site (`ghost-card-site`)

- Static HTML pages: `index.html`, `features.html`, `how-it-works.html`, `404.html`
- `/docs/` folder: 10 documentation pages + `_shared.css`
- Docs hub at `docs/index.html` links to: Getting Started, Building a Card, Scoring, History, Bag Tags, Tour Mode, Par Corrections, Account, Horror Mode, Friends & Feed
- Footer links: Home · How It Works · Features · Docs (no GitHub or App links)
- SVG treeline header (inline CSS, no external assets)
- Email capture wired to ghostcardapp@proton.me via FormSubmit.co

## Branding — LOCKED, DO NOT CHANGE

These rules are permanent. Never redesign, replace, or "improve" any of these elements.

### Logo Lockup
- `FlatGhost` / `SimpleGhost` SVG + "Ghost" (cream `#EDE9DC`, Inter weight 200) + "Card" (gold `#cf9120`, Inter weight 200)
- Never replace the ghost SVG component or alter the wordmark typography.
- Both wordmark halves are solid fills, not outlined/stroked. The "ghostly" look comes from Inter weight 200 at wide letter-spacing (hero: 10px, nav: 4px), not from a stroke.

### Typography
- **UI text:** Inter — all body copy, buttons, labels, headers within the app.
- **Logo wordmark:** Inter weight 200 at wide letter-spacing. No separate display font — the thin weight + tracking does the work.
- No other fonts anywhere in the marketing site or app.

### Colors
- Brand constants: `CYAN`, `LIME`, `GOLD`, `ORANGE`
- CSS custom properties: `--void` (#0D1426), `--lantern` (#C9A84C), `--harvest` (#CF9120), `--cream` (#EDE9DC), `--moonlight`, `--fog`, `--shadow`, `--dusk`, `--deep-navy`, `--midnight`, `--abyss`
- Gold accent: `#cf9120`
- Background: `#060C1A` → `#0D1426` gradient palette

### Icons
- **No emoji icons anywhere in persistent UI.** Use the FlatGhost SVG for branding moments. Use simple CSS/SVG icons for functional UI elements.
- Emoji allowed in gameplay-context elements (Horror Mode cards, celebration moments) but not in persistent navigation, labels, or headers.

### Header
- The header uses a `.treeline-photo` CSS approach with a real base64 photo asset and a fade-to-dark gradient. Do not replace with a generic gradient or illustration.

### Tone
- Horror-themed throughout. Deadpan horror comedy with small-town disc golf energy.
- "Chet" is the canonical everyman voice archetype for app copy.
- Solo play is free. App messaging must **never** make solo players feel bad for playing alone.

### Taglines
Two canonical taglines, each with a distinct role. **Never delete, swap, or "unify" them.**
- **Product positioning (hero only):** `Real Disc Golf. Video Game Soul.` — used exactly once, in the homepage hero (`index.html` hero-tagline). This is the "what it is" line for disc golf players landing on the site.
- **Brand hook (social + footer):** `Haunt the Leaderboard` — used in OG meta tags, Twitter card, the rendered `og-image.png`, and the site footer. This is the memorable line used anywhere the site appears outside its own hero (link unfurls, social previews, footer echo).
- If a new surface needs a tagline, pick the one that matches its function: positioning on-site, brand hook off-site.

## Features Built (Current State)

### Core Gameplay
- **Solo vs Pro Field** — 1 player vs 134 ghost pros on a live leaderboard
- **Stroke Play** — 2–4 players, each scores every hole, each gets own leaderboard row
- **Scramble (Best Disc)** — 2–4 players, one group score per hole, team name on scorecard
- **Custom Tournament** — named multi-round events (1–5 rounds), Stroke Play or Scramble, different course per round, cumulative leaderboard, horror-themed ghost team names
- **Live Leaderboard** — reshuffles after every hole, three ghost layers:
  - Pro ghosts (cream) — PDGA-rated opponents
  - PB ghost (gold) — your personal best at this course, labeled "YOUR BEST"
  - Friend ghost (cyan) — friend's best round at this course

### Tour Mode & Career
- **10-event season** — Regular, Elite+ (1.25x), Major, Season Finale (2x)
- **DGPT-calibrated points table** — 30 positions deep, four tiers (100/125/150/200 pts for 1st)
- **Multi-round events** — 3 rounds standard, 5 rounds for Majors and Finale
- **Event states:** Pending → In Progress → Completed with round-by-round breakdowns
- **Career narrative** — progression across seasons

### Horror Mode (Card Game Overlay)
- **50-card deck** layered on top of any 2+ player round
- **Four card types:**
  - Haunt (20 cards, purple #9B59B6) — played on opponents (e.g., "The Possession," "Banshee Scream")
  - Spirit (15 cards, cyan) — played on yourself (buffs, mulligans)
  - Reckoning (10 cards, gold) — held until end of round (e.g., "The Grimoire," "Lich's Crown")
  - Wild (5 cards, red #E05050) — flexible (e.g., "The Mirror," "The Void")
- **Skins game** runs alongside, with carryover on ties
- Toggle on Setup screen, off by default, 2+ players required

### Friends & Social System
- **Friends list** — mutual friendships, 20-friend cap, add by scorecard name
- **Friend requests** — incoming/outgoing management, accept/decline
- **Activity Feed** — recent rounds from friends (course, score, GC Rating, tap to expand)
- **Head-to-Head** — auto-surfaces shared courses, compares best scores
- **Quick-Add to Card** — accepted friends appear as one-tap chips in round setup
- **Friend Ghost on Leaderboard** — friend's best round appears as cyan ghost row

### Beat Your Ghost (Personal Best)
- **`usePersonalBest` hook** — queries for best prior round at same course+layout
- **PB ghost row** — gold "YOUR BEST" on live leaderboard with real hole-by-hole scores
- **Per-hole comparison** — green when beating, orange when behind
- **Running differential banner** during play
- **FinishedScreen celebration** — "NEW PERSONAL BEST" with holes won/lost/tied breakdown

### GC Rating & Analytics
- **Round rating** calculated as: `1000 + (SSA - total_strokes) * 10 / hole_count * 18`
- **GC Rating hero callout** on FinishedScreen — "THIS ROUND RATED 917", color-coded (gold >=1000 / lime >=980 / cyan below), shows dash when no SSA
- **RatingSparkline** — SVG chart on History screen, last 20 rated rounds, hover interaction, dashed cyan average line, gold dot for best, x-axis date labels

### Round Share Badge
- **Canvas-rendered badge** (1080x1920 Instagram story format)
- Course, date, score, GC Rating, ghost opponents beaten, notable holes (aces/eagles), birdie/par/bogey pills, Horror Mode indicator
- **Web Share API** on mobile → native share sheet; download fallback on desktop
- Treeline silhouette, scanline overlay, horror aesthetic

### Bag Tags
- **30 collectible horror-movie badges** with rarity tiers (Common/Uncommon/Rare/Legendary)
- Custom SVGs for each tag
- Unlock conditions tied to gameplay achievements
- **Bone Collector** tag — earned by submitting 5 community par corrections

### Course System
- **7,008 US courses** from Kaggle/PDGA dataset
- **CoursePicker** with verified/unverified course badges
- **Community par correction flow** — submit corrections, earn Bone Collector tag
- **"Field Difficulty"** label (not "Course Difficulty")
- **SSA (Stroke Scoring Average)** per course for simulation calibration

### Other Features
- **Push/Pull player invite system** — invite Ghost Card users by username
- **DoublesScorecard** component
- **ActiveRoundBanner** — persistent indicator during active round
- **History screen** — full round archive with shared round badges, course records, filtering
- **Horror-themed support ticket screen**
- **Profile tab** — friends section, rating display, support
- **Documentation links inside app** — contextual links on Welcome screen, Setup screen, Bag Tags, History, and Profile

## Known Bugs

1. **History screen scroll** — was fixed (removed `display:flex/flexDirection:column` from scroll container), may need re-verification.
2. **"Create a new season" button** is a placeholder — no functionality yet.

## Priorities (Next Up)

1. **Claude Code Desktop workflow** — local file editing + git push (replacing zip-download workflow)
2. **Supabase full connection** — wire up all swap points after core functionality locked
3. **PWA / Offline support** — service worker + IndexedDB for mid-round signal loss
4. **Ghost Win/Loss Record** — head-to-head record vs each ghost pro ("You're 3-14 against Ghost Ricky")
5. Branding polish last

## Supabase Rules

- Cap round history at **50 rounds/user** (free tier constraint).
- **Manual save/delete button only** — never auto-save rounds.
- Email confirmation is disabled in Supabase Auth for easier testing.
- OAuth providers (Google, Apple, Facebook) deferred until core functionality is stable.
- **Friendships table** needed: `id` (uuid PK), `user_a` (uuid FK, canonical lower), `user_b` (uuid FK, canonical higher), `status` (pending/accepted/blocked), `initiated_by` (uuid), `created_at`, `accepted_at`. Unique constraint on `(user_a, user_b)`.
- **Database schema** (13+ tables): `profiles`, `courses`, `course_layouts`, `layout_holes`, `rounds`, `course_records`, `seasons`, `season_events`, `trophies`, `user_trophies`, `weekly_challenges`, `weekly_challenge_entries`, `follows`, plus pending `friendships`.

## Things to Watch For

- Any edit to the treeline header: the `.treeline-photo` CSS has broken before from orphaned keyframes. Test visually after changes.
- The 404.html must maintain design parity with index.html.
- If you touch CSS animations, verify nothing orphaned gets left behind.
- Base64 image assets in the HTML are large. Edit around them — don't reload them into context unnecessarily.
- Canvas `ctx.roundRect()` in Share Badge — well-supported modern browsers, not pre-2023.
- Inter font must be loaded before canvas draws for Share Badge.
- Marketing site `features.html` had a triple-duplication bug (4 blocks repeated 3x) — was fixed. Watch for this pattern if adding new feature cards.
- Docs hub says "Ten guides" — update count if adding new doc pages.
- Homepage has 13 sections in benefit-ladder order — don't reorder without understanding the conversion strategy.
