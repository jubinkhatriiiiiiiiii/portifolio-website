# Mobile Tab Animation Fix

## Issue
The tab/keycap animation in the tech stack section wasn't appearing on mobile devices like it does on desktop.

## Root Cause
In `components/animated-background.tsx`, the mobile keycaps were being set to visible immediately without any animation:

```typescript
// OLD CODE (no animation)
if (isMobile) {
  const mobileKeyCaps = allObjects.filter((obj) => obj.name === "keycap-mobile");
  mobileKeyCaps.forEach((keycap) => { keycap.visible = true; });
}
```

## Fix Applied
Changed the mobile keycap visibility to use the same staggered animation as desktop:

```typescript
// NEW CODE (with staggered animation)
if (isMobile) {
  const mobileKeyCaps = allObjects.filter((obj) => obj.name === "keycap-mobile");
  mobileKeyCaps.forEach(async (keycap, idx) => {
    await sleep(idx * 70);
    keycap.visible = true;
  });
}
```

## Result
Now mobile devices will see the same smooth, staggered appearance animation for the keyboard tabs as desktop users do.

## Files Modified
- `components/animated-background.tsx`

## Test It
1. Run `npm run dev`
2. Open in browser with mobile device emulation (Chrome DevTools → Device Toolbar)
3. Scroll to the "Tech Stack" section
4. You should now see the tabs appear one by one with animation

## Deploy
```bash
git add components/animated-background.tsx
git commit -m "Fix mobile tab animation in tech stack section"
git push origin main
```
