// Debug script to find elements causing horizontal overflow
// Run this in browser console: copy and paste this entire script

(function findOverflowElements() {
  console.log('🔍 Searching for elements causing horizontal overflow...\n');
  
  const docWidth = document.documentElement.offsetWidth;
  const bodyWidth = document.body.offsetWidth;
  
  console.log(`Document width: ${docWidth}px`);
  console.log(`Body width: ${bodyWidth}px`);
  console.log(`Window inner width: ${window.innerWidth}px\n`);
  
  const allElements = document.querySelectorAll('*');
  const overflowingElements = [];
  
  allElements.forEach(el => {
    const rect = el.getBoundingClientRect();
    
    // Check if element extends beyond viewport
    if (rect.right > window.innerWidth || rect.left < 0) {
      const computedStyle = window.getComputedStyle(el);
      overflowingElements.push({
        element: el,
        tag: el.tagName,
        class: el.className,
        id: el.id,
        width: rect.width,
        right: rect.right,
        left: rect.left,
        position: computedStyle.position,
        overflow: computedStyle.overflow,
        overflowX: computedStyle.overflowX,
      });
    }
  });
  
  if (overflowingElements.length === 0) {
    console.log('✅ No overflowing elements found!');
    return;
  }
  
  console.log(`❌ Found ${overflowingElements.length} overflowing elements:\n`);
  
  overflowingElements
    .sort((a, b) => b.right - a.right)
    .slice(0, 10) // Show top 10 worst offenders
    .forEach((item, index) => {
      console.log(`${index + 1}. ${item.tag}${item.id ? '#' + item.id : ''}${item.class ? '.' + item.class.split(' ')[0] : ''}`);
      console.log(`   Width: ${Math.round(item.width)}px`);
      console.log(`   Right edge: ${Math.round(item.right)}px (viewport: ${window.innerWidth}px)`);
      console.log(`   Overflow: ${Math.round(item.right - window.innerWidth)}px beyond viewport`);
      console.log(`   Position: ${item.position}`);
      console.log(`   Overflow-X: ${item.overflowX}`);
      console.log('   Element:', item.element);
      console.log('');
    });
  
  // Highlight the worst offender
  if (overflowingElements.length > 0) {
    const worst = overflowingElements[0];
    worst.element.style.outline = '3px solid red';
    worst.element.scrollIntoView({ behavior: 'smooth', block: 'center' });
    console.log('🎯 Worst offender highlighted in RED');
  }
})();
