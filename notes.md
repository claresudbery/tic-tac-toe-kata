# Performance

- The test for scoring an empty grid consistently took around 1.2 seconds with the `while` loop in `Intelligence.get_minimax_score`. 
    - With the `each` loop used instead, it took 6.7 seconds. 
        - Also, the whole test suite took 17 seconds instead of 3 seconds.
    - With the new `find_instant_winning_move` method in place, it took about 1.15 seconds.
        - The whole test suite was also slightly quicker - at 2.57 seconds instead of 2.9 (and with 3 extra tests).
- The test for choosing the first winning move for the grid in diagram F consistently took around 0.016 seconds with the `each` loop at the top level in `Intelligence.choose_move_using_unbeatable_ai`.
    - Replacing the `each` loop with a `while` loop reduced the time to an average of 0.011.