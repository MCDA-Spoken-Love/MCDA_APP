/**
 * Learn more about light and dark modes:
 * https://docs.expo.dev/guides/color-schemes/
 */

import { THEME } from "@/lib/theme";
import { useColorScheme } from "@/hooks/use-color-scheme";

export function useTheme() {
  const scheme = useColorScheme();
  const theme = scheme === "unspecified" ? "light" : scheme;

  // TODO: handle dark theme
  return THEME["light"];
}
