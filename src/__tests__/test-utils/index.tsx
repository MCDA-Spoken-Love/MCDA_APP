import { ReactNode } from "react";
import { QueryClientProvider } from "@tanstack/react-query";
import { testQueryClient } from "../../../jest.setup";

export const wrapper = ({ children }: { children: ReactNode }) => (
  <QueryClientProvider client={testQueryClient}>{children}</QueryClientProvider>
);
