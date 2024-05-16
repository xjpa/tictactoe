open Types
open Board

let rec get_move () =
  print_string "Enter row and column (0, 1, or 2) separated by a space: ";
  let line = read_line () in
  match String.split_on_char ' ' line with
  | [row; col] -> (int_of_string row, int_of_string col)
  | _ -> 
    print_endline "Invalid input. Try again.";
    get_move ()

let rec game_loop board player =
  print_board board;
  let game_state = 
    if check_win board then Win player
    else if check_draw board then Draw
    else Ongoing
  in
  match game_state with
  | Win p -> Printf.printf "Player %s wins!\n" (if p = X then "X" else "O")
  | Draw -> print_endline "It's a draw!"
  | Ongoing ->
    let new_board = 
      if player = O then
        match ai_move board player with
        | Some b -> b
        | None -> board
      else
        let (row, col) = get_move () in
        make_move board player row col
    in
    game_loop new_board (if player = X then O else X)
