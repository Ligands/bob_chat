defmodule BobChat do
  @moduledoc """
  Documentation for `BobChat`.
  
  The BobChat server returns a simple HTML form when requesting any URL other than '/request'.
  The form will submit a GET request to the /request URI, which will also return the question & Bob's response, according to the following rules:
  - if request ends in a question mark, respond 'Sure.'
  - if request contains all capitals, respond 'Whoa, chill out!'
  - if request contains all capitals AND ends in a question mark, respond 'Calm down, I know what I'm doing!'
  - if request contains no text, respond 'Fine. Be that way!'
  - otherwise, respond 'Whatever.'
  """
  
  require EEx
  EEx.function_from_file :defp, :template_index, "templates/index.eex", [:question, :response]
  
  def init(default_opts) do
    IO.puts "initializing BobChat..."
    default_opts
  end

  def call(conn, _opts) do
    route(conn.method, conn.path_info, conn)
  end
  
  def route("GET", ["request"], conn) do
    # requested response
    query = parse(conn).params["q"]
    resp = response(query)
    IO.puts "Question: '" <> query <> "', Response: '" <> resp <> "'"
    conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, template_index(query, resp))
  end

  def route(_method, _path, conn) do
    # default route: load index with no question
    conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, template_index("", ""))
  end
  
  @doc """
  Bob's response logic.

  ## Examples
      iex> BobChat.response("hello")
      "Whatever."
  """
  def response(question) do
    question = String.trim(question)
    cond do
      question == "" ->
        "Fine. Be that way!"
      String.ends_with?(question, "?") && upcase?(question) ->
        "Calm down, I know what I'm doing!"
      String.ends_with?(question, "?") ->
        "Sure."
      upcase?(question) ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end
  
  @doc """
  Simple helper function to test if a string contains only uppercase letters.

  ## Examples
      iex> BobChat.upcase?("Hello")
      :false
      
      iex> BobChat.upcase?("HELLO")
      :true
  """
  def upcase?(str) do str == String.upcase(str) end
  
  def parse(conn, opts \\ []) do
    opts = Keyword.put_new(opts, :parsers, [Plug.Parsers.URLENCODED, Plug.Parsers.MULTIPART])
    Plug.Parsers.call(conn, Plug.Parsers.init(opts))
  end
end