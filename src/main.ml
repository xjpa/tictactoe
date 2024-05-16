open Types
open Board
open Game

let () =
  let initial_board = empty_board () in
  game_loop initial_board X
