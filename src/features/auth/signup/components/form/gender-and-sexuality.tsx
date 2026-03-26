import { Platform, View } from "react-native";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Controller, useFormContext } from "react-hook-form";
import { SignupSchemaType } from "@/features/auth/signup/constants/schema";
import {
  genderList,
  sexualityList,
} from "@/features/auth/signup/constants/options";
import { ErrorText } from "@/components/ui/error-text";
import { useSafeAreaInsets } from "react-native-safe-area-context";

export const GenderAndSexuality = () => {
  const formMethods = useFormContext<SignupSchemaType>();
  const {
    formState: { errors },
  } = formMethods;
  const insets = useSafeAreaInsets();
  const contentInsets = {
    top: insets.top,
    bottom: Platform.select({
      ios: insets.bottom,
      android: insets.bottom + 24,
    }),
    left: 12,
    right: 12,
  };

  return (
    <View className={"flex-col items-center justify-center gap-4"}>
      <View className={"gap-1 flex-col w-full"}>
        <Label className={"font-coiny text-2xl font-medium"}>
          Sua identidade de gênero
        </Label>

        <Controller
          control={formMethods.control}
          name="gender"
          render={({ field: { onChange, value } }) => (
            <Select
              value={genderList.find((item) => item.value === value)}
              onValueChange={(option) => onChange(option?.value)}
            >
              <SelectTrigger className="w-full">
                <SelectValue placeholder="Selecione seu gênero" />
              </SelectTrigger>
              <SelectContent insets={contentInsets} className="w-[180px]">
                <SelectGroup>
                  {genderList.map((item) => (
                    <SelectItem
                      key={item.value}
                      value={item.value}
                      label={item.label}
                    />
                  ))}
                </SelectGroup>
              </SelectContent>
            </Select>
          )}
        />

        {errors?.gender && <ErrorText errors={errors} fieldName={"gender"} />}
      </View>

      <View className={"gap-1 flex-col w-full"}>
        <Label className={"font-coiny text-2xl font-medium"}>
          E sua sexualidade
        </Label>

        <Controller
          control={formMethods.control}
          name="sexuality"
          render={({ field: { onChange, value } }) => (
            <Select
              value={sexualityList.find((item) => item.value === value)}
              onValueChange={(option) => onChange(option?.value)}
            >
              <SelectTrigger className="w-full">
                <SelectValue placeholder="Selecione sua sexualidade" />
              </SelectTrigger>
              <SelectContent insets={contentInsets} className="w-[180px]">
                <SelectGroup>
                  {sexualityList.map((item) => (
                    <SelectItem
                      key={item.value}
                      value={item.value}
                      label={item.label}
                    />
                  ))}
                </SelectGroup>
              </SelectContent>
            </Select>
          )}
        />

        {errors?.sexuality && (
          <ErrorText errors={errors} fieldName={"sexuality"} />
        )}
      </View>
    </View>
  );
};
