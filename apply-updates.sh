#!/bin/bash
# ═══════════════════════════════════════════════════════════════════
# Ghost Card Website Update Script
# Run from the root of your ghost-card repo
# ═══════════════════════════════════════════════════════════════════
set -e

echo "Ghost Card Website Update — applying all changes..."
echo ""

# ── 1. SIDEBAR UPDATE: Add doc #10 to all 9 existing doc pages ──
echo "1/6  Adding doc #10 to sidebar nav on all doc pages..."
for f in docs/getting-started.html docs/building-a-card.html docs/scoring.html docs/history.html docs/bag-tags.html docs/tour-mode.html docs/par-corrections.html docs/account.html docs/horror-mode.html; do
  if [ -f "$f" ]; then
    # Insert line after "09 Horror Mode" in sidebar
    sed -i.bak 's|<li><a href="horror-mode.html">09 Horror Mode</a></li>|<li><a href="horror-mode.html">09 Horror Mode</a></li>\n      <li><a href="friends-and-feed.html">10 Friends \&amp; Feed</a></li>|' "$f"
    # Also handle the case where horror-mode has class="current"
    sed -i.bak 's|<li><a href="horror-mode.html" class="current">09 Horror Mode</a></li>|<li><a href="horror-mode.html" class="current">09 Horror Mode</a></li>\n      <li><a href="friends-and-feed.html">10 Friends \&amp; Feed</a></li>|' "$f"
    rm -f "$f.bak"
    echo "   ✓ $f"
  else
    echo "   ✗ $f not found — skipping"
  fi
done

# ── 2. DOCS/INDEX.HTML: Update hero count + add pill + add card ──
echo ""
echo "2/6  Updating docs/index.html..."
if [ -f "docs/index.html" ]; then
  # Change "Nine documents" to "Ten documents"
  sed -i.bak 's|Nine documents|Ten documents|' docs/index.html
  
  # Add Friends pill after Horror Mode pill
  sed -i.bak 's|<a href="horror-mode.html" class="doc-pill doc-pill-horror">Horror Mode</a>|<a href="horror-mode.html" class="doc-pill doc-pill-horror">Horror Mode</a>\n      <a href="friends-and-feed.html" class="doc-pill" style="border-color:rgba(123,200,200,0.3);color:#7BC8C8">Friends</a>|' docs/index.html
  
  # Add doc card #10 section before the CTA band
  sed -i.bak '/<div class="cta-band">/i\
  <!-- YOUR GHOST FIELD -->\
  <p class="docs-group-label" style="margin-top:56px">Your ghost field<\/p>\
\
  <a href="friends-and-feed.html" class="doc-card-featured" style="border-left-color:#7BC8C8;background:#0A1820" aria-label="Friends and Feed guide">\
    <div>\
      <p class="doc-card-featured-label" style="color:#7BC8C8">10 — Friends \&amp; Feed<\/p>\
      <h2 class="doc-card-featured-title">Your ghost field. Now populated.<\/h2>\
      <p class="doc-card-featured-sub">Add friends, see their rounds in the Feed, race their ghost on your leaderboard. Personal best tracking, head-to-head comparisons, rating sparklines, and round sharing.<\/p>\
    <\/div>\
    <div class="doc-card-featured-right">\
      <span class="doc-card-tag" style="background:rgba(123,200,200,0.12);border-color:rgba(123,200,200,0.3);color:#7BC8C8">New<\/span>\
      <span class="doc-card-arrow">→<\/span>\
    <\/div>\
  <\/a>\
' docs/index.html
  
  rm -f docs/index.html.bak
  echo "   ✓ docs/index.html"
else
  echo "   ✗ docs/index.html not found"
fi

# ── 3. FEATURES.HTML: Insert 4 new feature cards ──
echo ""
echo "3/6  Adding 4 new feature cards to features.html..."
if [ -f "features.html" ]; then
  # Insert before </div> that closes features-full, which is right before <div class="cta-band">
  sed -i.bak '/<div class="cta-band">/i\
\
    <!-- ── NEW: Friends \& Feed ── -->\
    <div class="feat-card" style="border-top:3px solid #7BC8C8;background:#0A1820">\
      <div class="feat-icon"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http:\/\/www.w3.org\/2000\/svg"><path d="M5 20 Q5 13 6 10 Q7.5 7 9 6 Q10.5 7 12 10 Q13 13 13 20 Q11.5 18.5 10.5 20 Q9.5 18.5 8 20 Q6.5 18.5 5 20Z" fill="#7BC8C8" opacity="0.5"\/><ellipse cx="9" cy="8.5" rx="3" ry="3.8" fill="#7BC8C8" opacity="0.5"\/><path d="M11 21 Q11 14 12 11 Q13.5 7.5 15 6.5 Q16.5 7.5 18 11 Q19 14 19 21 Q17.5 19 16.5 21 Q15.5 19 14 21 Q12.5 19 11 21Z" fill="#7BC8C8"\/><ellipse cx="15" cy="9" rx="3" ry="3.8" fill="#7BC8C8"\/><ellipse cx="13.8" cy="8.5" rx="1" ry="1.2" fill="none" stroke="#0A1820" stroke-width="0.9"\/><ellipse cx="16.2" cy="8.5" rx="1" ry="1.2" fill="none" stroke="#0A1820" stroke-width="0.9"\/><\/svg><\/div>\
      <div style="display:inline-block;margin-bottom:8px;padding:2px 10px;border-radius:4px;background:rgba(123,200,200,0.1);border:1px solid rgba(123,200,200,0.3);color:#7BC8C8;font-size:10px;font-weight:600;letter-spacing:2px;text-transform:uppercase">New<\/div>\
      <h3 class="feat-title">Friends \&amp; Activity Feed<\/h3>\
      <p class="feat-body">Add friends by username, see their recent rounds in a dedicated Feed tab. The feed shows course, score, GC Rating, and full scorecard breakdowns on tap. Head-to-Head view auto-surfaces courses you have both played and compares your best scores side by side.<\/p>\
      <p class="feat-body" style="margin-top:10px">Mutual friendships only. 20-friend cap. No follower counts, no likes, no algorithms. Just rounds and who played them. The ghosts do not do engagement metrics.<\/p>\
      <div class="feat-footer">\
        <span class="feat-tag" style="background:rgba(123,200,200,0.1);border-color:rgba(123,200,200,0.3);color:#7BC8C8">Social<\/span>\
        <a href="docs\/friends-and-feed.html" class="feat-doc-link">Friends docs<\/a>\
      <\/div>\
    <\/div>\
\
    <!-- ── NEW: Personal Best Ghost ── -->\
    <div class="feat-card" style="border-top:3px solid var(--lantern)">\
      <div class="feat-icon"><svg width="32" height="32" viewBox="0 0 20 22.4" xmlns="http:\/\/www.w3.org\/2000\/svg"><path d="M10 1.5 C5.3 1.5, 2 5.2, 2 9.8 L2 19 Q4.2 21.2, 6.3 19 Q8.4 16.8, 10 19 Q11.6 21.2, 13.7 19 Q15.8 16.8, 18 19 L18 9.8 C18 5.2, 14.7 1.5, 10 1.5 Z" fill="#C9A84C"\/><ellipse cx="7.4" cy="10.5" rx="1.7" ry="2.1" fill="rgba(0,0,0,0.45)"\/><ellipse cx="12.6" cy="10.5" rx="1.7" ry="2.1" fill="rgba(0,0,0,0.45)"\/><\/svg><\/div>\
      <h3 class="feat-title">Beat Your Ghost — Personal Best<\/h3>\
      <p class="feat-body">Your previous best round at the current course appears as a gold ghost row on the live leaderboard — labeled YOUR BEST and tracking hole by hole with real score data. Not simulated. Not estimated. That was you, on that day, and now you have to beat yourself.<\/p>\
      <p class="feat-body" style="margin-top:10px">Set a new personal best and the Round Complete screen celebrates with a full comparison: holes won, holes lost, holes tied, strokes gained. The ghost noticed.<\/p>\
      <div class="feat-footer">\
        <span class="feat-tag">Leaderboard<\/span>\
        <a href="docs\/friends-and-feed.html#pb-ghost" class="feat-doc-link">PB ghost docs<\/a>\
      <\/div>\
    <\/div>\
\
    <!-- ── NEW: Friend Ghost on Leaderboard ── -->\
    <div class="feat-card" style="border-top:3px solid #7BC8C8;background:#0A1820">\
      <div class="feat-icon"><svg width="32" height="32" viewBox="0 0 20 22.4" xmlns="http:\/\/www.w3.org\/2000\/svg"><path d="M10 1.5 C5.3 1.5, 2 5.2, 2 9.8 L2 19 Q4.2 21.2, 6.3 19 Q8.4 16.8, 10 19 Q11.6 21.2, 13.7 19 Q15.8 16.8, 18 19 L18 9.8 C18 5.2, 14.7 1.5, 10 1.5 Z" fill="#7BC8C8"\/><ellipse cx="7.4" cy="10.5" rx="1.7" ry="2.1" fill="rgba(0,0,0,0.45)"\/><ellipse cx="12.6" cy="10.5" rx="1.7" ry="2.1" fill="rgba(0,0,0,0.45)"\/><\/svg><\/div>\
      <h3 class="feat-title">Friend Ghost on Your Leaderboard<\/h3>\
      <p class="feat-body">When you play a course a friend has played before, their best round appears as a cyan ghost row on your live leaderboard — right next to the pro ghosts and your PB ghost. Real hole-by-hole score data. If they birdied hole 7, you will see it on hole 7.<\/p>\
      <p class="feat-body" style="margin-top:10px">Three ghost layers on one leaderboard: pro ghosts (cream), your personal best (gold), your friend (cyan). The solo round was never really solo.<\/p>\
      <div class="feat-footer">\
        <span class="feat-tag" style="background:rgba(123,200,200,0.1);border-color:rgba(123,200,200,0.3);color:#7BC8C8">Friend Ghost<\/span>\
        <a href="docs\/friends-and-feed.html#friend-ghost" class="feat-doc-link">Friend ghost docs<\/a>\
      <\/div>\
    <\/div>\
\
    <!-- ── NEW: Rating Trend \& Share Badge ── -->\
    <div class="feat-card">\
      <div class="feat-icon"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http:\/\/www.w3.org\/2000\/svg"><polyline points="3,17 7,10 12,13 17,6 21,8" stroke="#8FA4C4" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"\/><circle cx="3" cy="17" r="1.5" fill="#8FA4C4"\/><circle cx="7" cy="10" r="1.5" fill="#8FA4C4"\/><circle cx="12" cy="13" r="1.5" fill="#8FA4C4"\/><circle cx="17" cy="6" r="1.5" fill="#8FA4C4"\/><circle cx="21" cy="8" r="1.5" fill="#8FA4C4"\/><\/svg><\/div>\
      <h3 class="feat-title">Rating Trend \&amp; Share Badge<\/h3>\
      <p class="feat-body">A sparkline chart on the History screen tracks your GC Rating across your last 20 rated rounds. Green line means you are getting better. Orange means the ghosts are winning. Your best-ever rating is marked. Tap any point to see the number.<\/p>\
      <p class="feat-body" style="margin-top:10px">Every completed round generates a shareable badge image — course, date, score, GC Rating, the whole resume. Export it. Post it. Prove you were there. The ghosts do not need to prove anything.<\/p>\
      <div class="feat-footer">\
        <span class="feat-tag">Analytics<\/span>\
        <a href="docs\/friends-and-feed.html#rating-trend" class="feat-doc-link">Rating trend docs<\/a>\
      <\/div>\
    <\/div>\
' features.html
  
  rm -f features.html.bak
  echo "   ✓ features.html"
else
  echo "   ✗ features.html not found"
fi

# ── 4. INDEX.HTML: Add 2 cards to Built for the Round grid ──
echo ""
echo "4/6  Adding 2 new cards to index.html Built for the Round grid..."
if [ -f "index.html" ]; then
  # Insert before the closing </div> of built-grid, which is followed by </div></section>
  # The Round Archive card has class="built-card bc-shadow" — insert after it
  # We'll target the "Round Archive" text as our anchor
  sed -i.bak '/Round Archive/,/<\/div>/{
    /class="built-link".*Round Archive\|class="built-link".*history/a\
      </div>\
\
      <!-- Friends \& Feed — NEW -->\
      <div class="built-card" style="border-left:2px solid #7BC8C8">\
        <div class="built-icon">\
          <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">\
            <path d="M5 20 Q5 13 6 10 Q7.5 7 9 6 Q10.5 7 12 10 Q13 13 13 20 Q11.5 18.5 10.5 20 Q9.5 18.5 8 20 Q6.5 18.5 5 20Z" fill="#7BC8C8" opacity="0.5"/>\
            <path d="M11 21 Q11 14 12 11 Q13.5 7.5 15 6.5 Q16.5 7.5 18 11 Q19 14 19 21 Q17.5 19 16.5 21 Q15.5 19 14 21 Q12.5 19 11 21Z" fill="#7BC8C8"/>\
            <ellipse cx="15" cy="9" rx="3" ry="3.8" fill="#7BC8C8"/>\
          </svg>\
        </div>\
        <h3 class="built-title">Friends \&amp; Feed</h3>\
        <p class="built-body">Add friends. See their rounds. Race their ghost on your leaderboard. Head-to-head comparisons build themselves.</p>\
        <div class="built-tags"><span class="built-tag" style="background:rgba(123,200,200,0.12);border-color:rgba(123,200,200,0.3);color:#7BC8C8">Social</span></div>\
        <a href="docs/friends-and-feed.html" class="built-link" style="color:#7BC8C8">Friends docs →</a>\
      </div>\
\
      <!-- Beat Your Ghost — NEW -->\
      <div class="built-card bc-gold">\
        <div class="built-icon">\
          <svg viewBox="0 0 20 22.4" width="28" height="32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">\
            <path d="M10 1.5 C5.3 1.5, 2 5.2, 2 9.8 L2 19 Q4.2 21.2, 6.3 19 Q8.4 16.8, 10 19 Q11.6 21.2, 13.7 19 Q15.8 16.8, 18 19 L18 9.8 C18 5.2, 14.7 1.5, 10 1.5 Z" fill="#C9A84C" opacity="0.9"/>\
            <ellipse cx="7.4" cy="10.5" rx="1.4" ry="1.7" fill="rgba(0,0,0,0.5)"/>\
            <ellipse cx="12.6" cy="10.5" rx="1.4" ry="1.7" fill="rgba(0,0,0,0.5)"/>\
          </svg>\
        </div>\
        <h3 class="built-title">Beat Your Ghost</h3>\
        <p class="built-body">Your personal best at each course appears on the leaderboard. Gold row, real scores, hole by hole. The only ghost that is actually you.</p>\
        <a href="docs/friends-and-feed.html#pb-ghost" class="built-link">PB ghost docs →</a>\
  }' index.html
  rm -f index.html.bak
  echo "   ✓ index.html (attempted — verify manually)"
else
  echo "   ✗ index.html not found"
fi

# ── 5. Copy new files ──
echo ""
echo "5/6  Copying new files..."
# friends-and-feed.html should already be in docs/ from the zip
if [ -f "docs/friends-and-feed.html" ]; then
  echo "   ✓ docs/friends-and-feed.html already exists"
else
  echo "   ✗ docs/friends-and-feed.html — copy from zip manually"
fi

if [ -f "llms.txt" ]; then
  echo "   ✓ llms.txt already exists"
else
  echo "   ✗ llms.txt — copy from zip manually"
fi

echo ""
echo "6/6  Done. Review changes and commit."
echo ""
echo "FILES MODIFIED:"
echo "  - features.html (4 new feature cards)"  
echo "  - index.html (2 new Built grid cards)"
echo "  - docs/index.html (count, pill, card #10)"
echo "  - docs/getting-started.html (sidebar)"
echo "  - docs/building-a-card.html (sidebar)"
echo "  - docs/scoring.html (sidebar)"
echo "  - docs/history.html (sidebar)"
echo "  - docs/bag-tags.html (sidebar)"
echo "  - docs/tour-mode.html (sidebar)"
echo "  - docs/par-corrections.html (sidebar)"
echo "  - docs/account.html (sidebar)"
echo "  - docs/horror-mode.html (sidebar)"
echo ""
echo "NEW FILES (from zip):"
echo "  - docs/friends-and-feed.html"
echo "  - llms.txt"
