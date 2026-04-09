import { UrlSignature } from "@/types";

export const presignedImageUpload = async (
  signedParams: UrlSignature,
  fileUri: string,
): Promise<{ secure_url: string }> => {
  const cloudName = process.env.EXPO_PUBLIC_CLOUDINARY_CLOUD_NAME;
  const apiKey = process.env.EXPO_PUBLIC_CLOUDINARY_API_KEY;
  if (!cloudName || !apiKey) {
    throw new Error("Cloudinary credentials are not configured");
  }

  const formData = new FormData();
  // @ts-ignore
  formData.append("file", {
    uri: fileUri,
    type: "image/jpeg",
    name: "upload.jpg",
  });

  formData.append("folder", signedParams.folder);
  formData.append("public_id", signedParams.public_id);
  formData.append("timestamp", signedParams.timestamp.toString());
  formData.append("signature", signedParams.signature);
  formData.append("api_key", apiKey);

  const uploadUrl = `https://api.cloudinary.com/v1_1/${cloudName}/image/upload`;

  const res = await fetch(uploadUrl, {
    method: "POST",
    body: formData,
  });

  if (!res.ok) {
    const errorText = await res.text();
    console.error("Cloudinary upload error:", errorText);
  }

  return await res.json();
};
