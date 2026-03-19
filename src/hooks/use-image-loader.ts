import { useImage } from "expo-image";

export const useImageLoader = (imagePath: string) => {
  return useImage(require("../../assets/images/" + imagePath));
};
