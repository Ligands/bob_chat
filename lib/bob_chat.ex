defmodule BobChat do
  @moduledoc """
  Documentation for `BobChat`.
  
  The BobChat server returns a simple HTML form when requesting any URL other than '/request'.
  The form submits a GET request to the /request URI, which will return the form along with the question & Bob's response attached.
  """
  require EEx
  EEx.function_from_file :defp, :template_index, "templates/index.eex", [:question, :response]
  
  def init(default_opts) do
    IO.puts "Initializing BobChat..."
    default_opts
  end
  
  
  #############
  # Routing
  ###########
  
  def call(conn, _opts) do
    route(conn.method, conn.path_info, conn)
  end
  
  # /request: speak to bob, request a response
  def route("GET", ["request"], conn) do
    query = parse(conn).params["q"]
    resp = BobLogic.response(query)
    IO.puts "Question: '" <> query <> "', Response: '" <> resp <> "'"
    conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, template_index(query, resp))
  end

  # default: load index with no response
  def route(_method, _path, conn) do
    conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, template_index("", ""))
  end
  
  @doc """
  Helper function to extract the formdata (query parameters) from the URL of an HTTP connection.
  Returns a map of query parameter names to values.
  https://stackoverflow.com/a/34961570
  """
  def parse(conn, opts \\ []) do
    opts = Keyword.put_new(opts, :parsers, [Plug.Parsers.URLENCODED, Plug.Parsers.MULTIPART])
    Plug.Parsers.call(conn, Plug.Parsers.init(opts))
  end
end