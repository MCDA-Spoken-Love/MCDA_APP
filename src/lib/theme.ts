import { DarkTheme, DefaultTheme, type Theme } from "@react-navigation/native";
import { Platform } from "react-native";

export const THEME = {
  light: {
    background: "hsl(220, 13.04%, 90.98%)",
    foreground: "hsl(0, 0%, 3.53%)",
    card: "hsl(0 0% 100%)",
    cardForeground: "hsl(0 0% 3.9%)",
    popover: "hsl(0 0% 100%)",
    popoverForeground: "hsl(0 0% 3.9%)",
    primary: "hsl(260.87, 28.16%, 51.96%)",
    primaryForeground: "hsl(0, 0%, 100%)",
    secondary: "hsl(325.6, 41.9%, 64.9%)",
    secondaryForeground: "hsl(0, 0%, 100%)",
    success: "hsl(156.62, 100%, 30.2%)",
    successForeground: "hsl(0, 0%, 100%)",
    muted: "hsl(0 0% 96.1%)",
    mutedForeground: "hsl(0 0% 45.1%)",
    accent: "hsl(48.53, 57.63%, 76.86%)",
    accentForeground: "hsl(0 0% 9%)",
    destructive: "hsl(0, 96.49%, 66.47%)",
    destructiveForeground: "hsl(0, 0%, 100%)",
    border: "hsl(0 0% 89.8%)",
    input: "hsl(0 0% 89.8%)",
    ring: "hsl(0 0% 63%)",
    radius: "1rem",
    chart1: "hsl(12 76% 61%)",
    chart2: "hsl(173 58% 39%)",
    chart3: "hsl(197 37% 24%)",
    chart4: "hsl(43 74% 66%)",
    chart5: "hsl(27 87% 67%)",
  },
  dark: {
    background: "hsl(0 0% 3.9%)",
    foreground: "hsl(0 0% 98%)",
    card: "hsl(0 0% 3.9%)",
    cardForeground: "hsl(0 0% 98%)",
    popover: "hsl(0 0% 3.9%)",
    popoverForeground: "hsl(0 0% 98%)",
    primary: "hsl(260.87, 28.16%, 51.96%)",
    primaryForeground: "hsl(0, 0%, 100%)",
    secondary: "hsl(325.6, 41.9%, 64.9%)",
    secondaryForeground: "hsl(0, 0%, 100%)",
    success: "hsl(156.62, 100%, 30.2%)",
    successForeground: "hsl(0, 0%, 100%)",
    muted: "hsl(0 0% 14.9%)",
    mutedForeground: "hsl(0 0% 63.9%)",
    accent: "hsl(48.53, 57.63%, 76.86%)",
    accentForeground: "hsl(0 0% 9%)",
    destructive: "hsl(0, 96.49%, 66.47%)",
    destructiveForeground: "hsl(0, 0%, 100%)",
    border: "hsl(0 0% 14.9%)",
    input: "hsl(0 0% 14.9%)",
    ring: "hsl(300 0% 45%)",
    radius: "1rem",
    chart1: "hsl(220 70% 50%)",
    chart2: "hsl(160 60% 45%)",
    chart3: "hsl(30 80% 55%)",
    chart4: "hsl(280 65% 60%)",
    chart5: "hsl(340 75% 55%)",
  },
};

export const Colors = {
  light: {
    background: THEME.light.background,
    backgroundElement: THEME.light.secondary,
    backgroundSelected: THEME.light.muted,
    border: THEME.light.border,
    card: THEME.light.card,
    primary: THEME.light.primary,
    text: THEME.light.foreground,
    textSecondary: THEME.light.mutedForeground,
  },
  dark: {
    background: THEME.dark.background,
    backgroundElement: THEME.dark.secondary,
    backgroundSelected: THEME.dark.muted,
    border: THEME.dark.border,
    card: THEME.dark.card,
    primary: THEME.dark.primary,
    text: THEME.dark.foreground,
    textSecondary: THEME.dark.mutedForeground,
  },
} as const;

export type ThemeName = keyof typeof Colors;
export type ThemeColor = keyof (typeof Colors)["light"];

export const Fonts = Platform.select({
  ios: {
    mono: "Courier",
  },
  android: {
    mono: "monospace",
  },
  web: {
    mono: "monospace",
  },
  default: {
    mono: "monospace",
  },
})!;

export const Spacing = {
  half: 2,
  one: 4,
  two: 8,
  three: 12,
  four: 16,
  five: 20,
  six: 24,
} as const;

export const BottomTabInset = Platform.OS === "ios" ? 34 : 0;

export const MaxContentWidth = 960;

export const NAV_THEME: Record<"light" | "dark", Theme> = {
  light: {
    ...DefaultTheme,
    colors: {
      background: THEME.light.background,
      border: THEME.light.border,
      card: THEME.light.card,
      notification: THEME.light.destructive,
      primary: THEME.light.primary,
      text: THEME.light.foreground,
    },
  },
  dark: {
    ...DarkTheme,
    colors: {
      background: THEME.dark.background,
      border: THEME.dark.border,
      card: THEME.dark.card,
      notification: THEME.dark.destructive,
      primary: THEME.dark.primary,
      text: THEME.dark.foreground,
    },
  },
};
