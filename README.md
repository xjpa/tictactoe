learning functional programming with ocaml by coding tictactoe

really basic AI, as the purpose was just to have something to test the game with

to run

```
dune build
```

```
dune exec ./src/main.exe
```

a good todo would be to implement a real AI logic like minmax algorithm or something. maybe for another time.

learned some functional programming here:

- emphasized immutability like in `make_move`
- lots of pure functions like `check_win` and `check_draw` just takes input + returns w/o modifying state
- use of higher order functions like with `list.mapi` and `list.exists`
- utilises a common feature popular with functional programming which is extensive pattern matching like with `get_move` and especially `check_win`
- and of course, recursion like with `find_move` and `game_loop`
