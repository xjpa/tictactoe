type player = X | O
type cell = Empty | Taken of player
type board = cell list list
type game_state = Ongoing | Win of player | Draw
