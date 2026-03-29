"use client";

import { useState, useEffect } from "react";
import { detectPerformance, PerformanceLevel } from "@/lib/performance";

/**
 * Hook to detect device performance level
 */
export function usePerformance(): PerformanceLevel {
  const [performance, setPerformance] = useState<PerformanceLevel>({
    isLowEnd: false,
    isMobile: false,
    shouldReduceAnimations: false,
    maxParticles: 30,
    targetFPS: 60,
  });

  useEffect(() => {
    setPerformance(detectPerformance());
  }, []);

  return performance;
}
