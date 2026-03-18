import { render } from "@testing-library/react-native";
import TestEx, { CustomText } from "@/app/TestEx";

describe("<HomeScreen />", () => {
  test("Text renders correctly on HomeScreen", () => {
    const { getByText } = render(<TestEx />);

    getByText("Welcome!");
  });

  test("CustomText renders correctly", () => {
    const tree = render(<CustomText>Some text</CustomText>).toJSON();

    expect(tree).toMatchSnapshot();
  });
});
