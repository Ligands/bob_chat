#!/usr/bin/env bash
iex -S mix run -e "{:ok, _} = Plug.Adapters.Cowboy.http BobChat, []"