defmodule BobLogic do
  @moduledoc """
  Bob's response logic.
  
  Bob is a lackadaisical teenager. In conversation, his responses are very limited:
  - Bob answers 'Sure.' if you ask him a question, such as "How are you?"
  - He answers 'Whoa, chill out!' if you YELL AT HIM (in all capitals).
  - He answers 'Calm down, I know what I'm doing!' if you yell a question at him
  - He says 'Fine. Be that way!' if you address him without actually saying anything
  - He answers 'Whatever.' to anything else
  """
  
  #################
  # Bobby Logic
  ###############
  
  @doc """
  Returns Bob's response to the given string, as per the above rules.
  
  ## Examples
      iex> BobLogic.response("hello world")
      "Whatever."
      
      iex> BobLogic.response("HELLO WORLD")
      "Whoa, chill out!"
  """
  def response(query) do
    query = String.trim(query)
    cond do
      query == "" ->
        "Fine. Be that way!"
      String.ends_with?(query, "?") && yelling?(query) ->
        "Calm down, I know what I'm doing!"
      String.ends_with?(query, "?") ->
        "Sure."
      yelling?(query) ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end
  
  @doc """
  Helper function to check for 'yelling'; tests if a string contains only uppercase letters.
  Returns false if a string contains any lowercase letters, or no (English) letters at all.

  ## Examples
      iex> BobLogic.yelling?("YELLING!")
      :true
      
      iex> BobLogic.yelling?("Not yelling.")
      :false
  """
  def yelling?(str) do
    str == String.upcase(str) && String.match?(str, ~r([a-zA-Z]+))
  end
end