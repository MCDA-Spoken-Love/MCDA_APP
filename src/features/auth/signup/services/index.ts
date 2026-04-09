import { SignupSchemaType } from "@/features/auth/signup/constants/schema";
import { api } from "@/http/api-client";
import { UrlSignature } from "@/types";
import { presignedImageUpload } from "@/lib/cloudinary";

export const signupServices = {
  signup: async function (signupData: SignupSchemaType) {
    delete signupData.profile_picture;

    const response = await api.post("/api/auth/registration/", signupData);
    return response.data;
  },
  presignProfilePictureUpload: async function (
    file_name: string,
    folder_name: string,
  ) {
    const response = await api.post("/api/global/image/presign/", {
      file_name,
      folder_name,
    });
    return response.data;
  },
  uploadPresignedProfilePicture: async function (
    signedParams: UrlSignature,
    profilePictureUri: string,
  ) {
    return await presignedImageUpload(signedParams, profilePictureUri);
  },
  updateUserWithProfilePicture: async function (profilePictureUrl: string) {
    const response = await api.patch("/api/user/", {
      profile_picture: profilePictureUrl,
    });
    return response.data;
  },
};
