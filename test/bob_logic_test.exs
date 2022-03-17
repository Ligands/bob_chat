defmodule BobChatTest do
  use ExUnit.Case
    
  # Bob answers 'Sure.' if you ask him a question, such as "How are you?".
  test "Ask Bob a question" do
    assert BobChat.response("How are you?") == "Sure."
  end
  
  # He answers 'Whoa, chill out!' if you YELL AT HIM (in all capitals).
  test "Yell at Bob" do
    assert BobChat.response("YELL AT HIM") == "Whoa, chill out!"
  end
  
  # He answers 'Calm down, I know what I'm doing!' if you yell a question at him.
  test "Yell a question at Bob" do
    assert BobChat.response("YELLING A QUESTION?") == "Calm down, I know what I'm doing!"
  end
  
  # He says 'Fine. Be that way!' if you address him without actually saying anything.
  test "Address Bob without saying anything" do
    assert BobChat.response("") == "Fine. Be that way!"
  end
  
  # He answers 'Whatever.' to anything else
  test "Say anything else to Bob (besides a question or yelling)" do
    assert BobChat.response("anything else") == "Whatever."
  end
  
  
  
  # 'Yelling' = only uppercase letters; doesn't count as yelling if there are no letters
  test "This is not yelling" do
    assert BobChat.yelling?("Not yelling") == false
  end
  
  test "THIS IS YELLING!" do
    assert BobChat.yelling?("YELLING")
  end
  
  test "YELL WITH NUMBERS & SYMBOLS" do
    assert BobChat.yelling?("TEST 1234 !@#$")
  end
  
  test "Numbers alone are not yelling" do
    assert BobChat.yelling?("1234") == false
  end
  
  test "Saying nothing is not yelling" do
    assert BobChat.yelling?("") == false
  end
  
  
  doctest BobChat
end
