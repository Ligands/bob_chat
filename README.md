# BobChat

A simple HTTP webserver written in Elixir to simulate responses from 'Bob'.  
(Very lightweight- does not require Phoenix or any other heavy framework; 'plug_cowboy' is the sole project dependency.)

---

Bob is a lackadaisical teenager. In conversation, his responses are very limited:
 - Bob answers 'Sure.' if you ask him a question, such as "How are you?"
 - He answers 'Whoa, chill out!' if you YELL AT HIM (in all capitals).
 - He answers 'Calm down, I know what I'm doing!' if you yell a question at him
 - He says 'Fine. Be that way!' if you address him without actually saying anything
 - He answers 'Whatever.' to anything else

---

## Requirements

1. Elixir (1.13+)
2. Any web browser
3. Port 4000 must not be in use

## Installation

1. Clone the project:

`git clone git@github.com:Ligands/bob_chat.git`

2. Get project dependencies:

`cd bob_chat`  
`mix deps.get`

## Running

1. Start the BobChat Server by running the startup script from the project directory relevant to your operating system:

- *Windows:* `start.bat`
- *\*nix:* `start.sh`

2. Navigate to http://localhost:4000/ and say something to Bob!

## Tests

This project uses a combination of ExUnit unit tests as well as a handful of Elixir's 'doctests' to confirm the business logic & helper functions are working as expected.

1. Use the following command in the project directory to execute the tests:

`mix test`
