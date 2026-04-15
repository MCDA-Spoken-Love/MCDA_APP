import { View } from "react-native";
import { SheetInput } from "@/components/ui/sheet-input";
import { Label } from "@/components/ui/label";
import { Controller, useFormContext } from "react-hook-form";
import { SignupSchemaType } from "@/features/auth/signup/constants/schema";
import { ErrorText } from "@/components/ui/error-text";

export const NameAndUser = () => {
  const formMethods = useFormContext<SignupSchemaType>();

  return (
    <View
      className={"flex-col items-center justify-center gap-4"}
      testID={"name-and-user-step"}
    >
      <View className={"gap-1 flex-col w-full"}>
        <Label className={"font-coiny text-2xl font-medium"}>
          Diga seu nome
        </Label>
        <View className={"gap-1 flex-col w-full"}>
          <Controller
            control={formMethods.control}
            name="first_name"
            render={({
              field: { onChange, onBlur, value },
              fieldState: { error },
            }) => (
              <View>
                <SheetInput
                  value={value}
                  onChangeText={onChange}
                  onBlur={onBlur}
                  keyboardType="name-phone-pad"
                  textContentType="givenName"
                  autoComplete="given-name"
                  placeholder="Primeiro nome"
                  aria-label={"given name"}
                  testID={"first-name-input"}
                />
                {error && <ErrorText error={error} fieldName={"first_name"} />}
              </View>
            )}
          />
        </View>
        <View className={"gap-1 flex-col w-full"}>
          <Controller
            control={formMethods.control}
            name="last_name"
            render={({
              field: { onChange, onBlur, value },
              fieldState: { error },
            }) => (
              <View className="gap-1">
                <SheetInput
                  value={value}
                  onChangeText={onChange}
                  onBlur={onBlur}
                  keyboardType="name-phone-pad"
                  textContentType="familyName"
                  autoComplete="family-name"
                  placeholder="Sobrenome"
                  aria-label={"family name"}
                  testID={"last-name-input"}
                />
                {error && <ErrorText error={error} fieldName={"last_name"} />}
              </View>
            )}
          />
        </View>
      </View>
      <View className={"gap-1 flex-col w-full"}>
        <Label className={"font-coiny text-2xl font-medium"}>
          Seu username
        </Label>
        <Controller
          control={formMethods.control}
          name="username"
          render={({
            field: { onChange, onBlur, value },
            fieldState: { error },
          }) => (
            <View className="gap-1">
              <SheetInput
                value={value}
                onChangeText={onChange}
                onBlur={onBlur}
                keyboardType="name-phone-pad"
                textContentType="username"
                autoComplete="username"
                placeholder="Nome de usuário"
                aria-label={"username"}
                testID={"username-input"}
              />
              {error && <ErrorText error={error} fieldName={"username"} />}
            </View>
          )}
        />
      </View>
    </View>
  );
};
