# Ghost Card Site Update — Complete Changelog

## Files Included

```
ghostcard-homepage-update/
├── index.html          ← Revised homepage (full rebuild)
├── features.html       ← Fixed features page (triple-duplication bug removed)
├── how-it-works.html   ← Updated how-it-works page (new features mentioned)
├── docs/
│   └── index.html      ← Fixed docs hub (guide count corrected, doc #10 added)
└── CHANGELOG.md        ← This file
```

---

## index.html — Homepage (Full Rebuild)

### New Sections Added
1. **What's New Banner** — Thin strip announcing shipped features with anchor link
2. **How It Works (4-step)** — Compressed version of the standalone page
3. **Beat Your Ghost** — Hero-weight section with PB celebration mock (holes won/lost/tied)
4. **Friends & Social Layer** — Three ghost layer cards + four sub-feature cards (Feed, H2H, Quick-Add, Rating Trend)
5. **Email Capture** — "The ghosts send updates. Occasionally."

### Updated Sections
- **Hero**: Tightened subhead; leaderboard mock now shows all 3 ghost layers (pro/PB/friend); CTA changed from "See the Docs" to "See How It Works"
- **Multiplayer**: Expanded from 3 to 6 cards (added Custom Tournament, Quick-Add Friends, Share Badge)
- **Horror Mode**: Cinematic treatment with 3 actual card examples (The Possession, Ghost Walk, The Mirror) + skins note
- **Built for the Round**: Updated to mention Rating Trend and Share Badge; added docs trust callout
- **Tour Mode**: Moved from position 2 to position 7 (better conversion order)
- **Every section now has a CTA button**

### Nav Updated
- Added "How It Works" and "Features" links (previously only Docs)
- Mobile hamburger menu

---

## features.html — Features Page (Bug Fix + Update)

### Critical Bug Fixed
- **Triple-duplication bug removed**: Friends & Feed, Beat Your Ghost, Friend Ghost, and Rating Trend blocks were duplicated 3× at the bottom of the page. Now each appears exactly once.

### Content Updates
- All 14 features now appear in a clean 2-column grid
- Features organized: Core (6) → Formats (2) → Tour Mode (wide) → Horror Mode (wide) → New features (4)
- New features tagged with cyan "New" badges
- Live Leaderboard description updated to mention three ghost layers
- Consistent nav/footer with other pages

---

## how-it-works.html — How It Works Page (Content Update)

### Content Updates
- **Step 02 (Build Your Card)**: Added mention of Horror Mode as an option during card build
- **Step 03 (Score Your Round)**: Added description of three ghost layers (pro/PB/friend) on the leaderboard
- **Step 04 (Haunt Your History)**: Added mentions of GC Rating, Rating Trend, Activity Feed, and Share Badge
- Tags updated on each step to reflect new features

### Nav/Footer
- Consistent with other pages

---

## docs/index.html — Docs Hub (Bug Fix)

### Bugs Fixed
- **Guide count**: Changed "Eight guides" to "Ten guides" (there are actually 10)
- **Missing doc #10**: Added Friends & Feed card with "New" badge to the doc grid

### Content Updates
- Added 5 new jump-to-topic links: Friend ghost, Personal best ghost, Head-to-head, Rating trend, Share badge
- Consistent nav/footer with other pages

---

## Brand Compliance (All Files)
- Font: Montserrat (display) + Inter (body) — matches locked brand system
- Colors: All brand tokens preserved (--void, --gold, --cyan, --cream, etc.)
- Logo: GHOST (cream Montserrat 200) + CARD (gold) lockup preserved exactly
- Horror theme maintained throughout
- No emoji in UI chrome

## Deployment Notes
- These are drop-in HTML replacements for the corresponding files on ghostcard.live
- **Treeline photo**: Now uses an inline SVG data URI with two layers of pine tree silhouettes + atmospheric glow — no external assets needed, renders immediately
- **Email capture form**: Wired to FormSubmit.co → ghostcardapp@proton.me. No backend needed. First submission will trigger a FormSubmit confirmation email to verify ownership — click to activate. After that, all subscriptions arrive in your Proton inbox.
- Individual doc pages (01–09) are unchanged — only the docs hub index was updated
- The Friends & Feed doc page (docs/friends-and-feed.html) was already live and is unchanged
