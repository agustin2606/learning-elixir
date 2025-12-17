def ask_for_index(options) do
  answer =
    options
    |> display_options
    |> generate_question
    |> Shell.prompt()
    |> Integer.parse()

  case answer do
    :error ->
      display_invalid_option()
      ask_for_index(options)

    {option, _} ->
      option - 1
  end
end

def display_invalid_option do
  Shell.cmd("clear")
  Shell.error("Invalid option.")
  Shell.prompt("Press Enter to try again.")
  Shell.cmd("clear")
end
