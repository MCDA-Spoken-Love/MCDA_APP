import * as SecureStore from "expo-secure-store";
import { Platform } from "react-native";

export const saveData = async (key: string, value: any) => {
  try {
    const stringValue =
      typeof value === "string" ? value : JSON.stringify(value);

    if (Platform.OS === "web") {
      localStorage.setItem(key, stringValue);
    } else {
      await SecureStore.setItemAsync(key, stringValue);
    }
  } catch (e) {
    console.error("Error saving data", e);
  }
};

export const getData = async (key: string) => {
  try {
    let value: string | null;

    if (Platform.OS === "web") {
      value = localStorage.getItem(key);
    } else {
      value = await SecureStore.getItemAsync(key);
    }

    if (value == null) return null;

    const firstChar = value.trim()[0];
    if (
      ["{", "[", '"'].includes(firstChar) ||
      value === "true" ||
      value === "false" ||
      value === "null" ||
      !isNaN(Number(value))
    ) {
      return JSON.parse(value);
    }
    return value;
  } catch (e) {
    console.error("Error reading data", e);
    return null;
  }
};
