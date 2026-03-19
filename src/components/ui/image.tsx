import {
  Image as ExpoImage,
  type ImageProps as ExpoImageProps,
} from "expo-image";
import { cssInterop } from "nativewind";
import React from "react";

cssInterop(ExpoImage, { className: "style" });

export const Image = (props: ExpoImageProps) => {
  return <ExpoImage {...props} />;
};
