import { ReactNode } from "react";
import { QueryClientProvider } from "@tanstack/react-query";
import { SafeAreaProvider } from "react-native-safe-area-context";
import { PortalHost } from "@rn-primitives/portal";
import { testQueryClient } from "../../jest.setup";

export const wrapper = ({ children }: { children: ReactNode }) => (
  <SafeAreaProvider
    initialMetrics={{
      frame: { x: 0, y: 0, width: 320, height: 640 },
      insets: { top: 0, left: 0, right: 0, bottom: 0 },
    }}
  >
    <QueryClientProvider client={testQueryClient}>
      {children}
      <PortalHost />
    </QueryClientProvider>
  </SafeAreaProvider>
);
