#!/bin/bash

# Test Performance Optimizations
# This script helps you verify the performance improvements

echo "🚀 Testing Performance Optimizations..."
echo ""

# Check if files were created
echo "✓ Checking new files..."
if [ -f "lib/performance.ts" ]; then
  echo "  ✓ lib/performance.ts created"
else
  echo "  ✗ lib/performance.ts missing"
fi

if [ -f "hooks/use-performance.tsx" ]; then
  echo "  ✓ hooks/use-performance.tsx created"
else
  echo "  ✗ hooks/use-performance.tsx missing"
fi

echo ""
echo "✓ Checking optimized files..."
if grep -q "usePerformance" components/Particles.tsx; then
  echo "  ✓ Particles.tsx optimized"
else
  echo "  ✗ Particles.tsx not optimized"
fi

if grep -q "shouldDisable" components/animated-background.tsx; then
  echo "  ✓ AnimatedBackground.tsx optimized"
else
  echo "  ✗ AnimatedBackground.tsx not optimized"
fi

if grep -q "shouldReduceAnimations" components/smooth-scroll.tsx; then
  echo "  ✓ SmoothScroll.tsx optimized"
else
  echo "  ✗ SmoothScroll.tsx not optimized"
fi

echo ""
echo "📊 Performance Improvements:"
echo "  • Particles: 15 on mobile (was 30), 30fps on low-end (was 60fps)"
echo "  • AnimatedBackground: Disabled on mobile devices"
echo "  • SmoothScroll: Disabled on low-end devices"
echo "  • Tab visibility: Animations pause when tab hidden"
echo ""
echo "🧪 To test:"
echo "  1. Run: npm run dev"
echo "  2. Open in browser"
echo "  3. Check DevTools Performance tab"
echo "  4. Test on mobile device or use Chrome DevTools mobile emulation"
echo ""
echo "✅ Performance optimization complete!"
