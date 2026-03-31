import { Platform, View } from "react-native";
import React, { useEffect, useState } from "react";
import * as ImagePicker from "expo-image-picker";
import { Text } from "@/components/ui/text";
import { Image } from "@/components/ui/image";
import { Button } from "@/components/ui/button";
import { useCameraPermissions } from "expo-camera";
import { useFormContext } from "react-hook-form";
import { SignupSchemaType } from "@/features/auth/signup/constants/schema";
import { Label } from "@/components/ui/label";
import { Camera, ImageUp } from "lucide-react-native";

export const ProfilePicture = () => {
  const formMethods = useFormContext<SignupSchemaType>();
  const { setValue } = formMethods;

  const [image, setImage] = useState<string>("");
  const [permission, requestPermission] = useCameraPermissions();

  useEffect(() => {
    (async () => {
      if (Platform.OS === "ios") {
        const cameraRollStatus =
          await ImagePicker.requestMediaLibraryPermissionsAsync();
        const cameraStatus = await ImagePicker.requestCameraPermissionsAsync();
        if (
          cameraRollStatus.status !== "granted" ||
          cameraStatus.status !== "granted"
        ) {
          alert("Sorry, we need these permissions to make this work!");
        }
      }
    })();
  }, []);

  const takePhoto = async () => {
    let result = await ImagePicker.launchCameraAsync({
      mediaTypes: "images",
      aspect: [4, 3],
    });
    setImage(result.assets?.[0].uri as string);
    setValue("profile_picture_uri", result.assets?.[0].uri as string);
  };

  const pickImage = async () => {
    let result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: "images",
      aspect: [4, 3],
      quality: 1,
    });
    setImage(result.assets?.[0].uri as string);
    setValue("profile_picture_uri", result.assets?.[0].uri as string);
  };

  if (!permission) {
    return null;
  }

  if (!permission.granted) {
    return (
      <View className={"flex-col items-center justify-center gap-4"}>
        <Text className={"text-center"}>
          Precisamos da sua permissão para usar a câmera e acessas suas fotos
        </Text>
        <Button onPress={requestPermission}>
          <Text>Permitir uso da câmera</Text>
        </Button>
      </View>
    );
  }

  return (
    <View className={"flex-col items-center justify-center gap-4"}>
      <View className={"gap-1 flex-col w-full"}>
        <Label className={"font-coiny text-2xl font-medium"}>
          Escolha ou tire uma foto para seu perfil
        </Label>
        <Image
          source={{
            uri: image || "https://placehold.co/256x265?text=Sua+foto",
          }}
          className={"w-64 h-64 self-center rounded-3xl"}
          contentFit={"cover"}
          alt={"chosen-pic"}
        />
      </View>
      <View>
        <View className={"flex-row gap-2 self-center"}>
          <Button variant="accent" className="w-[40%]" onPress={pickImage}>
            <ImageUp />
            <Text>Escolher foto</Text>
          </Button>
          <Button variant="accent" onPress={takePhoto} className="w-[40%]">
            <Camera />
            <Text>Tirar foto</Text>
          </Button>
        </View>
      </View>
    </View>
  );
};
