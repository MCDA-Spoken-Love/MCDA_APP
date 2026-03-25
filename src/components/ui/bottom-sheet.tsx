import BottomSheet, { BottomSheetView } from "@gorhom/bottom-sheet";
import { BottomSheetProps } from "@gorhom/bottom-sheet/src";
import { cn } from "@/lib/utils";
import { useEffect } from "react";
import { Keyboard } from "react-native";
import { BottomSheetMethods } from "@gorhom/bottom-sheet/src/types";

interface SheetProps extends BottomSheetProps {
  className?: string;
  hasHandle?: boolean;
  sheetRef?: React.RefObject<BottomSheetMethods>;
}

export const Sheet = ({
  onChange,
  hasHandle = true,
  backgroundStyle,
  children,
  handleIndicatorStyle,
  handleStyle,
  className,
  sheetRef,
}: SheetProps) => {
  useEffect(() => {
    if (!sheetRef?.current) return;

    const sub = Keyboard.addListener("keyboardDidHide", () => {
      sheetRef.current?.snapToIndex(0);
    });
    return () => sub.remove();
  }, [sheetRef]);

  return (
    <BottomSheet
      ref={sheetRef}
      onChange={onChange}
      keyboardBehavior="interactive"
      keyboardBlurBehavior="restore"
      backgroundStyle={
        backgroundStyle ?? {
          backgroundColor: "white",
          borderTopLeftRadius: 24,
          borderTopRightRadius: 24,
          overflow: "hidden",
        }
      }
      handleIndicatorStyle={
        hasHandle ? (handleIndicatorStyle ?? undefined) : { display: "none" }
      }
      handleStyle={hasHandle ? (handleStyle ?? undefined) : { display: "none" }}
    >
      <BottomSheetView
        className={cn(
          className,
          "z-50 flex-1 p-8 rounded-tl-3xl rounded-tr-3xl",
        )}
      >
        {children}
      </BottomSheetView>
    </BottomSheet>
  );
};
