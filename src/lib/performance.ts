/**
 * Performance detection utilities
 */

export interface PerformanceLevel {
  isLowEnd: boolean;
  isMobile: boolean;
  shouldReduceAnimations: boolean;
  maxParticles: number;
  targetFPS: number;
}

/**
 * Detect device performance level
 */
export function detectPerformance(): PerformanceLevel {
  if (typeof window === "undefined") {
    return {
      isLowEnd: false,
      isMobile: false,
      shouldReduceAnimations: false,
      maxParticles: 30,
      targetFPS: 60,
    };
  }

  // Check if mobile
  const isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(
    navigator.userAgent
  ) || window.innerWidth < 768;

  // Check hardware concurrency (CPU cores)
  const cores = navigator.hardwareConcurrency || 4;
  
  // Check device memory (if available)
  const memory = (navigator as any).deviceMemory || 4;
  
  // Check if user prefers reduced motion
  const prefersReducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

  // Determine if low-end device
  const isLowEnd = cores <= 2 || memory <= 2 || prefersReducedMotion;

  return {
    isLowEnd,
    isMobile,
    shouldReduceAnimations: isLowEnd || isMobile || prefersReducedMotion,
    maxParticles: isMobile ? 15 : isLowEnd ? 20 : 30,
    targetFPS: isLowEnd ? 30 : 60,
  };
}

/**
 * FPS throttle helper
 */
export function createFPSThrottle(targetFPS: number) {
  const interval = 1000 / targetFPS;
  let lastTime = 0;

  return (callback: () => void) => {
    const now = performance.now();
    const delta = now - lastTime;

    if (delta >= interval) {
      lastTime = now - (delta % interval);
      callback();
    }
  };
}

/**
 * Check if tab is visible
 */
export function isTabVisible(): boolean {
  return document.visibilityState === "visible";
}
