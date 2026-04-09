import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";
import Toast from "react-native-toast-message";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

export const showToast = ({
  type,
  title,
  description = "",
  position = "top",
}: {
  type: "success" | "info" | "error";
  title: string;
  description?: string;
  position?: "top" | "bottom";
}) => {
  Toast.show({
    position,
    type,
    text1: title,
    text1Style: {
      fontSize: 14,
    },
    text2: description || "",
    text2Style: {
      fontSize: 10,
    },
  });
};

export const generateUniqueFilename = (uri: string): string => {
  const timestamp = Date.now();
  const randomStr = Math.random().toString(36).substring(2, 8);
  const extension = uri.split(".").pop() || "jpg";
  return `profile_${timestamp}_${randomStr}.${extension}`;
};
