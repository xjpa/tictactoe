open Types

let empty_board () : board = 
  [[Empty; Empty; Empty];
   [Empty; Empty; Empty];
   [Empty; Empty; Empty]]

let print_cell = function
  | Empty -> print_string " "
  | Taken X -> print_string "X"
  | Taken O -> print_string "O"

let print_board (board : board) =
  let print_row row =
    List.iter (fun cell -> print_cell cell; print_string "|") row;
    print_newline ()
  in
  List.iter print_row board;
  print_newline ()

let check_win (board : board) =
  let lines = [
    (* Rows *)
    [List.nth (List.nth board 0) 0; List.nth (List.nth board 0) 1; List.nth (List.nth board 0) 2];
    [List.nth (List.nth board 1) 0; List.nth (List.nth board 1) 1; List.nth (List.nth board 1) 2];
    [List.nth (List.nth board 2) 0; List.nth (List.nth board 2) 1; List.nth (List.nth board 2) 2];
    (* Columns *)
    [List.nth (List.nth board 0) 0; List.nth (List.nth board 1) 0; List.nth (List.nth board 2) 0];
    [List.nth (List.nth board 0) 1; List.nth (List.nth board 1) 1; List.nth (List.nth board 2) 1];
    [List.nth (List.nth board 0) 2; List.nth (List.nth board 1) 2; List.nth (List.nth board 2) 2];
    (* Diagonals *)
    [List.nth (List.nth board 0) 0; List.nth (List.nth board 1) 1; List.nth (List.nth board 2) 2];
    [List.nth (List.nth board 0) 2; List.nth (List.nth board 1) 1; List.nth (List.nth board 2) 0]
  ] in
  List.exists (fun line -> match line with
    | [Taken X; Taken X; Taken X] -> true
    | [Taken O; Taken O; Taken O] -> true
    | _ -> false
  ) lines

let check_draw (board : board) =
  List.for_all (List.for_all (fun cell -> cell <> Empty)) board

let make_move (board : board) player row col =
  let update_row r =
    List.mapi (fun c cell -> if r = row && c = col then Taken player else cell)
  in
  List.mapi (fun r row -> update_row r row) board

let ai_move (board : board) player =
  let rec find_move row col = function
    | [] -> None
    | _::rs when col = 3 -> find_move (row + 1) 0 rs
    | r::rs when row < 3 && col < 3 -> (
        match List.nth r col with
        | Empty -> Some (row, col)
        | _ -> find_move row (col + 1) (r::rs)
      )
    | _ -> None
  in
  match find_move 0 0 board with
  | Some (row, col) -> Some (make_move board player row col)
  | None -> None
