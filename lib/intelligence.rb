require_relative './utils'

class Intelligence
    WE_WIN = 1
    DRAW = 0
    THEY_WIN = -1

    def initialize
        @win_finder = WinFinder.new
    end

    def choose_move(grid, current_player, opponent = MyApp::DEFAULT_OPPONENT_SYMBOL)
        choose_move_using_unbeatable_ai(grid, current_player, opponent)
    end

    def choose_easy_move(grid, current_player, opponent = MyApp::DEFAULT_OPPONENT_SYMBOL)
        choose_move_using_beatable_ai(grid, current_player, opponent)
    end

    def get_minimax_score(grid, current_player, opponent)
        winner = @win_finder.get_winner(grid)
        if !winner.nil?
            score = (winner == current_player) ? WE_WIN : THEY_WIN
        else
            if grid.is_full
                score = DRAW
            else   
                score = find_best_move_recursively(grid, current_player, opponent)[:score]
            end
        end
        score
    end

    private 

    def no_more_moves_to_play(empty_spaces) 
        empty_spaces.empty? 
    end

    def choose_move_using_unbeatable_ai(grid, current_player, opponent)
        interrim_result = find_best_move_recursively(grid, current_player, opponent)
        check_to_see_if_we_can_prevent_a_loss_more_quickly(interrim_result, grid, opponent)
    end

    def check_to_see_if_we_can_prevent_a_loss_more_quickly(interrim_result, grid, opponent)
        best_move = interrim_result[:best_move]

        if (interrim_result[:score] == THEY_WIN)
            empty_spaces = grid.empty_spaces_no_exception
            instant_opponent_win = find_instant_winning_move(grid, empty_spaces, opponent)
            if !instant_opponent_win.nil?
                best_move = instant_opponent_win
            end
        end

        best_move
    end

    def find_best_move_recursively(grid, current_player, opponent)
        empty_spaces = grid.empty_spaces_no_exception

        instant_winning_move = find_instant_winning_move(grid, empty_spaces, current_player)
        if !instant_winning_move.nil?
            result = { score: WE_WIN, best_move: instant_winning_move }
        else
            result = find_first_good_move(empty_spaces, grid, current_player, opponent)
        end

        result
    end

    def find_first_good_move(empty_spaces, grid, current_player, opponent)
        score = -2
        index = 0
        found_a_winning_move = false

        while !found_a_winning_move && index < empty_spaces.length do
            test_grid = grid.copy
            test_grid.play_move(empty_spaces[index], current_player)
            temp_score = get_opponent_score_and_invert_it(Grid.new(test_grid.cells), opponent, current_player)
            found_a_winning_move = temp_score == WE_WIN ? true : false
            if (temp_score > score)
                score = temp_score
                best_move = empty_spaces[index]
            end
            index = index + 1
        end

        { score: score, best_move: best_move }
    end

    def find_instant_winning_move(grid, empty_spaces, current_player)
        instant_winning_move = nil

        index = 0
        found_instant_win = false
        while !found_instant_win && index < empty_spaces.length do
            test_grid = grid.copy
            test_grid.play_move(empty_spaces[index], current_player)
            if (@win_finder.get_winner(Grid.new(test_grid.cells)) == current_player)
                found_instant_win = true
                instant_winning_move = empty_spaces[index]
            end
            index = index + 1
        end

        instant_winning_move
    end

    def get_opponent_score_and_invert_it(test_grid, opponent, current_player)
        -1 * get_minimax_score(test_grid, opponent, current_player)
    end

    def choose_move_using_beatable_ai(grid, current_player, opponent)
        empty_spaces = grid.empty_spaces

        chosen_move = find_winning_move(grid, empty_spaces, current_player)

        if (chosen_move.nil?)
            chosen_move = stop_opponent_winning(grid, empty_spaces, opponent)
        end

        if (chosen_move.nil?)
            chosen_move = just_pick_the_next_empty_spot(empty_spaces)
        end

        chosen_move
    end

    def stop_opponent_winning(grid, empty_spaces, opponent)
        find_winning_move(grid, empty_spaces, opponent)
    end

    def just_pick_the_next_empty_spot(empty_spaces)
        empty_spaces[0]
    end

    def find_winning_move(grid, empty_spaces, player)
        chosen_move = nil

        empty_spaces.each do |empty_space|
            test_grid = grid.copy
            test_grid.play_move(empty_space, player)
            if @win_finder.get_winner(Grid.new(test_grid.cells)) == player
                chosen_move = empty_space
            end
        end

        chosen_move
    end
end